import 'package:chat_app/Counselling/Chat/ChatRoom.dart';
import 'package:chat_app/Counselling/VideoCall/videoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  //Getting firebase related instances for using firebase feature
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Initializing variables
  List userList;
  bool choseGender1 = false;
  bool choseGender2 = false;
  String roomId;

  String chatRoomId(String user1, String user2) {
    if (user1.hashCode <= user2.hashCode) {
      roomId = "$user1-$user2";
    } else {
      roomId = "$user2-$user1";
    }
  }

  //Getting all of the online users
  void getAllOnlineUsers() async {
    await _firestore
        .collection('users')
        .where("status", isEqualTo: "Online")
        .where("gender", whereIn: ["Male", "Female"])
        .where("uid", isNotEqualTo: _auth.currentUser.uid)
        .where("accountType", isEqualTo: "Counsellor")
        .get()
        .then((value) {
      setState(() {
        userList = value.docs.toList();
      });
    });
  }

  //Getting only female online users
  void getAllFemaleOnlineUsers() async {
    await _firestore
        .collection('users')
        .where("status", isEqualTo: "Online")
        .where("gender", isEqualTo: "Female")
        .where("uid", isNotEqualTo: _auth.currentUser.uid)
        .where("accountType", isEqualTo: "Counsellor")
        .get()
        .then((value) {
      setState(() {
        userList = value.docs.toList();
      });
    });
  }

  //Getting only male online users
  void getAllMaleOnlineUsers() async {
    await _firestore
        .collection('users')
        .where("status", isEqualTo: "Online")
        .where("gender", isEqualTo: "Male")
        .where("uid", isNotEqualTo: _auth.currentUser.uid)
        .where("accountType", isEqualTo: "Counsellor")
        .get()
        .then((value) {
      setState(() {
        userList = value.docs.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Consultation"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Text("Select your counselor's gender",
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      CheckboxListTile(
                        activeColor: Colors.teal.shade300,
                        value: choseGender1,
                        title: Text("Male"),
                        onChanged: (value) {
                          setState(() {
                            choseGender1 = !choseGender1;
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.teal.shade300,
                        value: choseGender2,
                        title: Text("Female"),
                        onChanged: (value) {
                          setState(() {
                            choseGender2 = !choseGender2;
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    if(choseGender1 == true && choseGender2 == true){
                      getAllOnlineUsers();
                    } else if(choseGender1 == true && choseGender2 == false){
                      getAllMaleOnlineUsers();
                    } else if(choseGender2 == true && choseGender1 == false){
                      getAllFemaleOnlineUsers();
                    } else {
                      showDialog(context: context, barrierDismissible: false, builder: (context) {
                        return WillPopScope(
                          onWillPop: () {},
                          child: AlertDialog(
                            content: Text("Please choose at least one gender", textAlign: TextAlign.center,),
                            actions: [
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Close"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },);
                    }
                  },
                  child: Text("Available Therapist"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade500,
                  )
              ),
              SizedBox(
                height: size.height / 30,
              ),
              userList != null ?
              Container(
                width: size.width / 1.1,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      child: ListTile(
                        leading: userList[index]["profileURL"] == null ?
                        Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ) :
                        CircleAvatar(
                          backgroundImage: NetworkImage(userList[index]["profileURL"]),
                        ),
                        title: Text(
                          userList[index]["name"] + " (${userList[index]["gender"]})",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Wrap(
                          children: <Widget>[
                            // Chat Based Counsultation
                            Container(
                              child: new IconButton(
                                icon: new Icon(Icons.message),
                                onPressed: () {
                                  chatRoomId(_auth.currentUser.uid, userList[index]["uid"]);

                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(chatRoomId: roomId, chosenUserData: userList[index],),),);
                                },
                              ),
                            ),

                            // Call Based Counsultation
                            Container(
                              child: new IconButton(
                                icon: new Icon(Icons.call),
                                onPressed: () {

                                },
                              ),
                            ),

                            // Video Call Based Counsultation
                            Container(
                              child: new IconButton(
                                icon: new Icon(Icons.video_call),
                                onPressed: () {
                                  // chatRoomId(_auth.currentUser.uid,
                                  //     userList[index]["uid"]);
                                  // print(roomId);

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VideoCall(),));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ) :
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
