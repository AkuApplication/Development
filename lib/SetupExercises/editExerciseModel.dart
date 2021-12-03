import 'package:cloud_firestore/cloud_firestore.dart';

class EditExerciseRecord {
  List<dynamic> steps;
  List<dynamic> details;
  String title;
  String docId;

  EditExerciseRecord({this.steps, this.details, this.title, this.docId});
}