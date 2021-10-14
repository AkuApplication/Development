import 'package:chat_app/MoodTracker/page_1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  //Instances
  final userRef = FirebaseFirestore.instance.collection('score');

  // String lol = "";

  Map<String, dynamic> feedback = {
    'Comment1': "It appears that you are not doing very well, but don't worry. Let us "
        "analyse of what went wrong and how we can tackle the problem. For "
        "starter, you might be emotional about someone or something and that is"
        " fine. Why don't we take it slow; maybe try to control your breathing "
        "or have some sweet(but not too much). Your sugar level might be low or "
        "you're hungry, a little treat won't hurt you. Maybe you're tired, so "
        "why not muster up a bit of courage to tell people that you need some "
        "time to be alone and rest. Tell them that you don't want to hurt their "
        "feelings because you're feeling restless, you can have a talk later "
        "with them once you're feeling rejuvenated. Other than that, try to "
        "stay away from social media interaction and don't forget to drink some "
        "water. Take care of yourself bit by bit, and soon you'll realise how "
        "lovely you are.",
    'Comment2': "Remember to take things on your own pace. Whatever it is, it "
        "is not a race, it is not a competition. Here's something for you\; \""
        "Diamonds are formed under pressure. And bread dough rises when you let "
        "it rest. We are all our own things, what'\s motivating to you may be "
        "crippling to others.",
    'Comment3': "It appears that you are doing good or maybe feeling a little bit "
        "neutral.To make sure that you're in no way of feeling worse, let's "
        "take a step backand see what we can do for today. What about tidy some "
        "things up or clean your shoes even though maybe you don't like to walk "
        "that much. Who knows,maybe someday you will. Or maybe, just take it "
        "easy for the whole day,listen to some of your favourite music or some "
        "lo-fi music. Maybe put on your favourite pajamas even though it is not "
        "the time yet. Just relax, chill and breath and take things at your own pace.",
    'Comment4':
    "It appears that you are doing very well! Here are some compliments for you\; "
        "(Talking to you is like a breath of fresh air.)"
        " (I love your confidence, can you send some of it my way?)"
        " (I love that you can always find that silver lining in bad situations.)"
        " (You’re so inspiring, even if you don’t realize it.)"
        " (Being around you is like a happy little vacation.)",
  };

  @override
  initState() {
    sendComment();
    super.initState();
  }

  // Send comment to database
  sendComment() {
    userRef.doc('Document 3').set(feedback);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Check-in',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 210.0,
                child: Image.asset('assets/q2.png'),
              ),
              Text(
                'Hello there, have a few minutes to reflect on how you\'ve felt today?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => page_one(),));
                  //sendComment(); //Send the data to firebase
                },
                child: Text('Let\'s do it'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 10),
                  primary: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('This will redirect to home');
                },
                child: Text('Not Now'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 10),
                  primary: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
