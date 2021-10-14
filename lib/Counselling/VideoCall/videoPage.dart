import 'dart:async';

import 'package:chat_app/Counselling/Chat/HomeScreen.dart';
import 'package:chat_app/Counselling/VideoCall/signalingForRTC.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  SignalingRTC signalingRTC = SignalingRTC();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String roomId;
  TextEditingController roomIdController = TextEditingController(text: "");
  bool onSpeaker = false;

  @override
  void initState() {

    // Timer(Duration(seconds: 10),returnToHome);

    _localRenderer.initialize();
    _remoteRenderer.initialize();

    // setState(() {
    //   signalingRTC.openUserMedia(_localRenderer, _remoteRenderer);
    // });
    //
    // createRoom();

    signalingRTC.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
    });
    super.initState();
  }

  // void createRoom() async {
  //   roomId = await signalingRTC.createRoom(_remoteRenderer);
  //   setState(() {
  //     roomIdController.text = roomId;
  //   });
  // }

  // void returnToHome() {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
  // }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void toggleSpeaker() {
    setState(() {
      onSpeaker = !onSpeaker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("For Video Call"),
      ),
      body: Stack(
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                signalingRTC.openUserMedia(_localRenderer, _remoteRenderer);
              });

            },
            child: Text("Open camera & microphone"),
            isExtended: true,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                signalingRTC.muteMic(_localRenderer);
              });

            },
            child: Text("Mute mic"),
            isExtended: true,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                signalingRTC.muteVideo(_localRenderer);
              });

            },
            child: Text("Mute Video"),
            isExtended: true,
          ),
          FloatingActionButton(
            onPressed: () {
              toggleSpeaker();
              setState(() {
                signalingRTC.onSpeaker(_localRenderer, onSpeaker);
              });

            },
            child: Text("On Speaker"),
            isExtended: true,
          ),
          FloatingActionButton(
            onPressed: () async {
              roomId = await signalingRTC.createRoom(_remoteRenderer);
              setState(() {
                roomIdController.text = roomId;
              });
            },
            child: Text("Create room"),
            isExtended: true,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                signalingRTC.joinRoom(roomIdController.text);
              });

            },
            child: Text("Join room"),
            isExtended: true,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                signalingRTC.hangUp(_localRenderer);
              });
            },
            child: Text("HangUp"),
            isExtended: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: RTCVideoView(_localRenderer, mirror: true,),
                  ),
                  Expanded(
                    child: RTCVideoView(_remoteRenderer,),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Text("Join the following Room: "),
              Flexible(
                child: TextFormField(
                  controller: roomIdController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}