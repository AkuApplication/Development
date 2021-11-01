import 'package:chat_app/Counselling/VideoCall/signalingForRTC.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {
  final String connectId;
  final SignalingRTC signalingRTC;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  VideoCall({this.signalingRTC, this.localRenderer, this.remoteRenderer, this.connectId});

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {

  // SignalingRTC signalingRTC = SignalingRTC();
  // RTCVideoRenderer localRenderer = RTCVideoRenderer();
  // RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool onSpeaker = true;

  void setToNull() async {
    widget.signalingRTC.hangUp(widget.localRenderer);
    await _firestore.collection("autoVideo").doc(widget.connectId).update({
      "firstUser": null,
      "secondUser": null,
    });
  }

  // @override
  // void initState() {
  //   localRenderer.initialize();
  //   remoteRenderer.initialize();
  //
  //   signalingRTC.openUserMedia(localRenderer, remoteRenderer);
  //   super.initState();
  // }

  @override
  void dispose() {
    setToNull();
    widget.localRenderer.dispose();
    widget.remoteRenderer.dispose();
    super.dispose();
  }

  void toggleSpeaker() {
    setState(() {
      onSpeaker = !onSpeaker;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
      appBar: AppBar(
        title: Text("For Video Call"),
      ),
      body: Stack(
        children: [
          RTCVideoView(widget.remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,),
          Positioned.directional(
            textDirection: TextDirection.rtl,
            start: 0,
            child: RTCVideoView(
              widget.localRenderer, mirror: true,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
            height: size.height / 3,
            width: size.width / 3,
            // top: size.height / 1000,
            // right: size.width / -7.5428,
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.signalingRTC.muteMic(widget.localRenderer);
                });
              },
              child: Text("Mute Mic"),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.signalingRTC.muteVideo(widget.localRenderer);
                });
              },
              child: Text("Mute Video"),
            ),
          ),
          Positioned(
            bottom: 130,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                toggleSpeaker();
                setState(() {
                  widget.signalingRTC.onSpeaker(widget.localRenderer, onSpeaker);
                });
              },
              child: onSpeaker == true ? Text("Off Speaker") : Text("On Speaker"),
            ),
          ),
          Positioned(
            bottom: 180,
            left: 20,
            child: ElevatedButton(
              onPressed: (){
                setState(() {
                  widget.signalingRTC.hangUp(widget.localRenderer);
                });
              },
              child: Text("HangUp"),
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: RTCVideoView(widget.localRenderer, mirror: true,),
          //         ),
          //         Expanded(
          //           child: RTCVideoView(widget.remoteRenderer,),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}