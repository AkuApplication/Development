import 'package:chat_app/Screens/patientHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormForOTP extends StatefulWidget {
  // String verificationId;

  @override
  _FormForOTPState createState() => _FormForOTPState();
}

class _FormForOTPState extends State<FormForOTP> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpCode = TextEditingController();

  OutlineInputBorder border = OutlineInputBorder();

  bool isLoading = false;

  String verificationId;

  bool obscureText = true;

  void setObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.8,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: otpCode,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: "Enter Otp",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      border: border,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setObscureText();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {

                      }
                    },
                    child: Text("SignIn", style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.teal
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
  }
}

