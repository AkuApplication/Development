import 'package:cloud_firestore/cloud_firestore.dart';

class EditMentalHealthTestRecord {
  List<dynamic> steps;
  List<dynamic> details;
  String title;
  String docId;

  EditMentalHealthTestRecord({this.steps, this.details, this.title, this.docId});
}