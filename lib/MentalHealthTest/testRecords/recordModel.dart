import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  List<dynamic> questions;
  List<dynamic> answers;
  Timestamp timestamp;

  Record({this.questions, this.answers, this.timestamp});
}