import 'package:chat_app/Authenticate/ConfirmEmail.dart';
import 'package:chat_app/InputDecoration/Decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendEmailResetPassword extends StatefulWidget {
  @override
  _SendEmailResetPasswordState createState() => _SendEmailResetPasswordState();
}

class _SendEmailResetPasswordState extends State<SendEmailResetPassword> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String account = "";
  String _email = "";
  String _message = "An email has just been sent to you. Click the link provided in the email "
      + "to reset your password";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
              "Reset your password",
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
                  // child: field(size, "email", Icons.account_box, _email),
                ),
                SizedBox(
                  height: size.height / 5,
                ),
                customButton(size),
                SizedBox(
                  height: size.height / 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate() ){
          try{
            _formKey.currentState.save();
            await _auth.sendPasswordResetEmail(email: _email);
            print("Sent Password Reset Email");

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ConfirmEmail(_message),));
          }catch(e){
            print(e);
          }
          print(_email);

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
          "Send Email for Reset Password",
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
