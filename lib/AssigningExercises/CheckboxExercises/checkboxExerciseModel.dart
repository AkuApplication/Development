import 'package:cloud_firestore/cloud_firestore.dart';

class CheckboxExerciseRecord {
  List<dynamic> steps;
  List<dynamic> details;
  String title;
  String docId;

  CheckboxExerciseRecord({this.steps, this.details, this.title, this.docId});
}