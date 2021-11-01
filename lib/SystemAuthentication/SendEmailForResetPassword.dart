import 'package:chat_app/assets/InputDecoration/Decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendEmailResetPassword extends StatefulWidget {
  @override
  _SendEmailResetPasswordState createState() => _SendEmailResetPasswordState();
}

class _SendEmailResetPasswordState extends State<SendEmailResetPassword> {
  //Getting related Firebase instances to be able to interact with Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Initializing variables
  String account;
  String _email;
  String _message = "An email has just been sent to you. Click the latest link provided in your email to reset your password";

  //Created a FormKey to interact with the Form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: size.width / 1.2,
                child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                width: size.width / 1.3,
                child: Text(
                  "Reset your password",
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
                  "Insert the email that you want to reset its password ",
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
                              hintText: "Email",
                              prefixIcon: Icon(
                                  Icons.account_box,
                                  color: Colors.grey
                              )
                          )
                      ),
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
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () async {
        //Validate the form
        if (_formKey.currentState.validate() ){
          showDialog(context: context, barrierDismissible: false, builder: (context) {
            return WillPopScope(
              onWillPop: () => null,
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

          //SendPasswordResetEmail to the inputted email
          await _auth.sendPasswordResetEmail(email: _email).then((value) {
            Navigator.pop(context);
            showDialog(context: context, barrierDismissible: false, builder: (context) {
              return WillPopScope(
                onWillPop: () => null,
                child: AlertDialog(
                  content: Text(
                    _message,
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
          }).onError((error, stackTrace) {
            Navigator.pop(context);
            showDialog(context: context, barrierDismissible: false, builder: (context) {
              return WillPopScope(
                onWillPop: () => null,
                child: AlertDialog(
                  content: Text(
                    error.message,
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
          });
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
          "Reset Password",
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
