import 'package:cloud_firestore/cloud_firestore.dart';

class EditMentalHealthTestRecord {
  List<dynamic> questions;
  List<dynamic> answers;
  List<dynamic> scores;
  String docId;
  String lengthOfAnswers;

  EditMentalHealthTestRecord({this.questions, this.answers, this.scores, this.docId, this.lengthOfAnswers});
}