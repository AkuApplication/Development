import 'package:flutter/material.dart';

class Therapists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provide us total height & width of our screen
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF337B6E),
        title: Text('Therapists'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Color(0xFF337B6E),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36.0),
                bottomRight: Radius.circular(36.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(45.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969766.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969724.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969772.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969730.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969733.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969738.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969741.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969743.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969750.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('This will show the therapist\'s catalog');
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32.0,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                'https://image.flaticon.com/icons/png/512/3969/3969755.png',
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text('Hafizzan'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
