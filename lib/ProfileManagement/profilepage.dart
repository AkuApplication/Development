import 'dart:io';

import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:chat_app/Screens/doctorHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // String _email;
  // String _password;
  final _name = TextEditingController();
  String _gender;
  final _contact = TextEditingController();
  final _condition = TextEditingController();
  final _records = TextEditingController();
  File _image;
  String _imageURL;

  String _inputName;
  String _inputContact;

  String _backupName;
  String _backupGender;
  String _backupContact;
  String _backupURL;

  // List<NetworkImage> _listOfImage;
  // String _nameImages;
  //
  // void getImages() async {
  //   _listOfImage = [];
  //   for (int i= 0; i < 6; i++){
  //     _listOfImage.add(NetworkImage(_auth.currentUser.uid + i.toString() + ".jpeg"));
  //   }
  // }

  final _formKey = GlobalKey<FormState>();
  final _imageKey = GlobalKey<FormState>();
  final _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> _genderList = ["Male", "Female"];

  void checkFirestore() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        _name.text = value.data()["name"];
        _backupName = _name.text;

        _gender = value.data()["gender"];
        _backupGender = _gender;

        _contact.text = value.data()["contact"];
        _backupContact = _contact.text;

        _condition.text = value.data()["condition"];

        _records.text = value.data()["records"];

        _imageURL = value.data()["profileURL"];
        _backupURL = _imageURL;
      });
    });
  }

  void uploadImage() async {
    final _picked = await ImagePicker().pickImage(source: ImageSource.camera);
    _image = File(_picked.path);
    String _fileName = _image.path;
    Reference reference = _storage.ref().child("images/$_fileName");
    UploadTask upload = reference.putFile(_image);
    TaskSnapshot task = await upload.whenComplete(() => null);
    task.ref.getDownloadURL().then((value) async {
      setState(() {
        _imageURL = value;
      });

      // await _firestore.collection("users").doc(_auth.currentUser.uid).update({
      //   "profileURL": _imageURL
      // });

      // Navigator.pop(context, _imageURL);
      // _imageURL = await task.ref.getDownloadURL();
      // await _firestore.collection("users").doc(_auth.currentUser.uid).update({
      //   "profileURL": _imageURL
    });
    // await _firestore.collection("images").add({
    //   "url": _imageURL,
    //   "name": _fileName
    // });
  }

  @override
  void initState() {
    checkFirestore();
    super.initState();
  }
  // @override
  // void initState() {
  //   var referenceImage = _storage.ref().child(_auth.currentUser.uid)
  //       .getDownloadURL().then((value) {
  //         setState(() {
  //           _imageURL = value;
  //         });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal.shade300,
        title: Text('Profile'),
        // leading: ElevatedButton(
        //   child: Text("Homepage"),
        //   onPressed: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => DoctorHomePage(),));
        //   },
        // ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormField(
                        builder: (field) {
                          return Container(
                            width: 100,
                            height: 100,
                            child: InkWell(
                              // This is where the profile picture of the user goes into
                              // child: CircleAvatar(
                              //   radius: 100,
                              //   backgroundColor: Colors.teal,
                              // ),
                              child: (_imageURL == null)
                                  ? Image.network(
                                      "https://firebasestorage.googleapis.com/v0/b/aku-application-a7dda.appspot.com/o/logo.jpeg?alt=media&token=50035771-7905-43a3-8b51-256f71e506cf")
                                  // child: (_image == null) ? CircleAvatar(
                                  //   radius: 100,
                                  // ) : Image.file(_image),
                                  : Image.network(
                                      _imageURL,
                                      fit: BoxFit.fill,
                                    ),
                              onTap: () async {
                                // final _picked = await ImagePicker().pickImage(source: ImageSource.camera);

                                await uploadImage();

                                // await _storage.ref().child("Images/$_picked").putFile(_image).whenComplete(() {
                                //   _storage.ref().getDownloadURL().then((value) {
                                //     print("Done: $value");
                                //   });
                                // });
                                // setState(() {
                                //   _image = File(_picked.path);
                                // });
                              },
                            ),
                          );
                        },
                        key: _imageKey,
                      ),

                      // GridView.builder(
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: 3,
                      //     mainAxisSpacing: 3.0,
                      //     crossAxisSpacing: 3.0
                      //   ),
                      //   shrinkWrap: true,
                      //   padding: const EdgeInsets.all(10.0),
                      //   itemCount: _listOfImage.length,
                      //   itemBuilder: (context, index) {
                      //     return GridTile(
                      //       child: Material(
                      //         child: GestureDetector(
                      //           child: Stack(
                      //             children: [
                      //               this._nameImages ==
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),

                      //    Container(
                      //      width: 100,
                      //      height: 100,
                      //      child: InkWell(
                      //        // This is where the profile picture of the user goes into
                      //        // child: CircleAvatar(
                      //        //   radius: 100,
                      //        //   backgroundColor: Colors.teal,
                      //        // ),
                      //  child: (_imageURL == null) ? Image.network("https://firebasestorage.googleapis.com/v0/b/aku-application-a7dda.appspot.com/o/logo.jpeg?alt=media&token=50035771-7905-43a3-8b51-256f71e506cf")
                      //        // child: (_image == null) ? CircleAvatar(
                      //        //   radius: 100,
                      //        // ) : Image.file(_image),
                      // : Image.network(_imageURL,fit: BoxFit.fill,),
                      //        onTap: () async {
                      //          // final _picked = await ImagePicker().pickImage(source: ImageSource.camera);
                      //
                      //          uploadImage();
                      //
                      //          // await _storage.ref().child("Images/$_picked").putFile(_image).whenComplete(() {
                      //          //   _storage.ref().getDownloadURL().then((value) {
                      //          //     print("Done: $value");
                      //          //   });
                      //          // });
                      //          // setState(() {
                      //          //   _image = File(_picked.path);
                      //          // });
                      //        },
                      //      ),
                      //    ),

                      SizedBox(
                        height: 15,
                      ),
                      // TextFormField(
                      //   decoration: decoText.copyWith(
                      //     hintText: "johndoe@gmail.com",
                      //     labelText: "Email",
                      //     prefixIcon: Icon(
                      //       Icons.email,
                      //       color: Colors.grey,
                      //     )
                      //   ),
                      //   onChanged: (value) {
                      //     _email = value;
                      //   },
                      //   validator: (value) {
                      //     if (value.endsWith("@gmail.com")) {
                      //       return null;
                      //     } else {
                      //       return "Only gmail email allowed";
                      //     }
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // TextFormField(
                      //   obscureText: true,
                      //   decoration: decoText.copyWith(
                      //       hintText: "eXample123!",
                      //       labelText: "Password",
                      //       prefixIcon: Icon(
                      //         Icons.password,
                      //         color: Colors.grey,
                      //       )
                      //   ),
                      //   onChanged: (value) {
                      //     _password = value;
                      //   },
                      //   validator: (value) {
                      //     if (value.length < 6) {
                      //       return "Need at least 6 characters";
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      TextFormField(
                        decoration: decoText.copyWith(
                            hintText: "John Doe",
                            labelText: "Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            )),
                        controller: _name,
                        onChanged: (value) {
                          _inputName = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                        decoration: decoText.copyWith(
                            labelText: "Gender",
                            prefixIcon: Icon(
                              Icons.transgender,
                              color: Colors.grey,
                            )),
                        value: _gender,
                        items: _genderList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                            // child: TextFormField(
                            //   controller: _gender,
                            // ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _gender = value as String;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: decoText.copyWith(
                            hintText: "12345678",
                            labelText: "Phone Number",
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            )),
                        controller: _contact,
                        onChanged: (value) {
                          _inputContact = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: decoText.copyWith(
                            hintText: "Depressed",
                            labelText: "Medical Condition",
                            prefixIcon: Icon(
                              Icons.medical_services,
                              color: Colors.grey,
                            )),
                        controller: _condition,
                        onChanged: (value) {
                          _condition.text = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        readOnly: true,
                        decoration: decoText.copyWith(
                            hintText: "Check test results here",
                            labelText: "Medical Records",
                            prefixIcon: Icon(
                              Icons.add_chart,
                              color: Colors.grey,
                            )),
                        controller: _records,
                        onChanged: (value) {
                          _records.text = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF337B6E),
                            ),
                            child: Text("Update"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                // print(_email);
                                // print(_password);
                                await _firestore
                                    .collection("users")
                                    .doc(_auth.currentUser.uid)
                                    .update({
                                  "profileURL": _imageURL,
                                  "name": _name.text,
                                  "gender": _gender,
                                  "contact": _contact.text,
                                });
                                print(_imageURL);
                                print(_name.text);
                                print(_gender);
                                print(_contact.text);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorHomePage(),
                                    ));
                              }
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF337B6E),
                            ),
                            child: Text("Cancel"),
                            onPressed: () {
                              setState(() {
                                _name.text = _backupName;
                                _gender = _backupGender;
                                _contact.text = _backupContact;
                                _imageURL = _backupURL;
                              });

                              // if (_formKey.currentState.validate() && _formKey.currentState.) {
                              //
                              //
                              //   // // print(_email);
                              //   // // print(_password);
                              //   // await _firestore.collection("users").doc(_auth.currentUser.uid).update({
                              //   //   "profileURL": _imageURL,
                              //   //   "name": _name.text,
                              //   //   "gender": _gender,
                              //   //   "contact": _contact.text,
                              //   //
                              //   // });
                              //   // print(_imageURL);
                              //   // print(_name.text);
                              //   // print(_gender);
                              //   // print(_contact.text);
                              //   //
                              //   Navigator.pushReplacement(context,
                              //       MaterialPageRoute(builder: (context) => DoctorHomePage(),));
                              //
                              // }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
