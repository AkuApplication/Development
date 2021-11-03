import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef void StreamStateCallback(MediaStream stream);

class SignalingRTC {

  Map<String, dynamic> configuration = {
    "iceServers": [
      {
        "urls": [
          "stun:stun1.l.google.com:19302",
          "stun:stun2.l.google.com:19302",
        ]
      },
      {
        "url": "turn:numb.viagenie.ca",
        "credential": "muazkh",
        "username": "webrtc@live.com"
      }
    ]
  };

  RTCPeerConnection peerConnection;
  MediaStream localStream;
  MediaStream remoteStream;
  String roomId;
  StreamStateCallback onAddRemoteStream;

  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference roomRef = firestore.collection("videoRooms").doc();

    peerConnection = await createPeerConnection(configuration);

    registerPeerConnectionListeners();

    localStream.getTracks().forEach((track) {
      peerConnection.addTrack(track, localStream);
    });

    //Code for collecting ICE candidates below
    var callerCandidatesCollection = roomRef.collection("callerCandidates");

    peerConnection.onIceCandidate = (RTCIceCandidate candidate){
      callerCandidatesCollection.add(candidate.toMap());
    };

    //Add code for creating a room
    RTCSessionDescription offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);

    Map<String, dynamic> roomWithOffer = {"offer": offer.toMap()};
    await roomRef.set(roomWithOffer);
    var roomId = roomRef.id;

    //
    peerConnection.onTrack = (RTCTrackEvent event) {
      event.streams[0].getTracks().forEach((track) {
        remoteStream.addTrack(track);
      });
    };

    // Listening for remote session description below
    roomRef.snapshots().listen((event) async {
      Map<String, dynamic> dataFromFirebase = event.data() as Map<String, dynamic>;
      if(peerConnection.getRemoteDescription() != null &&
        dataFromFirebase["answer"] != null){
        var answer = RTCSessionDescription(
            dataFromFirebase["answer"]["sdp"],
            dataFromFirebase["answer"]["type"],
        );

        await peerConnection.setRemoteDescription(answer);
      } else {
        return null;
      }
    });
    
    //Listen for remote ICE candidates below
    roomRef.collection("calledCandidates").snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if(element.type == DocumentChangeType.added) {
          Map<String, dynamic> dataFirebase = element.doc.data();
          peerConnection.addCandidate(
            RTCIceCandidate(
              dataFirebase["candidate"],
              dataFirebase["sdpMid"],
              dataFirebase["sdpMLineIndex"],
            ),
          );
        }
      });
    });

    return roomId;
  }

  Future<void> joinRoom(String roomId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference roomRef = firestore.collection("videoRooms").doc(roomId);
    var roomSnapshot = await roomRef.get();

    if(roomSnapshot.exists) {
      peerConnection = await createPeerConnection(configuration);

      registerPeerConnectionListeners();

      localStream.getTracks().forEach((track) {
        peerConnection.addTrack(track, localStream);
      });

      //Code for collecting ICE candidates below
      var calledCandidatesCollection = roomRef.collection("calledCandidates");

      peerConnection.onIceCandidate = (RTCIceCandidate candidate){
        calledCandidatesCollection.add(candidate.toMap());
      };

      //
      peerConnection.onTrack = (RTCTrackEvent event) {
        event.streams[0].getTracks().forEach((track) {
          remoteStream.addTrack(track); //this part ada problem
        });
      };

      //Code for creating SDP answer below
      var data = roomSnapshot.data() as Map<String, dynamic>;
      var offer = data["offer"];
      await peerConnection.setRemoteDescription(
        RTCSessionDescription(
          offer["sdp"],
          offer["type"],
        ),
      );
      var answer = await peerConnection.createAnswer();

      await peerConnection.setLocalDescription(answer);

      Map<String, dynamic> roomWithAnswer = {
        "answer": {
          "type": answer.type,
          "sdp": answer.sdp,
        }
      };

      await roomRef.update(roomWithAnswer);

      //Listening for remote ICE candidates below
      roomRef.collection("callerCandidates").snapshots().listen((event) {
        event.docChanges.forEach((element) {
          if(element.type == DocumentChangeType.added) {
            Map<String, dynamic> dataFirebase = element.doc.data();
            peerConnection.addCandidate(
              RTCIceCandidate(
                dataFirebase["candidate"],
                dataFirebase["sdpMid"],
                dataFirebase["sdpMLineIndex"],
              ),
            );
          }
        });
      });

    }
  }

  //Opening user media devices 
  Future<void> openUserMedia(
      RTCVideoRenderer localVideo,
      RTCVideoRenderer remoteVideo,
      ) async {
    var stream = await navigator.mediaDevices.getUserMedia(
      {"video": true, "audio": true},
    );

    localVideo.srcObject = stream;
    localStream = stream;

    remoteVideo.srcObject = await createLocalMediaStream("key");
  }

  //Open userMediaAudio only
  Future<void> openUserMediaAudioOnly(
      RTCVideoRenderer localVideo,
      RTCVideoRenderer remoteVideo,
      ) async {
    var stream = await navigator.mediaDevices.getUserMedia(
      {"audio": true,},
    );

    localVideo.srcObject = stream;
    localStream = stream;

    remoteVideo.srcObject = await createLocalMediaStream("key");
  }

  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    List<MediaStreamTrack> tracks = localVideo.srcObject.getTracks();
    tracks.forEach((track) {
      track.enabled = false;
      track.stop();
    });

    if(remoteStream != null) {
      remoteStream.getTracks().forEach((element) {
        element.enabled = false;
        element.stop();
      });
    }

    if(peerConnection != null) {
      peerConnection.close();
    }

    if(roomId != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference roomRef = firestore.collection("videoRooms").doc(roomId);
      var calledCandidates = await roomRef.collection("calledCandidates").get();
      calledCandidates.docs.forEach((element) {
        element.reference.delete();
      });

      var callerCandidates = await roomRef.collection("callerCandidates").get();
      callerCandidates.docs.forEach((element) {
        element.reference.delete();
      });

      await roomRef.delete();
    }

    localStream.dispose();
    remoteStream.dispose();
  }

  void muteMic(RTCVideoRenderer localVideo) {
    var audioTracks = localVideo.srcObject.getAudioTracks();

    audioTracks[0].enabled = !audioTracks[0].enabled;
  }

  void muteVideo(RTCVideoRenderer localVideo) {
    var videoTracks = localVideo.srcObject.getVideoTracks();

    videoTracks[0].enabled = !videoTracks[0].enabled;
  }

  void onSpeaker(RTCVideoRenderer localVideo, bool enable) {
    var audioOnSpeakerTracks = localVideo.srcObject.getAudioTracks();

    audioOnSpeakerTracks[0].enableSpeakerphone(enable);
  }

  void registerPeerConnectionListeners() {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state){
    };

    peerConnection.onSignalingState = (RTCSignalingState state){
    };

    peerConnection.onIceConnectionState = (RTCIceConnectionState state) {
    };

    peerConnection.onAddStream = (MediaStream stream) {
      onAddRemoteStream.call(stream);
      remoteStream = stream;
    };
  }
}