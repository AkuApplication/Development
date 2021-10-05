import 'dart:convert';

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
          // {
          //   "url": "turn:numb.viagenie.ca",
          //   "credential": "muazkh",
          //   "username": "webrtc@live.com"
          // }
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
  // String currentRoomText;
  StreamStateCallback onAddRemoteStream;

  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference roomRef = firestore.collection("videoRooms").doc();

    print("Create PeerConnection with configuration: $configuration");

    peerConnection = await createPeerConnection(configuration);
    print(peerConnection);

    registerPeerConnectionListeners();
    print("finish listening");

    localStream.getTracks().forEach((track) {
      peerConnection.addTrack(track, localStream);
      print(localStream);
      // print(peerConnection.addTrack(track, localStream));
    });

    //Code for collecting ICE candidates below
    var callerCandidatesCollection = roomRef.collection("callerCandidates");
    print("created callerDB");

    peerConnection.onIceCandidate = (RTCIceCandidate candidate){
      print("Got candidate: ${candidate.toMap()}");
      callerCandidatesCollection.add(candidate.toMap());
      print("added candidate to map");
    };

    //Add code for creating a room
    RTCSessionDescription offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);
    print(offer);

    Map<String, dynamic> roomWithOffer = {"offer": offer.toMap()};
    await roomRef.set(roomWithOffer);
    var roomId = roomRef.id;
    print(roomId);

    //
    peerConnection.onTrack = (RTCTrackEvent event) {
      print("Got remote track: ${event.streams[0]}");

      event.streams[0].getTracks().forEach((track) {
        print("Add a track to the remoteStream $track");
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
        print("failed to getRemoteDescription");
      }
    });
    
    //Listen for remote ICE candidates below
    roomRef.collection("calledCandidates").snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if(element.type == DocumentChangeType.added) {
          Map<String, dynamic> dataFirebase = element.doc.data();
          print("Got new remote ICE Candidates: ${jsonEncode(dataFirebase)}");
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
    print("Got room ${roomSnapshot.exists}");

    if(roomSnapshot.exists) {
      print("Join PeerConnection with configuration: $configuration");
      peerConnection = await createPeerConnection(configuration);

      registerPeerConnectionListeners();

      localStream.getTracks().forEach((track) {
        peerConnection.addTrack(track, localStream);
        // print(peerConnection.addTrack(track, localStream));
      });

      //Code for collecting ICE candidates below
      var calledCandidatesCollection = roomRef.collection("calledCandidates");
      print("created calledCandidates");

      peerConnection.onIceCandidate = (RTCIceCandidate candidate){
        print("Got calledcandidate: ${candidate.toMap()}");
        calledCandidatesCollection.add(candidate.toMap());
        print("added candidate to calledCandidate collections");
      };

      //
      peerConnection.onTrack = (RTCTrackEvent event) {
        print("Got remote track: ${event.streams[0]}");
        event.streams[0].getTracks().forEach((track) {
          print("Add a track to the secondUserStream $track");
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
      print("settedRemoteDescription");
      var answer = await peerConnection.createAnswer();
      print("creating answer now");

      await peerConnection.setLocalDescription(answer);


      Map<String, dynamic> roomWithAnswer = {
        "answer": {
          "type": answer.type,
          "sdp": answer.sdp,
        }
      };
      print("finish mapping answer");

      await roomRef.update(roomWithAnswer);
      print("created answerRoom");

      //Listening for remote ICE candidates below
      roomRef.collection("callerCandidates").snapshots().listen((event) {
        event.docChanges.forEach((element) {
          if(element.type == DocumentChangeType.added) {
            Map<String, dynamic> dataFirebase = element.doc.data();
            print("Got new remote for receiver ICE Candidates: ${jsonEncode(dataFirebase)}");
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

  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    List<MediaStreamTrack> tracks = localVideo.srcObject.getTracks();
    tracks.forEach((track) {
      track.stop();
    });

    if(remoteStream != null) {
      remoteStream.getTracks().forEach((element) {
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

  Future<void> muteMic(RTCVideoRenderer localVideo) {
    var audioTracks = localVideo.srcObject.getAudioTracks();

    audioTracks[0].setMicrophoneMute(true);
  }

  Future<void> muteVideo(RTCVideoRenderer localVideo) {
    var videoTracks = localVideo.srcObject.getVideoTracks();

    videoTracks[0].enabled = !videoTracks[0].enabled;
  }

  Future<void> onSpeaker(RTCVideoRenderer localVideo, bool enable) {
    var audioOnSpeakerTracks = localVideo.srcObject.getAudioTracks();

    // bool enable = true;
    audioOnSpeakerTracks[0].enableSpeakerphone(enable);
  }

  void registerPeerConnectionListeners() {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print("ICE gathering state changed: $state");
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state){
      print("Connection state change: $state");
    };

    peerConnection.onSignalingState = (RTCSignalingState state){
      print("Signaling state change: $state");
    };

    peerConnection.onIceConnectionState = (RTCIceConnectionState state) {
      print("ICE connection state changed: $state");
    };

    peerConnection.onAddStream = (MediaStream stream) {
      print("Add remote stream");
      onAddRemoteStream.call(stream);
      remoteStream = stream;
    };
  }
}