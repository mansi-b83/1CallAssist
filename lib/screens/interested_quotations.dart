import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:demo/screens/user_payment.dart';

class User_InterestedQuotations extends StatefulWidget {
  const User_InterestedQuotations({Key? key}) : super(key: key);

  @override
  State<User_InterestedQuotations> createState() => _User_InterestedQuotationsState();
}

class _User_InterestedQuotationsState extends State<User_InterestedQuotations> {
  final User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseFirestore.instance;

  // @override
  // void didChangeDependencies(){
  //   getInterestedQuotations();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Employee_Clients')
                    .where("UserID", isEqualTo: '${user?.uid}')
                // .orderBy("age", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    // print(snapshot.data!.docs);
                    // return Text('Hello');
                    return ListView(
                      children: snapshot.data!.docs.map((e) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [

                                // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Category: ${e.data()['Category']}',
                                //   ),
                                // ),
                                // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Option: ${e.data()['Option']}',
                                //   ),
                                // ),
                                // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Age: ${e.data()['Age']}',
                                //   ),
                                // ),
                                // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Smoke: ${e.data()['Smoke']}',
                                //   ),
                                // ),
                                // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Tobacco: ${e.data()['Tobacco']}',
                                //   ),
                                // ),
                                // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Insurance Type: ${e.data()['InsuranceType']}',
                                //   ),
                                // ),
                                // Padding(
                                //   padding: EdgeInsets.only(bottom: 10.0),
                                //   child: Text(
                                //     'Existing Disease: ${e.data()['ExistingDisease']}',
                                //
                                //   ),
                                // ),

                                _InterestedQuotationURL(e.data()['InterestedQuotation'],e.data()['RequestID'],e.data()['Option']),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),

      )

    );
  }
  Widget _InterestedQuotationURL(quotation_url,reqid,option){
    print('in func');
    if(quotation_url != null){
      // return Container(
        // child: Text(
        //   '$reqid: $quotation_url',
        // ),
        if(option == 'buy'){
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(
                    '$reqid:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('View Quotation'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                    ),
                    onPressed: (){
                      print('ViewQuotation button pressed');
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => QuotationsSent()))
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotation_url)));
                    },
                  ),
                ),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: Text('Buy'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                        ),
                        onPressed: (){
                          print('Buy button pressed');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Integrate(req_id: reqid, quotationURL: quotation_url, opt: option)));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotation_url)));
                        },
                      ),

                    )
                  ],
                )
                // Column(
                //   children: [
                //     Padding(padding: EdgeInsets.all(10.0),
                //       child: Text(
                //         '$reqid:'
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          );
        }
        else{
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(10.0),
                  child: Text(
                    '$reqid:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                ),

                Padding(padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    child: Text('View Quotation'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                    ),
                    onPressed: (){
                      print('ViewQuotation button pressed');
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => QuotationsSent()))
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotation_url)));
                    },
                  ),
                ),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        child: Text('Renew'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                        ),
                        onPressed: (){
                          print('Renew button pressed');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Integrate(req_id: reqid, quotationURL: quotation_url, opt: option)));
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotation_url)));
                        },
                      ),

                    )
                  ],
                )
                // Column(
                //   children: [
                //     Padding(padding: EdgeInsets.all(10.0),
                //       child: Text(
                //         '$reqid:'
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          );
        }

      // );
    }
    // else{
    //   // return Text('');
    // }
    else{
      // return ;
      return
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30,bottom: 10,right: 10,top: 10),
              child: Text(
                '$reqid:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),
              child: Text(
                  'No quotations',
              ),
            )
        ],
        );
    }
    // return Container();
  }
  // Future getInterestedQuotations() async{
  //   print('Hello');
  //   var data = await databaseReference
  //       .collection('Employee_Clients')
  //       .where("UserID", isEqualTo: '${user?.uid}')
  //   // .orderBy('Date', descending: false)
  //       .get()
  //       .then((event) {
  //         if(event.docs.isNotEmpty){
  //           Map<String, dynamic> documentData = event.docs.data;
  //           var url = documentData['InterestedQuotation'];
  //         }
  //   })
  //
  //   setState(() {
  //     _requestidList = List.from(data.docs.map((doc) => TpQuotations.fromSnapshot(doc)));
  //     // print(requestid);
  //     // print(_requestList);
  //   });
  // }

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
