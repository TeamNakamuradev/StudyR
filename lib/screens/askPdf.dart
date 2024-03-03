import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

Future<String> extractTextFromPdf(String pdfPath) async {
  // Create an instance of the PDF Text Recognizer
  final pdfTextRecognizer = GoogleMlKit.vision.pdfTextRecognizer();

  // Load the PDF document
  final pdfDocument = await PdfDocument.;

  // Recognize text from the PDF document
  final recognizedText = await pdfTextRecognizer.processDocument(pdfDocument);

  // Extract the text from the PDF document
  String extractedText = "";
  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      for (TextElement element in line.elements) {
        extractedText += "${element.text} ";
      }
      extractedText += "\n";
    }
  }

  // Close the PDF document
  pdfDocument.close();

  return extractedText;
}

// -----

class PdfUploadScreen extends StatefulWidget {
  const PdfUploadScreen({Key? key}) : super(key: key);

  @override
  _PdfUploadScreenState createState() => _PdfUploadScreenState();
}

class _PdfUploadScreenState extends State<PdfUploadScreen> {
  File? _pdfFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  setState(() {
                    _pdfFile = File(result.files.single.path!);
                  });
                }
              },
              child: Text('Upload PDF'),
            ),
            SizedBox(height: 20),
            if (_pdfFile != null)
              ElevatedButton(
                onPressed: () async {
                  var doc = await PDFDoc.fromFile(_pdfFile!);
                  var text = doc.text;
                  print(text);
                },
                child: Text('Extract Text'),
              ),
          ],
        ),
      ),
    );
  }
}



