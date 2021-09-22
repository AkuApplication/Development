import 'package:chat_app/Authenticate/CreateAccount.dart';
import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/Authenticate/ConfirmEmail.dart';
import 'package:chat_app/Authenticate/SendEmailForResetPassword.dart';
import 'package:chat_app/Screens/doctorHomePage.dart';
import 'package:chat_app/Screens/homepage.dart';
import 'package:chat_app/InputDecoration/Decoration.dart';
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

  String _email = "";
  String _password = "";
  String _message = "You are not yet verified. Please click on the link provided in the email "
      + "to complete registration.";

  String _account;
  String _name;
  String _profileURL;

  void checkFirestore() async {
    try{
      await _firestore.collection("users").doc(_auth.currentUser.uid).get().then((value){
        _account = value.data()["accountType"];
        // _name = value.data()["name"];
        // _profileURL = value.data()["profileURL"];

        if(_account == "Patient"){
          print("go to patient 2");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage(),));
        } else if(_account == "Doctor"){
          print("go to doctor 2");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DoctorHomePage(),));
        }

      });
    } catch(e){
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1.2,
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
            ),
            SizedBox(
              height: size.height / 50,
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
                    width: size.width / 1.2,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      validator: (value) {
                        if(value.endsWith("@gmail.com")){
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
                          hintText: "email",
                          prefixIcon: Icon(
                            Icons.account_box,
                            color: Colors.grey)
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width / 1.2,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        obscureText: _obscureText,
                        validator: (value) {
                          if(value.length > 5){
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
                          hintText: "password",
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          )
                        )
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 60, right: 150),
                    child: InkWell(
                      child: Row(
                        children: [
                          Checkbox(
                            value: !_obscureText,
                            onChanged: (value) {
                              _togglePass();
                              },
                          ),
                          Text("Show / Hide Password")
                        ],
                      ),
                      onTap: () {
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccount()));
                    },
                    child: Text("Don’t have an Account ? ",
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => SendEmailResetPassword()));
                    },
                    child: Text("Forgot your password ? ",
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
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          await Methods().logIn(_email, _password, _account).then((user) {
            if(user == null){
              setState(() {
                print("Could not sign with those credentials");
              });
            } else {
              if(!(user.emailVerified)){
                print("Email not verified");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ConfirmEmail(_message),));
              } else {
                print("email verified");
                checkFirestore();
              }
            }
          });

        } else {
          print("Please fill form correctly");
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
