import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/Clients_list.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:demo/screens/firebase_api.dart';

import 'Employees/Requests_list.dart';

class Tp_RenewRequestsPage extends StatefulWidget {
  const Tp_RenewRequestsPage({Key? key}) : super(key: key);

  @override
  State<Tp_RenewRequestsPage> createState() => _Tp_RenewRequestsPageState();
}

class _Tp_RenewRequestsPageState extends State<Tp_RenewRequestsPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseFirestore.instance;
  List<Object> _clientsList = [];
  List<Object> _renewreqstatus = [];
  var companyname;

  @override
  void didChangeDependencies(){
    getTpCompanyname();
    getRequestInfo();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:  _createClientRequestCard(_clientsList),
      ),
    );
  }
  Future getTpCompanyname() async{
    print('heyy');
    print(user?.uid);
    var docSnapshot = await databaseReference
        .collection('ThirdParties')
        .doc(user?.uid)
        .get();
    // print(docSnapshot);
    // print(docSnapshot.exists);
    if(docSnapshot.exists){
      Map<String, dynamic> data = docSnapshot.data()!;
      companyname = data['CompanyName'];
      print('hey $companyname');
      getRequestInfo();
    }
  }

  Future getRequestInfo() async{
    print('Hello');
    var data = await FirebaseFirestore.instance
        .collection('Employee_Clients')
    // .where("Option", isEqualTo: 'buy')
    // .orderBy('Date', descending: false)
        .get();

    setState(() {
      _clientsList = List.from(data.docs.map((doc) => ClientRequests.fromSnapshot(doc)));
      // print(requestid);
      print(_clientsList);
    });
    await getReqStatus();
  }
  Future getReqStatus()async{
    var reqstatus_data = await FirebaseFirestore.instance
        .collection('ThirdParties_Quotations')
        .where('CompanyName', isEqualTo: '$companyname')
        .get();

    setState(() {
      _renewreqstatus = List.from(reqstatus_data.docs.map((doc) => TpQuotations.fromSnapshot(doc)));
    });
  }

  Widget _createClientRequestCard(List companyClientList){
    List<Widget> list = <Widget>[];
    for (int i = 0; i < companyClientList.length; i++){
      // print('in for');
      if(companyClientList[i].company.contains(companyname)){
        if(companyClientList[i].option == 'renew'){
          list.add(
            Container(
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print(companyClientList[i].reqid);
                        print(companyClientList[i].userid);
                        print(companyClientList[i].company);
                        print(companyClientList[i].category);
                        print(companyClientList[i].option);
                        // if(companyClientList[i].option == 'buy'){
                        //   Navigator.push(this.context, MaterialPageRoute(builder: (context) => BuyClientInfo(clientreqid: companyClientList[i].reqid,empid: companyClientList[i].empid, compname : companyname)));
                        // }
                        // else if(companyClientList[i].option == 'renew'){
                        //   Navigator.push(this.context, MaterialPageRoute(builder: (context) => RenewClientInfo(clientreqid: companyClientList[i].reqid,empid: companyClientList[i].empid, compname : companyname)));
                        // }

                        // if(companyClientList[i].option == 'buy' || companyClientList[i].option == 'renew'){
                        Navigator.push(this.context, MaterialPageRoute(builder: (context) => ClientInfo(clientreqid: companyClientList[i].reqid,empid: companyClientList[i].empid, compname : companyname, option: companyClientList[i].option)));
                        // }
                        // else{
                        //   Navigator.push(this.context, MaterialPageRoute(builder: (context) => ClaimClientInfo(clientreqid: companyClientList[i].reqid,empid: companyClientList[i].empid, compname : companyname, option: companyClientList[i].option)));
                        // }
                      },
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Request ID: ${companyClientList[i].reqid}",
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Category: ${companyClientList[i].category}",
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Option: ${companyClientList[i].option}",
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "User ID: ${companyClientList[i].userid}",
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Employee ID: ${companyClientList[i].empid}",
                            ),
                          ),
                          _tprequeststatus(_renewreqstatus,companyClientList[i].reqid),
                        ],
                      ),
                    )

                ),
              ),
            ),
          );
        }
      }
      // else{
      //   print('error retrieving');
      // }
    }
    return ListView(children: list);
  }
  Widget _tprequeststatus(List reqstatuslist,String requestid){
    print('in reqstatus, $requestid $reqstatuslist');
    for(int j=0; j<_renewreqstatus.length; j++){
      print(j);
      if(reqstatuslist[j].requestid == requestid && reqstatuslist[j].compname == companyname){
        print('in if ${reqstatuslist[j].requestid} ${reqstatuslist[j].compname} ');
        return Container(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Quotation sent',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        );
      }
      else{
        // print('in else');
        continue;
        // if(reqstatuslist[i].requestid != requestid && reqstatuslist[i].compname != companyname){
        //   print('in else ${reqstatuslist[i].requestid} ${reqstatuslist[i].compname} ');
        //   return Container(
        //     child: Align(
        //       alignment: Alignment.bottomRight,
        //       child: Text(
        //         'Quotation not sent',
        //         style: TextStyle(
        //           color: Colors.red,
        //         ),
        //       ),
        //     ),
        //   );
        // }
      }
    }
    return Container();
  }
  // void signOut() async{
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.signOut();
  //   Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  // }
}

class ClientInfo extends StatefulWidget {
  final String? clientreqid;
  final String? empid;
  final String? compname;
  final String? option;
  const ClientInfo({Key? key,@required this.clientreqid,@required this.empid,@required this.compname,@required this.option}) : super(key: key);

  @override
  State<ClientInfo> createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  String? client_requestid;
  String? employee_id;
  String? company_name;
  String? req_option;
  File? file;
  bool _isVisible = false;
  UploadTask? task;
  var dateString;
  var dateTime;
  var date;
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    dateString = DateTime.now().toString();
    dateTime = DateTime.parse(dateString!);
    date = "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}.${dateTime.minute}.${dateTime.second}";
  }

  @override
  Widget build(BuildContext context) {
    client_requestid = widget.clientreqid;
    employee_id = widget.empid;
    company_name = widget.compname;
    req_option = widget.option;
    // final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         signOut();
        //       },
        //       icon: Icon(Icons.logout_outlined))
        // ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Employee_Clients')
                      .where("RequestID", isEqualTo: '$client_requestid')
                  // .orderBy("age", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    else{
                      return ListView(
                        children: snapshot.data!.docs.map((e) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Category: ${e.data()['Category']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Option: ${e.data()['Option']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Age: ${e.data()['Age']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Policy Number: ${e.data()['PolicyNumber']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Port: ${e.data()['Port']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'Health Updates : ${e.data()['HealthUpdates']}',
                                    ),
                                  ),

                                  // Padding(padding: EdgeInsets.only(bottom: 10.0),
                                  //   child: Text(
                                  //     'Existing Disease: ${e.data()['ExistingDisease']}',
                                  //   ),
                                  // ),
                                  // _getExistingDisease(e.data()['DiseaseName']),
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
              Flexible(
                child: ElevatedButton.icon(
                    label: Text(
                      'Select File',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    icon: Icon(Icons.attach_file_outlined),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                    ),
                    onPressed: ()async {
                      print('button pressed');
                      _displayDialog(context);
                    }
                  // showfileName = false;
                  // print('$showfileName');
                  //     await showDialog<void>(
                  //       context: this.context, barrierDismissible: false, // user must tap button!
                  //
                  //       builder: (BuildContext context) {
                  //         bool showfileName = false;
                  //         return AlertDialog(
                  //           title: Text('Select File'),
                  //           content: SingleChildScrollView(
                  //             child: ListBody(
                  //               children: [
                  //                 OutlinedButton.icon(
                  //                   label: Text('Browse from device'),
                  //                   icon: Icon(Icons.web),
                  //                   onPressed: () async {
                  //                     print('pressed');
                  //                     // print(showfileName);
                  //                     _displayDialog(context);
                  //                   },
                  //                     // print(flag);
                  //         //             final selected_file = await FilePicker.platform.pickFiles(allowMultiple: false);
                  //         //             if(selected_file == null){
                  //         //               // setState(() {
                  //         //               //   showfileName = false;
                  //         //               // });
                  //         //               // flag =0;
                  //         //               return;
                  //         //             }
                  //         //             else{
                  //         //               final path = selected_file.files.single.path!;
                  //         //               // flag = 1;
                  //         //               setState(() {
                  //         //                 file = File(path);
                  //         //                 showfileName = true;
                  //         //                 // flag = 1;
                  //         //               });
                  //         //               print('heyyyy $path $showfileName');
                  //         //               // print('heyyyy $path $flag');
                  //         //             }
                  //         //             // await selectFile();
                  //         //
                  //         //             //   if(flag ==1){
                  //         //             //     print('hey');
                  //         //             //     showfileName = true;
                  //         //             //   }
                  //         //           },
                  //         //         ),
                  //         //         SizedBox(height: 10.0,),
                  //         //         Visibility(
                  //         //           visible: showfileName,
                  //         //           child: Text(
                  //         //             'hey',
                  //         //           ),
                  //         //         )
                  //         //
                  //         //       ],
                  //         //     ),
                  //         //   ),
                  //         //   actions: [
                  //         //     ElevatedButton.icon(
                  //         //       label: Text('Upload'),
                  //         //       icon: Icon(Icons.upload_file_outlined),
                  //         //       onPressed: () {
                  //         //         print('Upload Pressed');
                  //         //       },
                  //         //     ),
                  //         //     // flag == 1 ? Text(
                  //         //     //   'hey',
                  //         //     // ): SizedBox()
                  //         //   ],
                  //         // );
                  //         // // return StatefulBuilder(
                  //         //     builder: (context,setState){
                  //         //       bool showfileName = false;
                  //         //       // int flag = 0;
                  //         //       return AlertDialog(
                  //         //         title: Text('Select File'),
                  //         //         content: SingleChildScrollView(
                  //         //           child: ListBody(
                  //         //             children: [
                  //         //               OutlinedButton.icon(
                  //         //                 label: Text('Browse from device'),
                  //         //                 icon: Icon(Icons.web),
                  //         //                 onPressed: () async {
                  //         //                   print('pressed');
                  //         //                   print(showfileName);
                  //         //                   // print(flag);
                  //         //                   final selected_file = await FilePicker.platform.pickFiles(allowMultiple: false);
                  //         //                   if(selected_file == null){
                  //         //                     // setState(() {
                  //         //                     //   showfileName = false;
                  //         //                     // });
                  //         //                     // flag =0;
                  //         //                     return;
                  //         //                   }
                  //         //                   else{
                  //         //                     final path = selected_file.files.single.path!;
                  //         //                     // flag = 1;
                  //         //                     setState(() {
                  //         //                       file = File(path);
                  //         //                       showfileName = true;
                  //         //                       // flag = 1;
                  //         //                     });
                  //         //                     print('heyyyy $path $showfileName');
                  //         //                     // print('heyyyy $path $flag');
                  //         //                   }
                  //         //                   // await selectFile();
                  //         //
                  //         //                   //   if(flag ==1){
                  //         //                   //     print('hey');
                  //         //                   //     showfileName = true;
                  //         //                   //   }
                  //         //                 },
                  //         //               ),
                  //         //               SizedBox(height: 10.0,),
                  //         //               Visibility(
                  //         //                 visible: showfileName,
                  //         //                 child: Text(
                  //         //                   'hey',
                  //         //                 ),
                  //         //               )
                  //         //
                  //         //             ],
                  //         //           ),
                  //         //         ),
                  //         //         actions: [
                  //         //           ElevatedButton.icon(
                  //         //             label: Text('Upload'),
                  //         //             icon: Icon(Icons.upload_file_outlined),
                  //         //             onPressed: () {
                  //         //               print('Upload Pressed');
                  //         //             },
                  //         //           ),
                  //         //           // flag == 1 ? Text(
                  //         //           //   'hey',
                  //         //           // ): SizedBox()
                  //         //         ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     );
                  //     // selectFilePopUp();
                  //   },
                  // ),
                ),
              ),
            ],
          )
      ),
    );

  }
  void _displayDialog(BuildContext context) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          // this was required, rest is same
          String? fileName;
          _isVisible = false;
          return StatefulBuilder(
              builder: (BuildContext context, setState){
                return AlertDialog(
                    title: Text('Select File'),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutlinedButton.icon(
                            label: Text('Browse from device'),
                            icon: Icon(Icons.web),
                            onPressed: () async{
                              print('button pressed');
                              print(_isVisible);
                              final selected_file = await FilePicker.platform.pickFiles(allowMultiple: false);
                              if(selected_file == null){
                                return;
                              }
                              else{
                                final path = selected_file.files.single.path!;
                                // flag = 1;
                                setState(() {
                                  file = File(path);
                                  // showfileName = true;
                                  _isVisible = true;
                                  fileName = file != null ? basename(file!.path) : 'No File Selected';
                                  // flag = 1;
                                });
                                print('heyyyy $path $_isVisible');
                              }
                            },

                          ),
                          SizedBox(height: 5.0,),
                          Visibility(
                            visible: _isVisible,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                '$fileName',
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton.icon(
                              label: Text('Upload'),
                              icon: Icon(Icons.upload_file_outlined),
                              onPressed: () {
                                print('Upload Pressed');
                                uploadFile();
                              },
                            ),
                          ),
                          SizedBox(height: 10.0),
                          task != null ? buildUploadStatus(task!) : Container(),
                          // Align(
                          //   alignment:  Alignment.bottomRight,
                          //   child: Container(
                          //     task != null ? buildUploadStatus(task!) : Container(),
                          //   ),
                          // )
                        ]
                    )
                );
              }
          );
        });
  }

  // Future selectFile()async{
  //
  //   // showfileName = false;
  //   final selected_file = await FilePicker.platform.pickFiles(allowMultiple: false);
  //   if(selected_file == null){
  //     // setState(() {
  //     //   showfileName = false;
  //     // });
  //     // flag =0;
  //     return;
  //   }
  //   else{
  //     final path = selected_file.files.single.path!;
  //     // flag = 1;
  //     setState(() {
  //       file = File(path);
  //       showfileName = true;
  //       flag = 1;
  //     });
  //     print('heyyyy $path $showfileName');
  //   }
  // }

  Future uploadFile() async{
    if(file == null){
      return;
    }
    else{
      final uploadfile = basename(file!.path);
      final destination = 'files/$uploadfile';

      task = FirebaseApi.uploadFile(destination,file!);
      setState(() {});

      if(task == null) {
        return;
      }
      final snapshot = await task!.whenComplete(() {});
      final docurl = await snapshot.ref.getDownloadURL();
      print('Doc URL $docurl');
      await databaseReference
          .collection('ThirdParties_Quotations')
          .add({
        'RequestID' : '$client_requestid',
        'EmployeeID' : '$employee_id',
        'CompanyName' : '$company_name',
        'QuotationURL' : '$docurl',
        'Date' : date
      });

      await databaseReference
          .collection('User_Requests')
          .where('RequestID', isEqualTo: '$client_requestid')
          .get()
          .then((value) => value.docs.forEach((doc) {
        doc.reference.update({'Status' : 'Quotations received. Soon our executive will contact you'});
      })).catchError((error) => print('Status not updated: $error'));

      // .where('RequestID' , isEqualTo: '$client_requestid')

    }
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context,snapshot){
      if(snapshot.hasData){
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;

        return Text(
          '$progress %',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        );
      }
      else{
        return Container();
      }
    },
  );

// void signOut() async{
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   await auth.signOut();
//   Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
// }
}
