// import 'dart:io';
//
// import 'package:demo/screens/Employees/Requests_list.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:printing/printing.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:flutter_downloader/flutter_downloader.dart';
// // import 'package:open_file/open_file.dart';
// // import 'package:file_picker/file_picker.dart';
// class QuatationsRecdPage extends StatefulWidget {
//   // final String? curremp;
//   const QuatationsRecdPage({Key? key}) : super(key: key);
//
//   @override
//   State<QuatationsRecdPage> createState() => _QuatationsRecdPageState();
// }
//
// class _QuatationsRecdPageState extends State<QuatationsRecdPage> {
//   // String? currloggedinemp;
//   final User? user = FirebaseAuth.instance.currentUser;
//   final databaseReference = FirebaseFirestore.instance;
//
//   List _quotationList = [];
//   File? file;
//
//   @override
//   void didChangeDependencies(){
//     getQuotations();
//     super.didChangeDependencies();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // currloggedinemp = widget.curremp;
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
//         child: _createQuotationCard(_quotationList),
//         // child: Text(
//         //   '${user?.uid}',
//         // ),
//       ),
//     );
//   }
//
//   Future getQuotations() async{
//     print('Hello');
//     var data = await databaseReference
//         .collection('ThirdParties_Quotations')
//         .where("EmployeeID", isEqualTo: '${user?.uid}')
//     // .orderBy('Date', descending: false)
//         .get();
//
//     setState(() {
//       _quotationList = List.from(data.docs.map((doc) => TpQuotations.fromSnapshot(doc)));
//       // print(requestid);
//       // print(_requestList);
//     });
//   }
//
//   Widget _createQuotationCard(List quotationList){
//
//     List<Widget> list = <Widget>[];
//     for(int i = 0; i < quotationList.length; i++){
//       list.add(
//         Container(
//           child: Card(
//             child: Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: InkWell(
//                   splashColor: Colors.blue.withAlpha(30),
//                   // onTap: () {
//                   //   // buy_user_requestid = requestList[i].requestid;
//                   //   // buy_user_contactno = requestList[i].contactno;
//                   //   // buy_user_id = requestList[i].userid;
//                   //   // buy_ins_category = requestList[i].category;
//                   //   // ins_option = requestList[i].option;
//                   //   print("Quotation URL- ${quotationList[i].quotation_url}");// assume that id is in .id field
//                   //   print("Request ID- ${quotationList[i].requestid}");
//                   //   print("Company Name- ${quotationList[i].compname}");
//                   //
//                   // },
//                   child: Column(
//                     children: [
//                       Padding(padding: EdgeInsets.all(10.0),
//                         child: Text(
//                           "Request ID: ${quotationList[i].requestid}",
//                         ),
//                       ),
//                       Padding(padding: EdgeInsets.all(10.0),
//                         child: Text(
//                           'Company: ${quotationList[i].compname}'
//                         ),
//                         // child: Row(
//                         //   children: [
//                         //     Expanded(
//                         //         child: Column(
//                         //           children: [
//                         //             Text(
//                         //               "Category: ${quotationList[i].compname}",
//                         //             ),
//                         //           ],
//                         //         ),
//                         //     ),
//                         //    Expanded(
//                         //        child:  Column(
//                         //          children: [
//                         //            Text(
//                         //              "Quotation: ${quotationList[i].quotation_url}",
//                         //            ),
//                         //          ],
//                         //        ),
//                         //    ),
//                         //   ],
//                         // )
//                       ),
//                       Padding(padding: EdgeInsets.all(10),
//                       //     child: Text(
//                       //     'Quotation: ${quotationList[i].quotation_url}'
//                       // ),
//                         child: ElevatedButton(
//                           child: Text('View PDF'),
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
//                           ),
//                           onPressed: (){
//                             print('view pdf button pressed ${quotationList[i].quotation_url}');
//                             Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
//                           },
//                         )
//
//                       ),
//                     ],
//                   ),
//                 )
//
//             ),
//           ),
//         ),
//       );
//     }
//     return ListView(children: list);
//   }
// }
//
// class ViewPDF extends StatefulWidget {
//   final String? pathPDF;
//   const ViewPDF({Key? key,@required this.pathPDF}) : super(key: key);
//   @override
//   State<ViewPDF> createState() => _ViewPDFState();
// }
//
// class _ViewPDFState extends State<ViewPDF> {
//
//   // String? pdfurl;
//   @override
//   Widget build(BuildContext context) {
//     final pdfurl = widget.pathPDF;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Colors.orangeAccent,
//         // actions: [
//         //   IconButton(
//         //     onPressed: () async{
//         //       // print(pdfurl?.split(RegExp(r'(%2F)..*(%2F)'))[1].split(".")[0]);
//         //       final taskId = await FlutterDownloader.enqueue(
//         //         url: '$pdfurl',
//         //         savedDir: '/storage/emulated/0/Download/',
//         //         showNotification: true, // show download progress in status bar (for Android)
//         //         openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//         //       );
//         //       // downloadFileExample(pdfurl!);
//         //       // final ref = FirebaseStorage.instance.ref('files/$pdfurl');
//         //       // print(ref);
//         //       // File file = File()
//         //       // await downloadFileExample(pdfurl!);
//         //       final snackBar = SnackBar(
//         //         content: Text('Downloaded'),
//         //       );
//         //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         //     },
//         //     icon: Icon(Icons.download),
//         //   ),
//         //
//         // ],
//       ),
//       body: SfPdfViewer.network('$pdfurl'),
//       // body: PDFView(
//       //   filePath: widget.pathPDF,
//       // ),
//     );
//   }
// }

import 'dart:io';

import 'package:demo/screens/Employees/Requests_list.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:printing/printing.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'suggested_premium.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:open_file/open_file.dart';
// import 'package:file_picker/file_picker.dart';
class QuatationsRecdPage extends StatefulWidget {
  // final String? curremp;
  const QuatationsRecdPage({Key? key}) : super(key: key);

  @override
  State<QuatationsRecdPage> createState() => _QuatationsRecdPageState();
}

class _QuatationsRecdPageState extends State<QuatationsRecdPage> {
  // String? currloggedinemp;
  final User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseFirestore.instance;

  List _requestidList = [];
  File? file;

  @override
  void didChangeDependencies(){
    getReqid();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    // currloggedinemp = widget.curremp;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: (){
              signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        child: _createRequestIDCard(_requestidList),
        // child: Text(
        //   '${user?.uid}',
        // ),
      ),
    );
  }

  Future getReqid() async{
    print('Hello');
    var data = await databaseReference
        .collection('ThirdParties_Quotations')
        .where("EmployeeID", isEqualTo: '${user?.uid}')
    // .orderBy('Date', descending: false)
        .get();

    setState(() {
      _requestidList = List.from(data.docs.map((doc) => TpQuotations.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
    });
  }

  Widget _createRequestIDCard(List reqidList){

    List<Widget> list = <Widget>[];
    List unique_reqid = [];
    for(int i = 0; i < reqidList.length; i++){
      if(unique_reqid.contains(reqidList[i].requestid)){
        print(unique_reqid);
        continue;
      }
      else{
        unique_reqid.add(reqidList[i].requestid);
        // StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('Employee_Clients')
        //       .where('RequestID' ,isEqualTo: '${reqidList[i].requestid}')
        //       .snapshots(),
        //   builder: (context,snapshot){
        //     if(!snapshot.hasData){
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     else{
        //       return ListView(
        //         children: snapshot.data!.docs.map((e) {
        //           if(e.data()['isPurchased'] == null){
        //             // list.add(
        //             //   Container(
        //             //     child: Card(
        //             //       child: Padding(
        //             //           padding: EdgeInsets.all(12.0),
        //             //           child: InkWell(
        //             //             splashColor: Colors.blue.withAlpha(30),
        //             //             child: Row(
        //             //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             //               children: [
        //             //                 Column(
        //             //                   children: [
        //             //                     Padding(padding: EdgeInsets.all(10.0),
        //             //                       child: Text(
        //             //                         "Request ID: ${reqidList[i].requestid}",
        //             //                       ),
        //             //                     ),
        //             //                   ],
        //             //                 ),
        //             //                 Column(
        //             //                   children: [
        //             //                     Padding(padding: EdgeInsets.all(10.0),
        //             //                       child: ElevatedButton(
        //             //                         child: Text('Quotations'),
        //             //                         style: ButtonStyle(
        //             //                             backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
        //             //                         ),
        //             //                         onPressed: (){
        //             //                           print('Quotations button pressed ${reqidList[i].requestid}');
        //             //                           Navigator.push(context, MaterialPageRoute(builder: (context) => QuotationsSent(reqid: reqidList[i].requestid)));
        //             //                           // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
        //             //                         },
        //             //                       ),
        //             //                     ),
        //             //                     Padding(padding: EdgeInsets.all(10.0),
        //             //                       child: ElevatedButton(
        //             //                         child: Text('Suggested Premium'),
        //             //                         style: ButtonStyle(
        //             //                             backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
        //             //                         ),
        //             //                         onPressed: (){
        //             //                           print('Quotations button pressed ${reqidList[i].requestid}');
        //             //                           //Parameter
        //             //                           Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestedPremium(reqidList[i].requestid)));
        //             //                           // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
        //             //                         },
        //             //                       ),
        //             //                     ),
        //             //                   ],
        //             //                 )
        //             //               ],
        //             //             ),
        //             //
        //             //           )
        //             //
        //             //       ),
        //             //     ),
        //             //   ),
        //             // );
        //           }
        //         })
        //       )
        //     }
        //   },
        // )
        list.add(
          Container(
            child: Card(
              child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Request ID: ${reqidList[i].requestid}",
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                child: Text('Quotations'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                                ),
                                onPressed: (){
                                  print('Quotations button pressed ${reqidList[i].requestid}');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => QuotationsSent(reqid: reqidList[i].requestid)));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
                                },
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                child: Text('Suggested Premium'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                                ),
                                onPressed: (){
                                  print('Quotations button pressed ${reqidList[i].requestid}');
                                  //Parameter
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SuggestedPremium(reqidList[i].requestid)));
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                  )

              ),
            ),
          ),
        );
        print(unique_reqid);
      }
    }
    return ListView(children: list);
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}

class QuotationsSent extends StatefulWidget {
  final String? reqid;
  const QuotationsSent({Key? key,@required this.reqid}) : super(key: key);

  @override
  State<QuotationsSent> createState() => _QuotationsSentState();
}

class _QuotationsSentState extends State<QuotationsSent> {
  final User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseFirestore.instance;
  List _quotationsentList = [];
  String? _requestid;

  @override
  void initState(){
    _requestid = widget.reqid;
    getQuotations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _requestid = widget.reqid;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: (){
              signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
         child: _createQuotationCard(_quotationsentList),
        // child: Column(
        //   children: [
        //     _createQuotationCard(_quotationsentList),
        //     Padding(padding: EdgeInsets.fromLTRB(0.0,20,0.0,0.0),
        //         child: Align(
        //           alignment: Alignment.bottomCenter,
        //           child: ElevatedButton(
        //             onPressed: () {
        //               print('button pressed');
        //               _interestedQuotations();
        //               // _sendCompaniesSelected();
        //               final snackBar = SnackBar(
        //                 content: const Text('Successfully sent to customers!'),
        //                 action: SnackBarAction(
        //                   label: 'Ok',
        //                   onPressed: () {
        //                     // Some code to undo the change.
        //                     // Navigator.push(context, MaterialPageRoute(builder: (context) => EmpNavbar()));
        //                   },
        //                 ),
        //               );
        //               ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //             },
        //             child: Text(
        //                 'Send To Customer'
        //             ),
        //             style: ElevatedButton.styleFrom(
        //               // shape: CircleBorder(),
        //               padding: EdgeInsets.all(20),
        //               backgroundColor: Colors.orangeAccent, // <-- Button color
        //               // foregroundColor: Colors.red, // <-- Splash color
        //               alignment: Alignment.bottomRight,
        //             ),
        //           ),
        //         )
        //     ),
        //   ],
        // ),

      ),
    );
  }

  Future getQuotations() async{
    print('Hello $_requestid');
    var data = await databaseReference
        .collection('ThirdParties_Quotations')
        .where("RequestID", isEqualTo: '$_requestid')
    // .orderBy('Date', descending: false)
        .get();

    setState(() {
      _quotationsentList = List.from(data.docs.map((doc) => TpQuotations.fromSnapshot(doc)));
      print(_requestid);
      print(_quotationsentList);
    });
  }


  List quotationChecked = [];
  Widget _createQuotationCard(List quotationList){
    print('in createqutation');

    List<Widget> list = <Widget>[];
    for(int i = 0; i < quotationList.length; i++){
      list.add(
        Container(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  // child: InkWell(
                  //   splashColor: Colors.blue.withAlpha(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                      // Column(
                      //   children: [
                          child: Padding(padding: EdgeInsets.all(10.0),
                              child: Checkbox(
                                value: quotationChecked.contains(quotationList[i].quotation_url),
                                // print('userChecked.contains(companyList[i].companyname)')
                                onChanged: (val) {
                                  print('$val ${quotationList[i].quotation_url}');
                                  _onSelected(val!, quotationList[i].quotation_url);
                                },

                              )

                          ),
                      ),
                      //   ],
                      // ),
                      // Column(
                      //   children: [
                      Expanded(
                          child: Padding(padding: EdgeInsets.all(10.0),
                            child: Text(
                              "${quotationList[i].compname}",
                            ),
                          ),
                      ),
                      //   ],
                      // ),
                      // Column(
                      //   children: [
                      Expanded(
                          child: Padding(padding: EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              child: Text('View PDF'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                              ),
                              onPressed: (){
                                print('ViewPDF button pressed');
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => QuotationsSent()))
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
                              },
                            ),
                          ),
                      ),

                    ],
                    //   )
                    // ],
                  ),

                  // )

                ),
              ),

              // ),
            ],
          ),
        ),
      );

    }
    // return ListView(children: list);
    return Column(
      children: [
        Expanded(
            child: ListView(children: list),
        ),
        Expanded(
          // child: Padding(padding: EdgeInsets.fromLTRB(0.0,20,0.0,0.0),
          child: Align(
            // alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                print('button pressed');
                _interestedQuotations();
                final snackBar = SnackBar(
                  content: const Text('Successfully sent to customers!'),
                  action: SnackBarAction(
                    label: 'Ok',
                    onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => EmpNavbar()));
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                'Send To Customer'
              ),
              style: ElevatedButton.styleFrom(
                // shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.orangeAccent, // <-- Button color
                // foregroundColor: Colors.red, // <-- Splash color
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
        // ),
        ),
      ],
    );

  }

  void _onSelected(bool selected, String quotation_url) {
    // print(curr_userreqid);
    // print(curr_userdocid);
    if (selected == true) {
      setState(() {
        quotationChecked.add(quotation_url);
        print(quotationChecked);
        // productMap = {
        //   '$CompanyName': quotation_url,
        //   // 'price': i['price'],
        //   // 'quantity': i['quantity'],
        // };
        // quotationChecked.add(productMap);

      });
    } else {
      setState(() {
        quotationChecked.remove(quotation_url);
        print(quotationChecked);
      });
    }
  }
  
  void _interestedQuotations() async{
    await databaseReference.collection('Employee_Clients')
        .where('RequestID', isEqualTo: '$_requestid')
        .get()
        .then((value) => value.docs.forEach((doc) {
      doc.reference.update({'InterestedQuotation' : '${quotationChecked[0]}'});
    })).catchError((error) => print('Quotation not added to database: $error'));
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

}


class ViewPDF extends StatefulWidget {
  final String? pathPDF;
  const ViewPDF({Key? key,@required this.pathPDF}) : super(key: key);
  @override
  State<ViewPDF> createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {

  // String? pdfurl;
  @override
  Widget build(BuildContext context) {
    final pdfurl = widget.pathPDF;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.orangeAccent,
        // actions: [
        //   IconButton(
        //     onPressed: () async{
        //       // print(pdfurl?.split(RegExp(r'(%2F)..*(%2F)'))[1].split(".")[0]);
        //       final taskId = await FlutterDownloader.enqueue(
        //         url: '$pdfurl',
        //         savedDir: '/storage/emulated/0/Download/',
        //         showNotification: true, // show download progress in status bar (for Android)
        //         openFileFromNotification: true, // click on notification to open downloaded file (for Android)
        //       );
        //       // downloadFileExample(pdfurl!);
        //       // final ref = FirebaseStorage.instance.ref('files/$pdfurl');
        //       // print(ref);
        //       // File file = File()
        //       // await downloadFileExample(pdfurl!);
        //       final snackBar = SnackBar(
        //         content: Text('Downloaded'),
        //       );
        //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //     },
        //     icon: Icon(Icons.download),
        //   ),
        //
        // ],
      ),
      body: SfPdfViewer.network('$pdfurl'),
      // body: PDFView(
      //   filePath: widget.pathPDF,
      // ),
    );
  }
}
