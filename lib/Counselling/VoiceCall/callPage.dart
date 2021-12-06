import 'dart:async';

import 'package:chat_app/Counselling/signalingForRTC.dart';
import 'package:chat_app/ManageNotes/notes_app/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VoiceCall extends StatefulWidget {
  final String connectId;
  final SignalingRTC signalingRTC;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;
  final String otherUserProfileURL;
  final String otherUserName;
  final String otherUserUID;

  VoiceCall({this.signalingRTC, this.localRenderer, this.remoteRenderer, this.connectId, this.otherUserName, this.otherUserProfileURL, this.otherUserUID});

  @override
  _VoiceCallState createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool onSpeaker = true;
  bool onToggleMic = false;
  Color defaultColor = (Colors.teal.shade300);
  Color onChange = (Colors.grey);

  StreamSubscription listenerForPop;

  void listeningPop(){
    listenerForPop = _firestore.collection("autoCall").doc(widget.connectId).snapshots().listen((event) {
      if(event.data()["firstUser"] == null && event.data()["secondUser"] == null){
        Navigator.pop(context);
      } else {
        return null;
      }
    });
  }

  void setToNull() async {
    widget.signalingRTC.hangUp(widget.localRenderer);
    await _firestore.collection("autoCall").doc(widget.connectId).update({
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
        title: Text("For Voice Call"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notes(chosenUserData: widget.otherUserUID),));
            },
            icon: Icon(Icons.note),
            color: Colors.black54,
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.brown,
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(height: size.height / 20,),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.otherUserProfileURL),
                  radius: size.height / 5,
                ),
                SizedBox(height: size.height / 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.otherUserName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.height / 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: size.height / 30,
            right: size.width / 3.6,
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