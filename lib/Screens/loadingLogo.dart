import 'dart:async';

import 'package:chat_app/SystemAuthentication/Autheticate.dart';
import 'package:flutter/material.dart';

class LoadingLogo extends StatefulWidget {
  @override
  _LoadingLogoState createState() => _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo> {

  @override
  //Showing logo just for a few second at the start of the app
  void initState() {
    Timer(Duration(seconds: 3), navigateToAuthenticate);
    super.initState();
  }

  //Created a function callback just for the timer to work as intended
  void navigateToAuthenticate() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("lib/assets/images/logo.jpeg"),
      ),
    );
  }
}
