import 'package:flutter/material.dart';

var decoText = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  fillColor: Colors.grey.shade100,
  filled: true,
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.teal.shade300, width: 2.0),
  borderRadius: BorderRadius.circular(8.0),
  ),
  enabledBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
  borderRadius: BorderRadius.circular(8.0),
  ),
);
