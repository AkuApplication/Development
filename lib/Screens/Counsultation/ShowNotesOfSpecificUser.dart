import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowNotes extends StatelessWidget {
  Map UserSnapshot = Map();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("users").snapshots(),
        builder: (context, snapshot) {
          snapshot.data.docs.forEach((element) {
            UserSnapshot[element.id] = element;
          });

          return StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection("notes").snapshots(),
            builder: (context, snapshot) {
              final int count = snapshot.data.docs.length;
              return ListView.builder(
                itemCount: count,
                itemBuilder: (context, index) {
                  final DocumentSnapshot document = snapshot.data.docs[index];
                  return ListTile(
                    title: Text(document["note"] ?? "<No note Retrieved>"),
                    subtitle: Text("Notes ${index + 1} of $count"),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
