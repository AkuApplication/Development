import 'dart:math';

import 'package:chat_app/MentalHealthTest/testRecords/recordCard.dart';
import 'package:chat_app/MentalHealthTest/testRecords/recordModel.dart';
import 'package:chat_app/ReportGeneration/homepage.dart';
import 'package:chat_app/ReportGeneration/pdf_creator/mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Patients extends StatefulWidget {
  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List patientList = [];
  List<RecordCard> recordCards;
  List recordAnswer = [];
  List recordQuestion = [];
  List recordTimestamp = [];
  Record recordObject;

  void getDataFromFirestore() async {
    await _firestore.collection("users").where("accountType", isEqualTo: "Patient").get().then((value) {
      setState(() {
        patientList = value.docs.toList();
      });
    });
  }

  @override
  void initState() {
    getDataFromFirestore();
    super.initState();
  }



   @override
  Widget build(BuildContext context) {
     // Provide us total height & width of our screen
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF337B6E),
        title: Text('Patients'),
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
            child: ListView.builder(
              itemCount: patientList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                              backgroundImage: NetworkImage(patientList[index]["profileURL"]),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(patientList[index]["name"]),
                          ],
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Text(
                        'Details for ${patientList[index]["name"]}',
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
                              SelectableText(
                                'Full Name: ${patientList[index]["name"]}',
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
                              SelectableText(
                                'Gender: ${patientList[index]["gender"]}',
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
                              SelectableText(
                                'Contact: ${patientList[index]["contact"]}',
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
                              SelectableText(
                                'Email: ${patientList[index]["email"]}',
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
                              SelectableText(
                                'Condition: ${patientList[index]["condition"]}',
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
                              SelectableText(
                                'No. of logins: ${patientList[index]["numOfLogins"]}',
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
                              SelectableText(
                                'Mental Health Test Records: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 0.5,
                                  color: Colors.black87,
                                  height: 1.5,
                                ),
                              ),
                              StreamBuilder(
                                stream: _firestore.collection("records").doc(patientList[index]["uid"]).collection("record").snapshots(),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    final records = snapshot.data.docs;

                                    recordCards = [];
                                    for (var record in records) {
                                      recordObject = Record(
                                          questions: record["record"]["questions"],
                                          answers: record["record"]["answers"],
                                          timestamp: record["time"]
                                      );

                                      recordQuestion.add(record["record"]["questions"]);
                                      recordAnswer.add(record["record"]["answers"]);
                                      recordTimestamp.add(record["time"]);

                                      recordCards.add(RecordCard(
                                        record: recordObject,
                                      ));
                                    }

                                    return Column(
                                      children: recordCards,
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Generate Report"),
                          onPressed: () async {
                            //Create a PDF document.
                            final PdfDocument document = PdfDocument();
                            //Add page to the PDF
                            final PdfPage page = document.pages.add();
                            //Get page client size
                            final Size pageSize = page.getClientSize();
                            //Draw rectangle border
                            page.graphics.drawRectangle(
                                bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
                                pen: PdfPen(PdfColor(0, 139, 139)));
                            //Generate PDF grid.
                            // final PdfGrid grid = getGrid();
                            //Draw the header section by creating text element
                            final PdfLayoutResult result = drawHeader(recordAnswers: recordAnswer, recordQuestions: recordQuestion, recordTimestamp: recordTimestamp ,page: page, pageSize: pageSize, name: patientList[index]["name"], gender: patientList[index]["gender"], contact: patientList[index]["contact"], condition: patientList[index]["condition"], email: patientList[index]["email"], noOfLogins: "${patientList[index]["numOfLogins"]}", recordCards: recordCards);
                            //Draw grid
                            // drawGrid(page, grid, result);
                            //Add invoice footer
                            drawFooter(page, pageSize);
                            //Save the PDF document
                            final List<int> bytes = document.save();
                            //Dispose the document.
                            document.dispose();
                            //Save and launch the file.
                            await saveAndLaunchFile(bytes, 'Report.pdf');
                          }
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _createPDF() async {
  //   //Create a PDF document.
  //   final PdfDocument document = PdfDocument();
  //   //Add page to the PDF
  //   final PdfPage page = document.pages.add();
  //   //Get page client size
  //   final Size pageSize = page.getClientSize();
  //   //Draw rectangle border
  //   page.graphics.drawRectangle(
  //       bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
  //       pen: PdfPen(PdfColor(0, 139, 139)));
  //   //Generate PDF grid.
  //   // final PdfGrid grid = getGrid();
  //   //Draw the header section by creating text element
  //   final PdfLayoutResult result = drawHeader(page, pageSize);
  //   //Draw grid
  //   // drawGrid(page, grid, result);
  //   //Add invoice footer
  //   drawFooter(page, pageSize);
  //   //Save the PDF document
  //   final List<int> bytes = document.save();
  //   //Dispose the document.
  //   document.dispose();
  //   //Save and launch the file.
  //   await saveAndLaunchFile(bytes, 'Report.pdf');
  // }

  //Draws the invoice header
  PdfLayoutResult drawHeader({List recordCards, List recordQuestions, List recordAnswers, List recordTimestamp, PdfPage page, Size pageSize, String name, String gender, String contact, String email, String condition, String noOfLogins,}) {
    //Draw the 1st rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(0, 139, 139)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 140, 90));
    //Draw string for the 1st rectangle
    page.graphics.drawString(
        'AKU Application Report', PdfStandardFont(PdfFontFamily.helvetica, 24),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 140, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    //Draw the 2nd rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(380, 0, pageSize.width - 380, 90),
        brush: PdfSolidBrush(PdfColor(220, 20, 60)));
    // Standard font size that will be used throughout the pdf
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
    //Draw string for the 2nd rectangle
    page.graphics.drawString(
        'CONFIDENTIAL\nCONFIDENTIAL\nCONFIDENTIAL', contentFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(380, 0, pageSize.width - 380, 90),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle,
            lineSpacing: 0.5));
    // Generate random number for serial number
    Random _randomNumber = new Random();
    int _serialNumber = _randomNumber.nextInt(999999) + 9999;
    //Create date format and convert it to text.
    final DateTime now = DateTime.now();
    final String _dateFormat = DateFormat('dd / MM / yyyy').format(now);
    final String _timeFormat = DateFormat('kk:mm').format(now);
    final String _date =
        'Date: \n' + _dateFormat + '\n\nTime: \n' + _timeFormat;
    final Size contentSize = contentFont.measureString(_date);
    // ignore: leading_newlines_in_multiline_strings <-- dun know
    List<String> list = [];
    String record;
    // for(int j = 0; j < recordCards.length; j++){
    //   for(int i = 0; i < recordQuestion.length; i ++){
    //     record = "Mental Health Test Record No.$j" + "\n"
    //         "Question $i" + ". " + recordQuestion[i] + "\n"
    //         "Answer $i" + ". " + recordAnswer[i];
    //     // list.add(record);
    //   }
    //
    String _details;
      _details = "Patient's Name: \n" +
          name +
          "\n\nPatient's Email: \n" +
          email +
          "\n\nPatient's Contact: \n" +
          contact +
          "\n\nPatient's Condition: \n" +
          condition +
          "\n\nPatient's No. of Logins: \n" +
          noOfLogins +
          "\n\nPatient's Gender: \n" +
          gender
      ;
    PdfTextElement(text: _date, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height));

    return PdfTextElement(text: _details, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height));
  }

  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.solid);
    linePen.dashPattern = <double>[5, 5];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 50),
        Offset(pageSize.width, pageSize.height - 50));

    const String footerContent = "Please treat with extreme confidentiality";

    //Added 30 as a margin for the layout
    page.graphics.drawString(
        footerContent, PdfStandardFont(PdfFontFamily.helvetica, 12),
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
        bounds:
        Rect.fromLTWH(pageSize.width - 120, pageSize.height - 34, 0, 0));
  }
}


