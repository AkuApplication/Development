import 'package:chat_app/Authenticate/ConfirmEmail.dart';
import 'package:chat_app/Authenticate/LoginScreen.dart';
import 'package:chat_app/Authenticate/Methods.dart';
import 'package:chat_app/InputDecoration/Decoration.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscureText = true;

  String _email;
  String _password;
  String _message = "An email has just been sent to you. Click the link provided in the email to "
      + "complete registration";

  final _formKey = GlobalKey<FormState>();

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
                "Create Account to Continue!",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: size.width,
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
                      width: size.width,
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
                    width: size.width,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                        obscureText: _obscureText,
                        validator: (value) {
                          if(value.length > 5){
                            if(value == _password){
                              return null;
                            } else {
                              return "Password does not match";
                            }
                          } else {
                            return "Need at least 6 character";
                          }
                          },
                        decoration: decoText.copyWith(
                            hintText: "confirm password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.grey,
                            )
                        )
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
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => LoginScreen())),
                    child: Text("Already have an Account ?",
                        style: TextStyle(
                          color: Colors.teal.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )
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
      onTap: () {
        if (_formKey.currentState.validate() ){

          Methods().createAccount(_email, _password).then((user) {
            if (user != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ConfirmEmail(_message),));
              print("goint to confimation email for creating account");
            } else {
              print("Login Failed");
            }
          });
        } else {
          print("Please enter Fields");
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
          "Create Account",
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
