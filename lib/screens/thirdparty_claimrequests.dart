import 'package:demo/screens/user_payment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/Clients_list.dart';

import 'Employees/Requests_list.dart';

class Tp_ClaimRequestsPage extends StatefulWidget {
  const Tp_ClaimRequestsPage({Key? key}) : super(key: key);

  @override
  State<Tp_ClaimRequestsPage> createState() => _Tp_ClaimRequestsPageState();
}

class _Tp_ClaimRequestsPageState extends State<Tp_ClaimRequestsPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseFirestore.instance;
  List<Object> _clientsList = [];
  List<Object> _claimreqstatus = [];
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

    // await getReqStatus();
  }

  // Future getReqStatus()async{
  //   var reqstatus_data = await FirebaseFirestore.instance
  //       .collection('Employee_Clients')
  //       .where('Option', isEqualTo: 'claim')
  //       // .where('isClaimed', isEqualTo: 'Yes')
  //       .get();
  //
  //   setState(() {
  //     _claimreqstatus = List.from(reqstatus_data.docs.map((doc) => TpQuotations.fromSnapshot(doc)));
  //   });
  // }

  Widget _createClientRequestCard(List companyClientList){
    List<Widget> list = <Widget>[];
    for (int i = 0; i < companyClientList.length; i++){
      // print('in for');
      if(companyClientList[i].company.contains(companyname)){
        if(companyClientList[i].option == 'claim'){
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
                        //   Navigator.push(this.context, MaterialPageRoute(builder: (context) => ClientInfo(clientreqid: companyClientList[i].reqid,empid: companyClientList[i].empid, compname : companyname, option: companyClientList[i].option)));
                        // }
                        // else{
                        Navigator.push(this.context, MaterialPageRoute(builder: (context) => ClaimClientInfo(clientreqid: companyClientList[i].reqid,empid: companyClientList[i].empid, compname : companyname, option: companyClientList[i].option)));
                        // }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10,bottom: 5.0),
                            child: Text(
                              "Request ID: ${companyClientList[i].reqid}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 10,bottom: 5.0),
                            child: Text(
                              "Category: ${companyClientList[i].category}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          // Padding(padding: EdgeInsets.only(bottom: 10.0),
                          //   child: Text(
                          //     "Option: ${companyClientList[i].option}",
                          //   ),
                          // ),
                          // Padding(padding: EdgeInsets.only(bottom: 10.0),
                          //   child: Text(
                          //     "User ID: ${companyClientList[i].userid}",
                          //   ),
                          // ),
                          // Padding(padding: EdgeInsets.only(bottom: 10.0),
                          //   child: Text(
                          //     "Employee ID: ${companyClientList[i].empid}",
                          //   ),
                          // ),
                          _tprequeststatus(companyClientList[i].reqid,companyClientList[i].empid,companyname,companyClientList[i].option)
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

  Widget _tprequeststatus(String requestid,String empid,String compname,String option) {
    // print('in reqstatus, $requestid');
    // Container(
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Employee_Clients')
              .where('RequestID', isEqualTo: '$requestid')
              .snapshots(),
          builder: (context, snapshot) {
            // print('snapshot');
            if (!snapshot.hasData) {
              // print('in if');
              return Center(child: CircularProgressIndicator());
            }
            else {
              // print('in else');
              // snapshot.data!.docs.map((e){
                return ListView(
                  shrinkWrap: true,
                  children:snapshot.data!.docs.map((e){
                    return Container(
                      child: getClaimStatus(e.data()['isClaimed'],requestid,empid,compname,option),
                      // child: Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Text(
                      //     'Quotation sent',
                      //     style: TextStyle(
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // ),
                    );
                  }).toList()
                );
              // });
              // if($e.data()['isClaimed'])
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Text(
              //     'Quotation sent',
              //     style: TextStyle(
              //       color: Colors.red,
              //     ),
              //   ),
              // );
            }
          }
      );
      return Container();
    // );
  }

  Widget getClaimStatus(claimstatus,requestid,empid,compname,option){
    // print('in getClaimStatus $claimstatus');
    if(claimstatus != null){
      return Align(
        alignment: Alignment.bottomRight,
        // child: Text(
        //   'Claimed',
        //   style: TextStyle(
        //     color: Colors.red,
        //   ),
        // ),
        child: ElevatedButton(
          child: Text(
            'Claimed',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xFFfe846f))
          ),
          onPressed: (){
          },
        ),
      );
    }
    else{
      return Align(
        alignment: Alignment.bottomRight,
        // child: Text(
        //   'Action needed',
        //   style: TextStyle(
        //     color: Colors.red,
        //   ),
        // ),
        child: ElevatedButton(
          child: Text(
            'Action Needed',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xFFfe846f))
          ),
          onPressed: (){
            Navigator.push(this.context, MaterialPageRoute(builder: (context) => ClaimClientInfo(clientreqid: requestid,empid: empid, compname : companyname, option: option)));
          },
        ),
      );
    }
    return Container();
  }


  //   for(int i=0; i<_claimreqstatus.length; i++){
  //     print(i);
  //     if(reqstatuslist[i].requestid == requestid && reqstatuslist[i].compname == companyname){
  //       print('in if ${reqstatuslist[i].requestid} ${reqstatuslist[i].compname} ');
  //       return Container(
  //         child: Align(
  //           alignment: Alignment.bottomRight,
  //           child: Text(
  //             'Qu',
  //             style: TextStyle(
  //               color: Colors.red,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //     else{
  //       // print('in else');
  //       continue;
  //       // if(reqstatuslist[i].requestid != requestid && reqstatuslist[i].compname != companyname){
  //       //   print('in else ${reqstatuslist[i].requestid} ${reqstatuslist[i].compname} ');
  //       //   return Container(
  //       //     child: Align(
  //       //       alignment: Alignment.bottomRight,
  //       //       child: Text(
  //       //         'Quotation not sent',
  //       //         style: TextStyle(
  //       //           color: Colors.red,
  //       //         ),
  //       //       ),
  //       //     ),
  //       //   );
  //       // }
  //     }
  //   }
  //   return Container();
  // }
  // void signOut() async{
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.signOut();
  //   Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  // }
}

class ClaimClientInfo extends StatefulWidget {
  final String? clientreqid;
  final String? empid;
  final String? compname;
  final String? option;
  const ClaimClientInfo({Key? key,@required this.clientreqid,@required this.option,@required this.empid,@required this.compname}) : super(key: key);

  @override
  State<ClaimClientInfo> createState() => _ClaimClientInfoState();
}

class _ClaimClientInfoState extends State<ClaimClientInfo> {
  String? client_requestid;
  String? employee_id;
  String? company_name;
  String? req_option;
  @override
  Widget build(BuildContext context) {
    client_requestid = widget.clientreqid;
    employee_id = widget.empid;
    company_name = widget.compname;
    req_option = widget.option;

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
      body:  Container(
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
                    if (!snapshot.hasData){
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
                                      'Policy Number: ${e.data()['PolicyNumber']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 10.0),
                                    child: Text(
                                      'UPI ID: ${e.data()['UPI_ID']}',
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(bottom: 20.0),
                                    child: ElevatedButton(
                                      child: Text(
                                        'View Documents',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                        ),
                                      ),
                                      onPressed: (){
                                        print('doc button pressed');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => displayclaimDocs(docs: e.data()['Documents'])));
                                        // _displaydocs(e.data()['Documents']);
                                        // Image.network('${docs[i]}');
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xFFfe846f)),
                                      ),
                                    ),
                                    // child: _displaydocs(e.data()['Documents']),
                                    // child: Text(
                                    //   'Documents: ${e.data()['Documents']}',
                                    // ),
                                  ),
                                  // _displaydocs(e.data()['Documents']),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  }
              ),
            ),
            Flexible(
                child:ElevatedButton.icon(
                    label: Text(
                      'Claim',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    icon: Icon(Icons.monetization_on),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFfe846f)),
                    ),
                    onPressed: ()async {
                      print('claim approve button pressed');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Payment_Integrate(req_id: client_requestid, opt: req_option)));
                      // Navigator.push(context, route)
                      // Navigator.push(context, route)
                      // _displayDialog(context);
                    }
                )
            )
          ],
        ),
      ),
    );
  }


//   Widget _displaydocs(List docs){
//     List<Widget> list = <Widget> [];
//     print(docs.length);
//     for(int i = 0; i < docs.length; i++){
//       print(i);
//       print(docs[i]);
//       // list.add(docs[i]);
//       // print(list);
//       // list.add(
//       //     Container(
//       //       child: Text(
//       //         'Document $i: ${docs[i]}',
//       //       ),
//       //     ) ,
//       // );
//       list.add(
//         Container(
//           // child: ElevatedButton(
//           //     child: Text(
//           //       'Doc $i',
//           //       style: TextStyle(
//           //         color: Colors.white,
//           //         fontSize: 22,
//           //       ),
//           //     ),
//           //   onPressed: (){
//           //       print('doc button pressed');
//           //     Image.network('${docs[i]}');
//           //   },
//           // )
//           child: Image.network('${docs[i]}'),
//         ),
//       );
//     }
//     // return CircularProgressIndicator();
//     // print(docs.length);
//     return Column(children: list,);
//     // return ListView(children: list,);
//     // return ListView(children: list,);
//   }
//
}

class displayclaimDocs extends StatefulWidget {
  final List? docs;
  const displayclaimDocs({Key? key,required this.docs}) : super(key: key);

  @override
  State<displayclaimDocs> createState() => _displayclaimDocsState();
}

class _displayclaimDocsState extends State<displayclaimDocs> {
  List claimsdocs = [];

  @override
  Widget build(BuildContext context) {
    claimsdocs = widget.docs!;
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
          child: _displaydocs(claimsdocs) ,
        )

    );
  }
  Widget _displaydocs(List docs){
    List<Widget> list = <Widget> [];
    print(docs.length);
    for(int i = 0; i < docs.length; i++){
      print(i);
      print(docs[i]);
      // list.add(docs[i]);
      // print(list);
      // list.add(
      //     Container(
      //       child: Text(
      //         'Document $i: ${docs[i]}',
      //       ),
      //     ) ,
      // );
      list.add(
        Container(
          // child: ElevatedButton(
          //     child: Text(
          //       'Doc $i',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 22,
          //       ),
          //     ),
          //   onPressed: (){
          //       print('doc button pressed');
          //     Image.network('${docs[i]}');
          //   },
          // )
          child: Image.network('${docs[i]}'),
        ),
      );
    }
    // return CircularProgressIndicator();
    // print(docs.length);
    // return Column(children: list,);
    return ListView(children: list,);
    // return ListView(children: list,);
  }
}

