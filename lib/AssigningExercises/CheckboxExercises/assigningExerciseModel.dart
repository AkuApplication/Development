import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AssigningExerciseRecord {
  List<dynamic> steps;
  List<dynamic> details;
  String title;
  String docId;

  AssigningExerciseRecord({this.steps, this.details, this.title, this.docId});
}