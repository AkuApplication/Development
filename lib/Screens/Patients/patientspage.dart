import 'package:flutter/material.dart';

class Patients extends StatelessWidget {
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
                  //Hafizzan
                  Card(
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
                          Text('Nur Hafizzan'),
                        ],
                      ),
                    ),
                  ),
                  ExpansionTile(
                      title: Text(
                          'Details for Nur Hafizzan',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          letterSpacing: 0.5,
                          color: Colors.blueGrey,
                        ),
                      ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Full Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                SelectableText(
                                  'Muhammad Nur Hafizzan bin Kadir',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SelectableText(
                              'Gender: Male',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0.5,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'Qualification:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  )
                                ),
                                SelectableText(
                                    '• Ph. D. in Psychology',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s in Psychology' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Counseling' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Social Work' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Advance Psychiatric Nursing' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Languages: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Malay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Hafiz
                  Card(
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
                          Text('Hafiz'),
                        ],
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Details for Hafiz',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'Full Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                SelectableText(
                                  'Muhammad Hafiz bin Daud',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SelectableText(
                              'Gender: Male',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0.5,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Qualification:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Ph. D. in Psychology',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s in Psychology' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Counseling' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Social Work' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Advance Psychiatric Nursing' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Languages: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Malay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Mahdi
                  Card(
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
                          Text('Mahdi'),
                        ],
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Details for Mahdi',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'Full Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                SelectableText(
                                  'Muhammad Mahdi bin Haji Mohammad Yaakub',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SelectableText(
                              'Gender: Male',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0.5,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Qualification:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Ph. D. in Psychology',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s in Psychology' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Counseling' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Social Work' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Advance Psychiatric Nursing' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Languages: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Malay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Shanna
                  Card(
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
                          Text('Shanna Rania'),
                        ],
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Details for Shanna Rania',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'Full Name: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                SelectableText(
                                  'Shanna Rania binti Hussin',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SelectableText(
                              'Gender: Female',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0.5,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Qualification:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Ph. D. in Psychology',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s in Psychology' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Counseling' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Social Work' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Advance Psychiatric Nursing' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Languages: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Malay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Amal
                  Card(
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
                          Text('Amal'),
                        ],
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Details for Amal',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 0.5,
                        color: Colors.blueGrey,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'Full Name:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                                SelectableText(
                                  'Amal Nurul Nazirah binti Haji Mohammad Adi Yusli',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 0.5,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SelectableText(
                              'Gender: Female',
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                letterSpacing: 0.5,
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Qualification:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Ph. D. in Psychology',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s in Psychology' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Counseling' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Social Work' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Master\'s Degree in Advance Psychiatric Nursing' ,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                    'Languages: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                                SelectableText(
                                    '• Malay',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 0.5,
                                      color: Colors.black87,
                                      height: 1.5,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // InkWell(
                  //   onTap: () {  print('This will show the therapist\'s catalog'); },
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     elevation: 10.0,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(15.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 32.0,
                  //             backgroundColor: Colors.transparent,
                  //             child: Image.network(
                  //               'https://image.flaticon.com/icons/png/512/3969/3969738.png',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Text('Hafizzan'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {  print('This will show the therapist\'s catalog'); },
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     elevation: 10.0,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(15.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 32.0,
                  //             backgroundColor: Colors.transparent,
                  //             child: Image.network(
                  //               'https://image.flaticon.com/icons/png/512/3969/3969741.png',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Text('Hafizzan'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {  print('This will show the therapist\'s catalog'); },
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     elevation: 10.0,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(15.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 32.0,
                  //             backgroundColor: Colors.transparent,
                  //             child: Image.network(
                  //               'https://image.flaticon.com/icons/png/512/3969/3969743.png',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Text('Hafizzan'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {  print('This will show the therapist\'s catalog'); },
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     elevation: 10.0,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(15.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 32.0,
                  //             backgroundColor: Colors.transparent,
                  //             child: Image.network(
                  //               'https://image.flaticon.com/icons/png/512/3969/3969750.png',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Text('Hafizzan'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: () {  print('This will show the therapist\'s catalog'); },
                  //   child: Card(
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     elevation: 10.0,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(15.0),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           CircleAvatar(
                  //             radius: 32.0,
                  //             backgroundColor: Colors.transparent,
                  //             child: Image.network(
                  //               'https://image.flaticon.com/icons/png/512/3969/3969755.png',
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Text('Hafizzan'),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
