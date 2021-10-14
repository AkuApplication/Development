import 'dart:async';
import 'dart:developer';

import 'package:chat_app/ManageNotes/notes_app/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  //The data that will be taken when calling the constructor in a different page
  QueryDocumentSnapshot chosenUserData;
  final String chatRoomId;

  ChatRoom({this.chatRoomId, this.chosenUserData});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  //Getting firebase related instances to be able to interact with the Firebase features
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Initializing variables
  String _username2;
  final TextEditingController _message = TextEditingController();
  ScrollController _scrollController = ScrollController();

  //Method for getting data of the current user for the message
  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        _username2 = value.data()["name"];
      });
    });
  }

  //For sending message to the other user when clicking the send button
  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _username2,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore.collection('chatroom').doc(widget.chatRoomId).collection('chats').add(messages);
    }
  }

  Timer timer;
  Counter counter;
  int _start = 3600;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if(_start == 0){
        setState(() {
          timer.cancel();
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else if(_start == 1800){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("You got 30 minutes left of the counselling session", textAlign: TextAlign.center,),
          );
        },);
        setState(() {
          _start--;
        });
      } else if (_start == 300){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("You got 5 minutes left of the counselling session", textAlign: TextAlign.center,),
          );
        },);
        setState(() {
          _start--;
        });
      } else if(_start == 1){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("Counselling Session Ended", textAlign: TextAlign.center,),
          );
        },);
        setState(() {
          _start--;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    startTimer();
    checkFirestore();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal.shade300,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Notes(chosenUserData: widget.chosenUserData.get("uid"),),));
            },
            icon: Icon(Icons.note),
            color: Colors.black54,
          ),
        ],
        title: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {

                },
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.chosenUserData.get("profileURL"),),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.chosenUserData.get("name")),
                            Text(widget.chosenUserData.get("status")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: size.height / 1.25,
                width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('chatroom')
                      .doc(widget.chatRoomId)
                      .collection('chats')
                      .orderBy("time", descending: false)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map =
                              snapshot.data.docs[index].data();
                          return messages(size, map);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.black12,
                  child: Row(
                    children: [
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextField(
                          controller: _message,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(width: 15,),
                      FloatingActionButton(
                        onPressed: onSendMessage,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.teal,
                        elevation: 0,
                      )
                    ],
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _username2
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == _username2 ? Colors.teal.shade300 : Colors.blue,
        ),
        child: Text(
          map['message'],
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}