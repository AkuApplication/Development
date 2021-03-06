import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('About Aku Application'),
        backgroundColor: Color(0xFF337B6E),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundColor: Colors.transparent,
                      child: Image(
                        image: AssetImage('assets/images/logo.jpeg'),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5.0,
                            blurRadius: 7.0,
                            offset: Offset(0, 3),
                          )]
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                  SizedBox(
                    height: 50.0,
                  ),
                  Image.network(
                    'https://as1.ftcdn.net/v2/jpg/02/73/62/48/500_F_273624874_5mkIWqaIwTGCTP0PPhYG8HVUZTQCCtz8.jpg',
                    height: 250.0,
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
