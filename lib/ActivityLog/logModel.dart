import 'package:cloud_firestore/cloud_firestore.dart';

class Log {
  String type;
  String otherUser;
  Timestamp timeStarted;
  Timestamp timeEnded;
  List conversationRecords;
  List assignedExercises;

  Log({this.type, this.otherUser, this.timeStarted, this.timeEnded, this.conversationRecords, this.assignedExercises});
}