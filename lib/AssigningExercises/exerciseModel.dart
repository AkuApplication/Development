import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Exercise {
  bool firstExercise;
  bool secondExercise;
  bool thirdExercise;
  bool fourthExercise;
  bool fifthExercise;
  double progressValue;
  Timestamp timestamp;

  Exercise({this.firstExercise, this.secondExercise, this.thirdExercise, this.fourthExercise, this.fifthExercise, this.progressValue, this.timestamp});
}