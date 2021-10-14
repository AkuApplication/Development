import 'package:chat_app/ManageNotes/notes_app/notes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  QueryDocumentSnapshot chosenUserData;
  final String chatRoomId;

  ChatRoom({this.chatRoomId, this.chosenUserData});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _username2;

  void checkFirestore() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        _username2 = value.data()["name"];
      });
    });
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _username2,
        "message": _message.text,
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  void initState() {
    checkFirestore();
    print(widget.chosenUserData.get("uid"));
    // print(widget.userList.data());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal.shade300,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.chosenUserData.get("profileURL")),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.chosenUserData.get("name")),
                        Text(widget.chosenUserData.get("status")),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notes(
                              chosenUserData: widget.chosenUserData.get("uid"),
                            ),
                          ));
                    },
                    icon: Icon(Icons.note),
                    color: Colors.black54,
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),

          // title: StreamBuilder<DocumentSnapshot>(
          //   stream:
          //       _firestore.collection("users").doc(userMap['uid']).snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.data != null) {
          //       return Container(
          //         child: Column(
          //           children: [
          //             Text(userMap['name']),
          //             Text(
          //               snapshot.data['status'],
          //               style: TextStyle(fontSize: 14),
          //             ),
          //           ],
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
        ),

        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Container(
        //         height: size.height / 1.25,
        //         width: size.width,
        //         child: StreamBuilder<QuerySnapshot>(
        //           stream: _firestore
        //               .collection('chatroom')
        //               .doc(widget.chatRoomId)
        //               .collection('chats')
        //               .orderBy("time", descending: false)
        //               .snapshots(),
        //           builder: (BuildContext context,
        //               AsyncSnapshot<QuerySnapshot> snapshot) {
        //             if (snapshot.data != null) {
        //               return ListView.builder(
        //                 itemCount: snapshot.data.docs.length,
        //                 itemBuilder: (context, index) {
        //                   Map<String, dynamic> map =
        //                       snapshot.data.docs[index].data();
        //                   return messages(size, map);
        //                 },
        //               );
        //             } else {
        //               return Container();
        //             }
        //           },
        //         ),
        //       ),

        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroom')
                  .doc(widget.chatRoomId)
                  .collection('chats')
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
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
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _message,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
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
          ],
        )

        // Container(
        //   height: size.height / 10,
        //   width: size.width,
        //   alignment: Alignment.center,
        //   child: Container(
        //     height: size.height / 12,
        //     width: size.width / 1.1,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Container(
        //           height: size.height / 17,
        //           width: size.width / 1.3,
        //           child: TextField(
        //             controller: _message,
        //             decoration: InputDecoration(
        //                 hintText: "Send Message",
        //                 border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(8),
        //                 )),
        //           ),
        //         ),
        //         IconButton(
        //             icon: Icon(Icons.send), onPressed: onSendMessage),
        //       ],
        //     ),
        //   ),
        // ),
        // ],
        );
    //   ),
    // );
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
          color:
              map['sendby'] == _username2 ? Colors.teal.shade300 : Colors.blue,
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

//
