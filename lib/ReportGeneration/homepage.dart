import 'package:flutter/material.dart';
import 'package:chat_app/ReportGeneration/pdf_creator/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ReportGenerationHomePage extends StatefulWidget {

  @override
  _ReportGenerationHomePageState createState() => _ReportGenerationHomePageState();
}

class _ReportGenerationHomePageState extends State<ReportGenerationHomePage> {
  // To get user input
  TextEditingController _nameController = TextEditingController();
  TextEditingController _conditionController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // To make sure the form are filled
  // Validation?
  // var _formKey = GlobalKey<FormState>();

  // Error message
  // var _errorMessage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      }, // So that we unfocus our textfield whenever we're not click on it.
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15.0),
            ),
          ),
          title: Text('Report Generation'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  // key: _formKey,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Patient's Name",
                    hintText: "e.g. Shadownote69",
                    // errorText: _errorName,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: _conditionController,
                  decoration: InputDecoration(
                    labelText: "Patient's Condition",
                    hintText: "e.g. Good",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Decription / Report",
                    hintText: "e.g. This patient is improving",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 15.0,
                ),
                // PDF(),
                ElevatedButton(
                  child: Text('Generate Report'),
                  onPressed: _createPDF,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    page.graphics.drawString(
      'Patient\'s Name: ' + _nameController.text,
      PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    page.graphics.drawString(
      '\nPatient\'s Condition: ' + _conditionController.text,
      PdfStandardFont(PdfFontFamily.helvetica, 24),
    );
    page.graphics.drawString(
      '\n\n\nReport: \n\n ' + _descriptionController.text,
      PdfStandardFont(PdfFontFamily.helvetica, 24),
      format: PdfStringFormat(alignment: PdfTextAlignment.justify),

    );

    List<int> bytes = document.save();
    document.dispose();

    saveAndLaunchFile(bytes, 'Report.pdf');
  }
}
