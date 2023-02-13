import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:demo/screens/makepdfs.dart';

class PDFPreviewPage extends StatelessWidget {
  final int? userage;
  final String? smoke_status;
  final String? tobacco_status;
  final String? ins_type;
  final String? disease_status;
  // const PDFPreviewPage({Key? key, @required this.userage,@required this.smoke_status,@required this.tobacco_status,@required this.ins_type,@required this.disease_status}) : super(key: key);

  const PDFPreviewPage({Key? key, @required this.userage,@required this.smoke_status,@required this.tobacco_status,@required this.ins_type,@required this.disease_status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('PDF Preview'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: PdfPreview(
          build: (context) => makePdf(userage!,smoke_status!,tobacco_status!,ins_type!,disease_status!)
      ),
    );
  }
}


