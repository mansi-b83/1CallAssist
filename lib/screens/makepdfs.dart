// import 'dart:html';
// import 'dart:js';

// import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:io';
// import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
Future<Uint8List> makePdf(int userage,String smoke_status,String tobacco_status,String ins_type,String disease_status) async{
  final pdf = Document();
  // final imageLogo = MemoryImage((await rootBundle.load('assets/technical_logo.png')).buffer.asUint8List());
  pdf.addPage(
    Page(
      build: (context){
        return Container(
        margin: EdgeInsets.all(30),
          child: ListView(
            children: [
              Padding(padding: EdgeInsets.only(left: 15.0,top: 30.0,bottom: 15.0,right: 15.0),
                child: Table(
                  border: TableBorder.all(color: PdfColors.black),
                  children: [
                    TableRow(
                        children:[
                          Expanded(
                            child: PaddedText('Age'),
                          ),
                          Expanded(
                            child: PaddedText('$userage'),
                          ),
                        ]
                    ),
                    TableRow(
                        children:[
                          Expanded(
                            child: PaddedText('Do you smoke?'),
                          ),
                          Expanded(
                            child: PaddedText('$smoke_status'),
                          ),
                        ]
                    ),
                    TableRow(
                        children:[
                          Expanded(
                            child: PaddedText('Do ypu consume tobacco'),
                          ),
                          Expanded(
                            child: PaddedText('$tobacco_status'),
                          ),
                        ]
                    ),
                    TableRow(
                        children:[
                          Expanded(
                            child: PaddedText('Insurance Type'),
                          ),
                          Expanded(
                            child: PaddedText('$ins_type'),
                          ),
                        ]
                    ),
                    TableRow(
                        children:[
                          Expanded(
                            child: PaddedText('Any existing disease'),
                          ),
                          Expanded(
                            child: PaddedText('$disease_status'),
                          ),
                        ]
                    ),
                  ],

                )
              // child: Row(
              //   children: [
              //     Flexible(
              //       child: ListTile(
              //         title: Text('Age'),
              //         trailing: Text(
              //           '$custage',
              //         ),
              //       ),
              //     ),
              //   ],
              //
              // )
              ),
            ],
          ),
        );
      }
    ),
  );
  return pdf.save();
}
Widget PaddedText(
      final String text, {
        final TextAlign align = TextAlign.left,
      }) =>
      Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          text,
          textAlign: align,
        ),
      );

// class detailsInPDF extends StatefulWidget {
//   final int? userage;
//   final String? smoke_status;
//   final String? tobacco_status;
//   final String? ins_type;
//   final String? disease_status;
//   const detailsInPDF({Key? key,@required this.userage,@required this.smoke_status,@required this.tobacco_status,@required this.ins_type,@required this.disease_status}) : super(key: key);
//
//   @override
//   State<detailsInPDF> createState() => _detailsInPDFState();
// }
//
// class _detailsInPDFState extends State<detailsInPDF> {
//   int? custage;
//   String? custsmoke_status;
//   String? custtobacco_status;
//   String? custins_type;
//   String? custdisease_status;
//   @override
//   Widget build(BuildContext context) {
//     custage = widget.userage;
//     custsmoke_status = widget.smoke_status;
//     custtobacco_status = widget.tobacco_status;
//     custins_type = widget.ins_type;
//     custdisease_status = widget.disease_status;
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Container(
//         margin:   EdgeInsets.all(30),
//         child: ListView(
//           children: [
//             Padding(padding: EdgeInsets.only(left: 15.0,top: 30.0,bottom: 15.0,right: 15.0),
//                 child: Table(
//                   border: TableBorder.all(color: Colors.black),
//                   children: [
//                     TableRow(
//                         children:[
//                           Expanded(
//                             child: PaddedText('Age'),
//                           ),
//                           Expanded(
//                             child: PaddedText('$custage'),
//                           ),
//                         ]
//                     ),
//                     TableRow(
//                         children:[
//                           Expanded(
//                             child: PaddedText('Do you smoke?'),
//                           ),
//                           Expanded(
//                             child: PaddedText('$custsmoke_status'),
//                           ),
//                         ]
//                     ),
//                     TableRow(
//                         children:[
//                           Expanded(
//                             child: PaddedText('Do ypu consume tobacco'),
//                           ),
//                           Expanded(
//                             child: PaddedText('$custtobacco_status'),
//                           ),
//                         ]
//                     ),
//                     TableRow(
//                         children:[
//                           Expanded(
//                             child: PaddedText('Insurance Type'),
//                           ),
//                           Expanded(
//                             child: PaddedText('$custins_type'),
//                           ),
//                         ]
//                     ),
//                     TableRow(
//                         children:[
//                           Expanded(
//                             child: PaddedText('Any existing disease'),
//                           ),
//                           Expanded(
//                             child: PaddedText('$custdisease_status'),
//                           ),
//                         ]
//                     ),
//                   ],
//
//                 )
//               // child: Row(
//               //   children: [
//               //     Flexible(
//               //       child: ListTile(
//               //         title: Text('Age'),
//               //         trailing: Text(
//               //           '$custage',
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               //
//               // )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget PaddedText(
//       final String text, {
//         final TextAlign align = TextAlign.left,
//       }) =>
//       Padding(
//         padding: EdgeInsets.all(10),
//         child: Text(
//           text,
//           textAlign: align,
//         ),
//       );
// }
