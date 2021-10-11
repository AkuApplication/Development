import 'package:chat_app/MentalHealthTest/components/Box.dart';
import 'package:chat_app/SystemAuthentication/CreateAccount.dart';
import 'package:chat_app/SystemAuthentication/Methods.dart';
import 'package:chat_app/SystemAuthentication/SendEmailForResetPassword.dart';
import 'package:chat_app/MentalHealthTest/Screen/first_time.dart';
import 'package:chat_app/Screens/doctorHomePage.dart';
import 'package:chat_app/Screens/homepage.dart';
import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  String _email;
  String _password;
  String _message = "You are not yet verified." +
      "Please click on the latest link provided in your email to complete registration.";

  String _account;
  int _numOfLogins;

  void checkFirestore() async {
    try {
      await _firestore
          .collection("users")
          .doc(_auth.currentUser.uid)
          .get()
          .then((value) {
        _account = value.data()["accountType"];
        _numOfLogins = value.data()["numOfLogins"];

        if (_account == "Patient") {
          print("go to patient 2");
          if(_numOfLogins < 1){
            print("going to first time 2");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => FirstTime(),));
          } else {
            print("going to patient homepage 2");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomePage(),));
          }

          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomePage(),
          //     ));
        } else if (_account == "Doctor") {
          print("go to doctor 2");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorHomePage(),
              ));
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _togglePass() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 7,
              ),
              Container(
                width: size.width / 1.3,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 70,
              ),
              Container(
                width: size.width / 1.3,
                child: Text(
                  "Sign In to continue!",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: size.width / 1,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                          validator: (value) {
                            if (value.endsWith("@gmail.com")) {
                              return null;
                            } else {
                              return "Only gmail allowed";
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                          cursorColor: Colors.teal.shade300,
                          decoration: decoText.copyWith(
                              hintText: "Email",
                              prefixIcon:
                                  Icon(Icons.email, color: Colors.grey))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: Container(
                        width: size.width / 1,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value.length > 5) {
                                return null;
                              } else {
                                return "Need at least 6 character";
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            cursorColor: Colors.teal.shade300,
                            decoration: decoText.copyWith(
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.grey,
                                ))),
                      ),
                    ),
                    ListTile(
                      title: _obscureText ? Text("Show Password")
                          : Text("Hide Password"),
                      leading: Checkbox(
                        activeColor: Colors.teal.shade300,
                        value: !_obscureText,
                        onChanged: (value) {
                          _togglePass();
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height / 7,
                    ),
                    customButton(size),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => CreateAccount()));
                      },
                      child: Text(
                        "Don’t have an Account ? ",
                        style: TextStyle(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => SendEmailResetPassword()));
                      },
                      child: Text(
                        "Forgot your password ? ",
                        style: TextStyle(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        showDialog(context: context, barrierDismissible: false, builder: (context) {
          return WillPopScope(
            onWillPop: () {},
            child: Dialog(
              insetPadding: EdgeInsets.only(left: 140, right: 140),
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
          await Methods().logIn(_email, _password).then((user) {
            if (user == null) {
              Navigator.of(context).pop();
              showDialog(context: context, barrierDismissible: false, builder: (context) {
                return WillPopScope(
                  onWillPop: () {},
                  child: AlertDialog(
                    content: Text(
                      "Could not sign in with those credentials",
                      textAlign: TextAlign.center,),
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
              if (!(user.emailVerified)) {
                Navigator.of(context).pop();
                showDialog(context: context, barrierDismissible: false, builder: (context) {
                  return WillPopScope(
                    onWillPop: () {},
                    child: AlertDialog(
                      content: Text(
                        _message,
                        textAlign: TextAlign.center,),
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
                checkFirestore();
              }
            }
          });
        } else {
          // print("Please fill form correctly");
          Navigator.of(context).pop();
          showDialog(context: context, barrierDismissible: false, builder: (context) {
            return WillPopScope(
              onWillPop: () {},
              child: AlertDialog(
                content: Text("Please fill the form correctly", textAlign: TextAlign.center,),
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
      child: Container(
        height: size.height / 14,
        width: size.width / 1.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.teal.shade400,
        ),
        alignment: Alignment.center,
        child: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
