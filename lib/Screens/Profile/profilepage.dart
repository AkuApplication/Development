import 'dart:io';

import 'package:chat_app/InputDecoration/Decoration.dart';
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
  String _name;
  String _gender;
  String _contact;
  String _condition;
  String _records;
  File _image;
  String _imageURL;

  final _formKey = GlobalKey<FormState>();
  final _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> _genderList = ["Male", "Female"];

  void uploadImage() async {
    final _picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    _image = File(_picked.path);
    String fileName = _image.path;
    Reference reference = FirebaseStorage.instance.ref().child("uploads/" + _auth.currentUser.uid + "/$fileName");
    UploadTask upload = reference.putFile(_image);
    TaskSnapshot task = await upload.whenComplete(() => null);
    task.ref.getDownloadURL().then((value) {
      setState(() {
        _imageURL = value;
      });
    });
  }

  @override
  void initState() {
    var referenceImage = _storage.ref().child("uploads/" + _auth.currentUser.uid)
        .getDownloadURL().then((value) {
          setState(() {
            _imageURL = value;
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Color(0xFF337B6E),
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
                      InkWell(
                        // This is where the profile picture of the user goes into
                        // child: CircleAvatar(
                        //   radius: 100,
                        //   backgroundColor: Colors.teal,
                        // ),
                        child: (_image == null) ? CircleAvatar(
                          radius: 100,
                        // ) : Image.file(_image),
                  ) : Image.network(_imageURL,fit: BoxFit.fill,),
                        onTap: () async {
                          // final _picked = await ImagePicker().pickImage(source: ImageSource.camera);

                          uploadImage();
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
                            )
                        ),
                        onChanged: (value) {
                          _name = value;
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
                            )
                        ),
                        items: _genderList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
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
                            )
                        ),
                        onChanged: (value) {
                          _contact = value;
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
                            )
                        ),
                        onChanged: (value) {
                          _condition = value;
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
                            )
                        ),
                        onChanged: (value) {
                          _records = value;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF337B6E),
                        ),
                        child: Text("Update"),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            // print(_email);
                            // print(_password);
                            print(_name);
                            print(_gender);
                            print(_contact);
                            print(_condition);
                            print(_records);
                          }
                        },
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
