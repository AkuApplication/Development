import 'package:flutter/material.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = "confirm-email";
  String text;
  ConfirmEmail(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
