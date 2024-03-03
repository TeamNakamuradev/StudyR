import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

Future<void> _launchInWebView(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
    throw Exception('Could not launch $url');
  }
}

_launchURL() async {
  final Uri url = Uri.parse('https://flutter.dev');
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw Exception('Could not launch ${url}');
  }
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
                // FilePickerResult? result = await FilePicker.platform.pickFiles(
                //   type: FileType.custom,
                //   allowedExtensions: ['pdf'],
                // );

                // if (result != null) {
                //   setState(() {
                //     _pdfFile = File(result.files.single.path!);
                //   });
                // }
                launchUrl(Uri.parse('https://www.pdf.ai/documents'),
                    mode: LaunchMode.inAppBrowserView);
              },
              child: Text('Upload PDF'),
            ),
            SizedBox(height: 20),
            if (_pdfFile != null)
              ElevatedButton(
                onPressed: () async {
                  // var doc = ;
                  // var text = doc.text;
                  // print(text);
                  launchUrl(Uri.parse('https://www.pdf.ai/documents'),
                      mode: LaunchMode.inAppBrowserView);
                },
                child: Text('Extract Text'),
              ),
          ],
        ),
      ),
    );
  }
}
