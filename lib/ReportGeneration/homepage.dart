import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat_app/ReportGeneration/pdf_creator/mobile.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ReportGenerationHomePage extends StatefulWidget {

  @override
  _ReportGenerationHomePageState createState() => _ReportGenerationHomePageState();
}

class _ReportGenerationHomePageState extends State<ReportGenerationHomePage> {
  // To get user input
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // So that we can unfocus from our text field.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Patient's Name",
                    hintText: "e.g. John Doe",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Patient's Email",
                    hintText: "e.g. john@doe.com",
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
                    hintText: "e.g. This is John Doe",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 15.0,
                ),
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

  // This is the old layout
  // Future<void> _createPDF() async {
  //   PdfDocument document = PdfDocument(); // Create a PDF Document
  //   final page = document.pages.add(); // Add page to the PDF
  //   final Size pageSize = page.getClientSize(); // Get page client size
  //
  //   // Draw rectangle
  //   page.graphics.drawRectangle(
  //       bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
  //       pen: PdfPen(PdfColor(142, 170, 219, 255)));
  //
  //   page.graphics.drawString(
  //     'Patient\'s Name: ' + _nameController.text,
  //     PdfStandardFont(PdfFontFamily.helvetica, 24),
  //   );
  //   page.graphics.drawString(
  //     '\nPatient\'s Condition: ' + _emailController.text,
  //     PdfStandardFont(PdfFontFamily.helvetica, 24),
  //   );
  //   page.graphics.drawString(
  //     '\n\n\nReport: \n\n' + _descriptionController.text,
  //     PdfStandardFont(PdfFontFamily.helvetica, 24),
  //     format: PdfStringFormat(alignment: PdfTextAlignment.justify),
  //   );
  //
  //   List<int> bytes = document.save();
  //   document.dispose();
  //
  //   saveAndLaunchFile(bytes, 'Report.pdf');
  // }

  Future<void> _createPDF() async {
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
    final PdfLayoutResult result = drawHeader(page, pageSize);
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

  //Draws the invoice header
  PdfLayoutResult drawHeader(PdfPage page, Size pageSize) {
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
    String _details = "Patient's Name: \n" +
        _nameController.text +
        "\n\nPatient's Email: \n" +
        _emailController.text +
        "\n\n\nReport: \n\n" +
        _descriptionController.text;

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
