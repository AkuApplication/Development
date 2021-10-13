import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

//Model for our Question
class Question {
  //Initializing variables
  String id;
  String question;
  List<String> options;
  List<int> gradeScore;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Constructor of Question
  Question({
    @required this.id,
    @required this.question,
    @required this.options,
    @required this.gradeScore
  });

  //Method for uploading the record for each MentalHealthTest taken and updating the condition according to the latest test result
  void uploadToFirebase(Map<String, dynamic> record, String condition) async {
    await _firestore.collection('records').doc(_auth.currentUser.uid).collection("record").add({
      "record": record,
      "time": FieldValue.serverTimestamp()
    });
    await _firestore.collection("users").doc(_auth.currentUser.uid).update({
      "condition": condition
    });
  }

}

// TODO: Integrate the Questions into FirebaseFirestore. This is just a sample
List<Question> allQuestion = [
  Question(
    id: '1',
    question: 'I feel like I am watching myself and not being present',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0]
    // chooseOption: 'Never',
  ),
  Question(
    id: '2',
    question: 'I have been sleeping a lot',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '3',
    question: 'I have been feeling restless',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '4',
    question: 'I have difficulties remembering important appointments',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '5',
    question: 'I cannot focus on simple tasks',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '6',
    question: 'I lost interest in activities I enjoy',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '7',
    question: 'I am indecisive',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '8',
    question: 'I have trouble sleeping',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '9',
    question: 'I feel overwhelmed doing my tasks',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
  Question(
    id: '10',
    question: 'I feel worthless',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    gradeScore: [1, 1, 0, 0],
    // chooseOption: 'Never',
  ),
];