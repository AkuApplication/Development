import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Question {
  String id;
  String question;
  List<String> options;

  // final String chooseOption;

  Question({
    @required this.id,
    @required this.question,
    @required this.options,
    // @required this.chooseOption,
  });

  // Question copyWith({
  //   String id,
  //   String question,
  //   List<String> options,
  //   // String chooseOption,
  // }) {
  //   return Question(
  //     id: id ?? this.id,
  //     question: question ?? this.question,
  //     options: options ?? this.options,
  //     // chooseOption: chooseOption ?? this.chooseOption,
  //   );
  // }

  // dynamic toJson() =>
  //     {
  //       'id': id,
  //       'question': question,
  //       'options': options,
  //     };

  // factory Question.fromJson(Map<String, dynamic> json) {
  //   return Question(
  //       id: json['id'],
  //       question: json['question'],
  //       options: List<String>.from(json['options'])
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'question': question,
  //     'options': options,
  //     // 'highlightOption': chooseOption,
  //   };
  // }
  //
  // factory Question.fromMap(Map<String, dynamic> map) {
  //   return Question(
  //     id: map['id'],
  //     question: map['question'],
  //     options: List<String>.from(map['options']),
  //     // chooseOption: map['chooseOption'],
  //   );
  // }
  //
  // factory Question.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
  //   final data = snapshot.data() as Map<String, dynamic>;
  //   final id = snapshot.id;
  //   data['id'] = id;
  //   return Question.fromMap(data);
  // }
  //
  // String toJson() => json.encode(toMap());
  //
  // factory Question.fromJson(String source) => Question.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'Question(id: $id, question: $question, options: $options)';
  // }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //
  //   return other is Question &&
  //       other.id == id &&
  //       other.question == question &&
  //       listEquals(other.options, options);
  //   // other.chooseOption == chooseOption;
  // }
  //
  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //   question.hashCode ^
  //   options.hashCode;
  //   // chooseOption.hashCode;
  // }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Map<String, dynamic> toMap() {
  //   return {
  //     "question": question
  //   };
  // }
  //
  // List<Map> convertListToMap({List<Question> questions}){
  //   List<Map> quest = [];
  //   questions.forEach((element) {
  //     Map que = element.toMap();
  //     quest.add(que);
  //   });
  //   return quest;
  // }

  void uploadToFirebase(Map<String, dynamic> record, String condition) async {
    await _firestore.collection('records').doc(_auth.currentUser.uid).collection("record").add({
      "record": record,
      "time": FieldValue.serverTimestamp()
    });
    // await _firestore.collection("users").doc(_auth.currentUser.uid).update({
    //   "condition":
    // });
  }
  // List<String> justQuestions = [];

  // void getJustQuestions() {
  //   List<String> justQuestions = [];
  //   for(int i = 0; i < 10; i++){
  //     justQuestions.add(allQuestion[i].question);
  //   }
  // }

}

// List<String> justQuestions = [allQuestion.iterator.current.question.toString()];


List<Question> allQuestion = [
  Question(
    id: '1',
    question: 'I feel like I am watching myself and not being present',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '2',
    question: 'I have been sleeping a lot',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '3',
    question: 'I have been feeling restless',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '4',
    question: 'I have difficulties remembering important appointments',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '5',
    question: 'I cannot focus on simple tasks',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '6',
    question: 'I lost interest in activities I enjoy',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '7',
    question: 'I am indecisive',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '8',
    question: 'I have trouble sleeping',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '9',
    question: 'I feel overwhelmed doing my tasks',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
  Question(
    id: '10',
    question: 'I feel worthless',
    options: ['Never', 'Rarely', 'Often', 'Very Often'],
    // chooseOption: 'Never',
  ),
];