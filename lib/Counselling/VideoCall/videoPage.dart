import 'dart:async';

import 'package:chat_app/Counselling/signalingForRTC.dart';
import 'package:chat_app/ManageNotes/notes_app/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {
  final String connectId;
  final SignalingRTC signalingRTC;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final String otherUserUID;
  final String otherUserName;

  VideoCall({this.signalingRTC, this.localRenderer, this.remoteRenderer, this.connectId, this.otherUserUID, this.otherUserName});

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool onSpeaker = true;
  bool onToggleVideo = false;
  bool onToggleMic = false;
  Color defaultColor = (Colors.teal.shade300);
  Color onChange = (Colors.grey);

  StreamSubscription listenerForPop;

  void listeningPop(){
    listenerForPop = _firestore.collection("autoVideo").doc(widget.connectId).snapshots().listen((event) {
      if(event.data()["firstUser"] == null && event.data()["secondUser"] == null){
        Navigator.pop(context);
      } else {
        return null;
      }
    });
  }

  void setToNull() async {
    widget.signalingRTC.hangUp(widget.localRenderer);
    await _firestore.collection("autoVideo").doc(widget.connectId).update({
      "firstUser": null,
      "secondUser": null,
    });
  }

  @override
  void initState() {
    startOfLog();
    listeningPop();
    super.initState();
  }

  @override
  void dispose() {
    addActivityLog();
    setToNull();
    widget.localRenderer.dispose();
    widget.remoteRenderer.dispose();
    listenerForPop.cancel();
    super.dispose();
  }

  void toggleSpeaker() {
    setState(() {
      onSpeaker = !onSpeaker;
    });
  }

  void toggleVideo() {
    setState(() {
      onToggleVideo = !onToggleVideo;
    });
  }

  void toggleMic() {
    setState(() {
      onToggleMic = !onToggleMic;
    });
  }

  DateTime timeSessionStarted;

  //Start the log of the session
  void startOfLog() {
    timeSessionStarted = DateTime.now();
  }

  void addActivityLog() async {
        await _firestore.collection("activityLog").doc(_auth.currentUser.uid).collection("sessions").add({
          "type": "Chat",
          "otherUser": widget.otherUserName,
          "timeStarted": Timestamp.fromDate(timeSessionStarted),
          "timeEnded": Timestamp.now(),
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("For Video Call"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notes(chosenUserData: widget.otherUserUID,),));
            },
            icon: Icon(Icons.note),
            color: Colors.black54,
          ),
        ],
      ),
      body: Stack(
        textDirection: TextDirection.rtl,
        children: [
          RTCVideoView(
            widget.remoteRenderer,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
          Positioned(
            height: size.height / 4,
            width: size.width / 4,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: size.width / 100),
              ),
              child: RTCVideoView(
                widget.localRenderer, mirror: true,
                objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              ),
            ),
          ),
          Positioned(
            bottom: size.height / 30,
            right: size.width / 5,
            child: Row(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: onToggleMic == false ? defaultColor: onChange,
                  onPressed: () {
                    toggleMic();
                    setState(() {
                      widget.signalingRTC.muteMic(widget.localRenderer);
                    });
                  },
                  child:  onToggleMic == false ? Icon(Icons.mic): Icon(Icons.mic_off),
                ),
                SizedBox(width: size.width / 50,),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: onToggleVideo == false ? defaultColor: onChange,
                  onPressed: () {
                    toggleVideo();
                    setState(() {
                      widget.signalingRTC.muteVideo(widget.localRenderer);
                    });
                  },
                  child: onToggleVideo == false ? Icon(Icons.videocam): Icon(Icons.videocam_off),
                ),
                SizedBox(width: size.width / 50,),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: onSpeaker == false ? defaultColor: onChange,
                  onPressed: () {
                    toggleSpeaker();
                    setState(() {
                      widget.signalingRTC.onSpeaker(widget.localRenderer, onSpeaker);
                    });
                  },
                  child: onSpeaker == true ? Icon(Icons.volume_up): Icon(Icons.volume_down),
                ),
                SizedBox(width: size.width / 50,),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: defaultColor,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.call_end, color: Colors.red,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}