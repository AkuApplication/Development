import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Aku Application'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5.0,
                          blurRadius: 7.0,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: Text(
                              'AKU Application',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Center(
                            child: Text(
                              'AKU Application is an online and on-demand counseling service. '
                              'Users can choose their preferable counselors and reach out to them'
                              'in 3 ways; Users can either Chat, Voice Call or Video Call. With this, '
                              'users can rest easy and just focus on improving their mental health. Each '
                              'counselors has at least 4 years experience in dealing with mental illness, '
                              'and is professionally trained.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w100,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
