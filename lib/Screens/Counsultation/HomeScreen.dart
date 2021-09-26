import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Screens/Counsultation/ChatRoom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic> userMap;
  List userList;
  // bool isLoading = false;
  // final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _gender;
  List<String> _genderList = ["Male", "Female"];
  bool choseGender1 = false;
  bool choseGender2 = false;
  String roomId;

  // @override
  // void initState() {
  //   super.initState();
  //   // WidgetsBinding.instance.addObserver(this);
  //   // setStatus("Online");
  // }

  // void setStatus(String status) async {
  //   await _firestore.collection('users').doc(_auth.currentUser.uid).update({
  //     "status": status,
  //   });
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // online
  //     setStatus("Online");
  //   } else {
  //     // offline
  //     setStatus("Offline");
  //   }
  // }

  String chatRoomId(String user1, String user2) {
    if (user1.hashCode <= user2.hashCode) {
      roomId = "$user1-$user2";
    } else {
      roomId = "$user2-$user1";
    }
  }

// Search user based on searching their email

  // void onSearch() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   await _firestore
  //       .collection('users')
  //       //Cari user yang online AND not current user id
  //       // .where("status", isEqualTo: "Online")
  //       // .where("uid", isNotEqualTo: _auth.currentUser.uid)
  //
  //       .where("email", isEqualTo: _search.text)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       // for (int i = 0; i < value.docs.length; i++) {
  //       //   userMap = value.docs[i].data();
  //       //   var userLength = value.docs.length;
  //       // }
  //
  //       userMap = value.docs[0].data();
  //       isLoading = false;
  //     });
  //   });
  // }

//Online Status user

  // void onlineStatus() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //
  //   await _firestore
  //       .collection('users')
  //       //Cari user yang online AND not current user id
  //       .where("status", isEqualTo: "Online")
  //       // .where("uid", isNotEqualTo: _auth.currentUser.uid)
  //
  //       // .where("email", isEqualTo: _search.text)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       // for (int i = 0; i < value.docs.length; i++) {
  //       //   userMap = value.docs[i].data();
  //       //   var userLength = value.docs.length;
  //       // }
  //
  //       // For Loop ?  Foreach ? Array Loop ?
  //
  //       // To do list : How to loop userMap
  //
  //       userMap = value.docs[4].data();
  //       // isLoading = false;
  //     });
  //   });
  // }

  void getAllOnlineUsers() async {
    await _firestore
        .collection('users')
    //Cari user yang online AND not current user id
        .where("status", isEqualTo: "Online")
        .where("gender", whereIn: ["Male", "Female"])
        .where("uid", isNotEqualTo: _auth.currentUser.uid)

    // .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
          // for(int i = 0; i < value.docs.length; i++){
          //   setState(() {
          //     userMap = value.docs[i].data();
          //   });
          //
          // }

      setState(() {
        userList = value.docs.toList();
      });

      int count = userList.length;
      print(count);
      print(userList);

      // int count = userMap.length;
      // print(count);
      // print(userMap);
    });
  }

  void getAllFemaleOnlineUsers() async {
    await _firestore
        .collection('users')
    //Cari user yang online AND not current user id
        .where("status", isEqualTo: "Online")
        .where("gender", isEqualTo: "Female")
        .where("uid", isNotEqualTo: _auth.currentUser.uid)

    // .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      // for(int i = 0; i < value.docs.length; i++){
      //   setState(() {
      //     userMap = value.docs[i].data();
      //   });
      //
      // }

      setState(() {
        userList = value.docs.toList();
      });

      int count = userList.length;
      print(count);
      print(userList);

      // int count = userMap.length;
      // print(count);
      // print(userMap);
    });
  }

  void getAllMaleOnlineUsers() async {
    await _firestore
        .collection('users')
    //Cari user yang online AND not current user id
        .where("status", isEqualTo: "Online")
        .where("gender", isEqualTo: "Male")
        .where("uid", isNotEqualTo: _auth.currentUser.uid)

    // .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      // for(int i = 0; i < value.docs.length; i++){
      //   setState(() {
      //     userMap = value.docs[i].data();
      //   });
      //
      // }

      setState(() {
        userList = value.docs.toList();
      });

      int count = userList.length;
      print(count);
      print(userList);

      // int count = userMap.length;
      // print(count);
      // print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: Text("Consultation"),
        // actions: [
        //   IconButton(icon: Icon(Icons.logout), onPressed: () => Methods().logOut(context))
        // ],
      ),
      // body: isLoading
      //     ? Center(
      //         child: Container(
      //           height: size.height / 20,
      //           width: size.height / 20,
      //           child: CircularProgressIndicator(),
      //         ),
      //       ):
           body: SingleChildScrollView(
             child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),

                  //Search Box

                  // Container(
                  //   height: size.height / 14,
                  //   width: size.width,
                  //   alignment: Alignment.center,
                  //   child: Container(
                  //     height: size.height / 14,
                  //     width: size.width / 1.15,
                  //     child: TextField(
                  //       controller: _search,
                  //       decoration: InputDecoration(
                  //         hintText: "Search",
                  //         suffixIcon: IconButton(
                  //             onPressed: onSearch, icon: Icon(Icons.search)),
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                            value: choseGender1,
                            title: Text("Male"),
                            onChanged: (value) {
                              setState(() {
                                choseGender1 = !choseGender1;
                              });
                            },
                          ),
                          CheckboxListTile(
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
                      // onPressed: onlineStatus,
                    onPressed: () {
                      if(choseGender1 == true && choseGender2 == true){
                        getAllOnlineUsers();
                      } else if(choseGender1 == true && choseGender2 == false){
                        getAllMaleOnlineUsers();
                      } else if(choseGender2 == true && choseGender1 == false){
                        getAllFemaleOnlineUsers();
                      } else {
                        print("Please choose at least one gender");
                      }
                    },
                      child: Text("Available Therapist"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal.shade500,
                      )),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  userList != null

                      // Kalau nya ada yang online output nya :

                      ?
                      Container(
                        width: size.width / 1.2,
                        height: size.height / 1.2,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  child: Card(
                                    elevation: 2,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.account_circle,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        userList[index]["name"],
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
                                                chatRoomId(_auth.currentUser.uid,
                                                    userList[index]["uid"]);
                                                print(roomId);

                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (_) => ChatRoom(
                                                      chatRoomId: roomId,
                                                      chosenUserData: userList[index],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),

                                          // Call Based Counsultation
                                          Container(
                                            child: new IconButton(
                                              icon: new Icon(Icons.call),
                                              onPressed: () {},
                                            ),
                                          ),

                                          // Video Call Based Counsultation

                                          Container(
                                            child: new IconButton(
                                              icon: new Icon(Icons.video_call),
                                              onPressed: () {},
                                            ),
                                          ),
                                          // icon-1
                                          // icon-2
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      )
                  // Column(
                  //         children: [
                  //           // ani an meikir kn lagi how to loop kan benda ani
                  //
                  //           Container(
                  //             child: Padding(
                  //               padding:
                  //                   const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  //               child: Card(
                  //                 elevation: 2,
                  //                 child: ListTile(
                  //                   leading: Icon(Icons.account_circle,
                  //                       color: Colors.black),
                  //                   title: Text(
                  //                     userMap['name'],
                  //                     style: TextStyle(
                  //                       color: Colors.black,
                  //                       fontSize: 17,
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //                   // subtitle: Text(userMap['email']),
                  //                   // trailing:
                  //                   //     Icon(Icons.chat, color: Colors.black),
                  //                   trailing: Wrap(
                  //                     children: <Widget>[
                  //                       // Chat Based Counsultation
                  //
                  //                       Container(
                  //                         child: new IconButton(
                  //                           icon: new Icon(Icons.message),
                  //                           onPressed: () {
                  //                             String roomId = chatRoomId(
                  //                                 _auth.currentUser.displayName,
                  //                                 userMap['uid']);
                  //
                  //                             Navigator.of(context).push(
                  //                               MaterialPageRoute(
                  //                                 builder: (_) => ChatRoom(
                  //                                   chatRoomId: roomId,
                  //                                   userMap: userMap,
                  //                                 ),
                  //                               ),
                  //                             );
                  //                           },
                  //                         ),
                  //                       ),
                  //
                  //                       // Call Based Counsultation
                  //                       Container(
                  //                         child: new IconButton(
                  //                           icon: new Icon(Icons.call),
                  //                           onPressed: () {},
                  //                         ),
                  //                       ),
                  //
                  //                       // Video Call Based Counsultation
                  //
                  //                       Container(
                  //                         child: new IconButton(
                  //                           icon: new Icon(Icons.video_call),
                  //                           onPressed: () {},
                  //                         ),
                  //                       ),
                  //                       // icon-1
                  //                       // icon-2
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       )
                      : Container(),
                ],
              ),
           ),
    );
  }
}
