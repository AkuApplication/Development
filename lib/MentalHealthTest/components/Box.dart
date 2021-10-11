import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: child,
    );
  }
}