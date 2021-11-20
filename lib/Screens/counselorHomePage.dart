import 'dart:async';
import 'dart:math';

import 'package:chat_app/Counselling/Chat/ChatRoom.dart';
import 'package:chat_app/Counselling/signalingForRTC.dart';
import 'package:chat_app/Counselling/VideoCall/videoPage.dart';
import 'package:chat_app/Counselling/VoiceCall/callPage.dart';
import 'package:chat_app/Notifications/notificationSettingsPage.dart';
import 'package:chat_app/ProfileManagement/CounsellorProfile/counsellorProfilePage.dart';
import 'package:chat_app/Screens/Patients/allPatientsDetails.dart';
import 'package:chat_app/SystemAuthentication/Methods.dart';
import 'package:chat_app/Screens/About/aboutPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorHomePage extends StatefulWidget {

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  //Getting related Firebase instances to be able to interact with Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Initializing variables
  final _wordController = TextEditingController();
  String _username2;
  String _account2;
  String _profileURL2;
  String roomId;

  StreamSubscription listenerForChat;
  StreamSubscription listenerForVideo;
  StreamSubscription listenerForCall;

  Size size;

  //Getting data from Firestore and inserting it to a new variable to be displayed at the screen
  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        _username2 = value.data()["name"];
        _account2 = value.data()["accountType"];
        _profileURL2 = value.data()["profileURL"];
      });
    });
  }

  //Getting Quotes from Firestore to be displayed periodically and its changing
  void checkQuotes() async {
    await _firestore.collection("quotes").doc("words").get().then((value) {
      Timer.periodic(Duration(seconds: 3), (timer) {
        final random = new Random();
        int num = random.nextInt(value.data()["arrayOfWords"].length);
        _wordController.text = value.data()["arrayOfWords"][num];
      });
    });
  }

  //Get the other user data and roomId to connect to
  void getDocument() async {
    await _firestore.collection("autoChat").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        roomId = value.data()["roomId"];
      });
    });
  }

  void getVideoDocument() async {
    await _firestore.collection("autoVideo").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        roomId = value.data()["roomId"];
      });
      signalingRTC.joinRoom(roomId);
    });
  }

  void getCallDocument() async {
    await _firestore.collection("autoCall").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        roomId = value.data()["roomId"];
      });
      signalingRTC.joinRoom(roomId);
    });
  }

  //Listening for changes in the firestore
  void listeningForChatCounselling() {
    listenerForChat = _firestore.collection("autoChat").doc(_auth.currentUser.uid).snapshots().listen((event) {
      getDocument();

      if(event.data()["firstUser"] == event.data()["other"]["uid"] && event.data()["secondUser"] == null){
        showDialog(context: context, barrierDismissible: false, builder: (context) {
          return WillPopScope(
            onWillPop: () => null,
            child: AlertDialog(
              content: Text("${event.data()["other"]["name"]} would like to counsel with you, Do you accept?" , textAlign: TextAlign.center,),
              actions: [
                Center(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _firestore.collection("autoChat").doc(_auth.currentUser.uid).update({
                            "secondUser": _auth.currentUser.uid,
                          });
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _firestore.collection("autoChat").doc(_auth.currentUser.uid).update({
                            "firstUser": null,
                            "secondUser": null
                          });
                        },
                        child: Text("No"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },);
      } else if(event.data()["firstUser"] == event.data()["other"]["uid"] && event.data()["secondUser"] == _auth.currentUser.uid){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(chatRoomId: roomId, chosenUserData: event.data()["other"], connectId: _auth.currentUser.uid,),),);
      } else {
        return null;
      }
    });

  }
  //Variables for VideoCall and Call
  SignalingRTC signalingRTC;
  RTCVideoRenderer localRenderer;
  RTCVideoRenderer remoteRenderer;

  void videoCallMethod() async {
    signalingRTC = SignalingRTC();
    localRenderer = RTCVideoRenderer();
    remoteRenderer = RTCVideoRenderer();

    localRenderer.initialize();
    remoteRenderer.initialize();

    signalingRTC.onAddRemoteStream = ((stream) {
      setState(() {
        remoteRenderer.srcObject = stream;
      });
    });

    signalingRTC.openUserMedia(localRenderer, remoteRenderer);
  }

  void voiceCallMethod() async {
    signalingRTC = SignalingRTC();
    localRenderer = RTCVideoRenderer();
    remoteRenderer = RTCVideoRenderer();

    localRenderer.initialize();
    remoteRenderer.initialize();

    signalingRTC.onAddRemoteStream = ((stream) {
      setState(() {
        remoteRenderer.srcObject = stream;
      });
    });

    signalingRTC.openUserMediaAudioOnly(localRenderer, remoteRenderer);
  }

  void listeningForVideoCounselling() {
    listenerForVideo = _firestore.collection("autoVideo").doc(_auth.currentUser.uid).snapshots().listen((event) {
      if(event.data()["firstUser"] == event.data()["other"]["uid"] && event.data()["secondUser"] == null){
        showDialog(context: context, barrierDismissible: false, builder: (context) {
          return WillPopScope(
            onWillPop: () => null,
            child: AlertDialog(
              content: Text("${event.data()["other"]["name"]} would like to counsel with you using video, Do you accept?" , textAlign: TextAlign.center,),
              actions: [
                Center(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          videoCallMethod();

                          await _firestore.collection("autoVideo").doc(_auth.currentUser.uid).update({
                            "secondUser": _auth.currentUser.uid,
                          });

                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _firestore.collection("autoVideo").doc(_auth.currentUser.uid).update({
                            "firstUser": null,
                            "secondUser": null
                          });
                        },
                        child: Text("No"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },);
      } else if(event.data()["firstUser"] == event.data()["other"]["uid"] && event.data()["secondUser"] == _auth.currentUser.uid){
        if(event.data()["roomId"] == null){
          showDialog(context: context, barrierDismissible: false, builder: (context) {
            return WillPopScope(
              onWillPop: () => null,
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: size.width / 3),
                child: Container(
                  height: size.height / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: size.width / 40,),
                      Text("Loading...", textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            );
          },);
        } else {
          getVideoDocument();
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoCall(signalingRTC: signalingRTC, localRenderer: localRenderer, remoteRenderer: remoteRenderer,connectId: _auth.currentUser.uid,),));
        }
      } else {
        return null;
      }
    });
  }

  void listeningForCallCounselling() {
    listenerForCall = _firestore.collection("autoCall").doc(_auth.currentUser.uid).snapshots().listen((event) {
      if(event.data()["firstUser"] == event.data()["other"]["uid"] && event.data()["secondUser"] == null){
        showDialog(context: context, barrierDismissible: false, builder: (context) {
          return WillPopScope(
            onWillPop: () => null,
            child: AlertDialog(
              content: Text("${event.data()["other"]["name"]} would like to counsel with you using voice only, Do you accept?" , textAlign: TextAlign.center,),
              actions: [
                Center(
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          voiceCallMethod();

                          await _firestore.collection("autoCall").doc(_auth.currentUser.uid).update({
                            "secondUser": _auth.currentUser.uid,
                          });

                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _firestore.collection("autoCall").doc(_auth.currentUser.uid).update({
                            "firstUser": null,
                            "secondUser": null
                          });
                        },
                        child: Text("No"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },);
      } else if(event.data()["firstUser"] == event.data()["other"]["uid"] && event.data()["secondUser"] == _auth.currentUser.uid){
        if(event.data()["roomId"] == null){
          showDialog(context: context, barrierDismissible: false, builder: (context) {
            return WillPopScope(
              onWillPop: () => null,
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: size.width / 3),
                child: Container(
                  height: size.height / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: size.width / 40,),
                      Text("Loading...", textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            );
          },);
        } else {
          getCallDocument();
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceCall(signalingRTC: signalingRTC, localRenderer: localRenderer, remoteRenderer: remoteRenderer,connectId: _auth.currentUser.uid, otherUserProfileURL: event.data()["other"]["profileURL"], otherUserName: event.data()["other"]["name"],),));
        }
      } else {
        return null;
      }
    });
  }

  //Initial state of the page
  @override
  void initState() {
    getPref();
    checkFirestore();
    checkQuotes();
    listeningForChatCounselling();
    listeningForVideoCounselling();
    listeningForCallCounselling();
    super.initState();
  }

  SharedPreferences sharedPreferences;
  // Getting SharedPreferences instance
  void getPref() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    listenerForChat.cancel();
    listenerForVideo.cancel();
    listenerForCall.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Counselor Homepage"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsPage(sharedPreferences: sharedPreferences,),)),
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Methods().logOut(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: size.height / 1,
            width: size.width,
            margin: EdgeInsets.symmetric(vertical: size.height / 50, horizontal: size.width / 30),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Username: $_username2',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w200,
                                    letterSpacing: 0.30,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Account Type: $_account2',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w200,
                                    letterSpacing: 0.30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: size.width / 8,
                        height: size.height / 8,
                        child: GestureDetector(
                          child: (_profileURL2 == null) ?
                          Icon(
                            Icons.account_circle,
                            size: 45.0,
                            color: Colors.black12,
                          ) :
                          CircleAvatar(
                            backgroundImage: NetworkImage(_profileURL2),
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CounsellorProfile(),));
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height / 5,
                  child: Card(
                    color: Colors.blue.shade300,
                    elevation: 10.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        decoration: InputDecoration(isDense: true, border: InputBorder.none),
                        maxLines: 2,
                        controller: _wordController,
                        enabled: false,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    primary: false,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: size.aspectRatio / 0.5,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Patients(),));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.red.shade100,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.flaticon.com/icons/png/512/1971/1971437.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'Patients',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => About(),));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.orange.shade100,
                          elevation: 10.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://image.flaticon.com/icons/png/512/4245/4245351.png',
                                height: size.height / 10,
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
