import 'dart:io';

import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Therapist User ProfilePage
class CounsellorProfile extends StatefulWidget {
  @override
  _CounsellorProfileState createState() => _CounsellorProfileState();
}

class _CounsellorProfileState extends State<CounsellorProfile> {
  //Initializing variables
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _profession = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File _image;
  String _imageURL;
  String _gender;
  List<String> _genderList = ["Male", "Female"];

  //Variables for inputting previous data when the the textfield value changes
  String _backupName;
  String _backupGender;
  String _backupContact;
  String _backupProfession;
  String _backupURL;

  //Getting related Firebase instances to be able to interact with the firebase features
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Created a default Gender Icon to be able to change its state later on accordingly
  Icon icon = Icon(
    Icons.transgender,
    color: Colors.grey,
  );

  //Method for getting data from Firebase
  void checkFirestore() async {
    await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value) {
      setState(() {
        _name.text = value.data()["name"];
        _backupName = _name.text;

        _gender = value.data()["gender"];
        _backupGender = _gender;

        _contact.text = value.data()["contact"];
        _backupContact = _contact.text;

        _profession.text = value.data()["profession"];
        _backupProfession = _profession.text;

        _imageURL = value.data()["profileURL"];
        _backupURL = _imageURL;
      });
    });
  }

  //Method for uploading the picked Camera Image to Firebase Storage
  void uploadImageUsingCamera() async {
    Navigator.pop(context);
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
    });
  }

  //Method for uploading the picked Gallery Image to Firebase Storage
  void uploadImageUsingGallery() async {
    Navigator.pop(context);
    final _picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = File(_picked.path);
    String _fileName = _image.path;
    Reference reference = _storage.ref().child("images/$_fileName");
    UploadTask upload = reference.putFile(_image);
    TaskSnapshot task = await upload.whenComplete(() => null);
    task.ref.getDownloadURL().then((value) async {
      setState(() {
        _imageURL = value;
      });
    });
  }

  @override
  void initState() {
    checkFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal.shade300,
        title: Text('Profile'),
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
                      Container(
                        width: 200,
                        height: 200,
                        child: InkWell(
                          child: (_imageURL == null) ?
                          Column(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                  backgroundImage: AssetImage("lib/assets/images/logo.jpeg"),
                                  radius: 80,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Click Image Above to Change Profile Picture", textAlign: TextAlign.center,)
                            ],
                          ) :
                          Column(
                            children: [
                              Expanded( 
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(_imageURL),
                                  radius: 80,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Click Image Above to Change Profile Picture", textAlign: TextAlign.center,)
                            ],
                          ),
                          onTap: () async {
                            showModalBottomSheet(context: context, builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          uploadImageUsingGallery();
                                        },
                                        icon: Icon(Icons.image, size: 100,),
                                        label: Text("Gallery"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF337B6E),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          uploadImageUsingCamera();
                                        },
                                        icon: Icon(Icons.camera_alt, size: 100,),
                                        label: Text("Camera"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF337B6E),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },);
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: decoText.copyWith(
                            labelText: "Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.grey,
                            )
                        ),
                        controller: _name,
                        onChanged: (value) {
                          value = _name.text;
                        },
                        validator: (value) {
                          if(value.isEmpty) {
                            return "Required your name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                        decoration: decoText.copyWith(
                            labelText: "Gender",
                            prefixIcon: icon
                        ),
                        value: _gender,
                        items: _genderList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _gender = value as String;
                          if(_gender == "Female"){
                            setState(() {
                              icon = Icon(
                                Icons.female,
                                color: Colors.grey,
                              );
                            });
                          } else if(_gender == "Male"){
                            setState(() {
                              icon = Icon(
                                Icons.male,
                                color: Colors.grey,
                              );
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: decoText.copyWith(
                            labelText: "Phone Number",
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey,
                            )
                        ),
                        controller: _contact,
                        onChanged: (value) {
                          value = _contact.text;
                        },
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: decoText.copyWith(
                            labelText: "Profession",
                            prefixIcon: Icon(
                              Icons.work,
                              color: Colors.grey,
                            )
                        ),
                        controller: _profession,
                        onChanged: (value) {
                          value = _profession.text;
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
                              showDialog(context: context, barrierDismissible: false, builder: (context) {
                                return WillPopScope(
                                  onWillPop: () {},
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

                              if (_formKey.currentState.validate()) {
                                await _firestore.collection("users").doc(_auth.currentUser.uid).update({
                                  "profileURL": _imageURL,
                                  "name": _name.text,
                                  "gender": _gender,
                                  "contact": _contact.text,
                                  "profession": _profession.text,
                                });

                                setState(() {
                                  _backupURL = _imageURL;
                                  _backupName = _name.text;
                                  _backupGender = _gender;
                                  _backupContact = _contact.text;
                                  _backupProfession = _profession.text;
                                });

                                Navigator.pop(context);
                                showDialog(context: context, barrierDismissible: false, builder: (context) {
                                  return WillPopScope(
                                    onWillPop: () {},
                                    child: AlertDialog(
                                      content: Text(
                                        "Successfully updated your profile page",
                                        textAlign: TextAlign.center,
                                      ),
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
                              } else {
                                Navigator.pop(context);
                                showDialog(context: context, barrierDismissible: false, builder: (context) {
                                  return WillPopScope(
                                    onWillPop: () {},
                                    child: AlertDialog(
                                      content: Text(
                                        "Please don't leave the required fields empty",
                                        textAlign: TextAlign.center,
                                      ),
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
                                _profession.text = _backupProfession;
                              });
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
