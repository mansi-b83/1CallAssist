import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/healthrenew_form.dart';
import 'package:demo/screens/Employees/Requests_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class RenewApp extends StatefulWidget {
  const RenewApp({super.key});

  @override
  State<RenewApp> createState() => _RenewAppState();
}

class _RenewAppState extends State<RenewApp> {
  //var firestoreDB =
  //  FirebaseFirestore.instance.collection('UserRequest_data').snapshots();
  String? renew_user_requestid;
  String? renew_user_id;
  String? renew_ins_category;
  String? ins_option;
  String? renew_user_contactno;
  List<Object> _renewrequestList = [];

  @override
  void didChangeDependencies(){
    getRenewRequests();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _createRequestCard(_renewrequestList),
      ),
    );
    // return StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection('UserRequest_data')
    //       .where("action", isEqualTo: 'renew')
    //       // .orderBy("age", descending: true)
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return Center(child: CircularProgressIndicator());
    //     } else {
    //       // print(snapshot.data!.docs);
    //       // return Text('Hello');
    //       return ListView(
    //         children: snapshot.data!.docs.map((e) {
    //           return Card(
    //             child: ListTile(
    //               //leading: Text(e.data()['Category']),
    //               title: Text(e.data()['Category']),
    //               subtitle: Text(e.data()['contactno']),
    //               trailing:
    //                   IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
    //             ),
    //           );
    //         }).toList(),
    //       );
    //     }
    //   },
    // );
  }
  Future getRenewRequests() async{
    print('Hello');
    var data = await FirebaseFirestore.instance
        .collection('User_Requests')
        .where("Option", isEqualTo: 'renew')
    // .orderBy('Date', descending: false)
        .get();

    setState(() {
      _renewrequestList = List.from(data.docs.map((doc) => RenewRequests.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
    });

  }

  Widget _createRequestCard(List requestList){

    List<Widget> list = <Widget>[];
    for (int i = 0; i < requestList.length; i++) {
      list.add(
        // Card(
        //   child: ListTile(
        //       leading: Icon(Icons.album),
        //       title: Text(requestList[i].requestid),
        //       subtitle: Text(requestList[i].category),
        //       onTap: () {
        //         print("Request ID ${requestList[i].requestid},");// assume that id is in .id field
        //         print("User Id ${requestList[i].userid}");
        //         print("Category ${requestList[i].category}");
        //         print("Option ${requestList[i].option}");
        //         print("Contact Number ${requestList[i].contactno}");
        //
        //       }
        //   ),
        // ),
        Container(
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    renew_user_requestid = requestList[i].requestid;
                    renew_user_contactno = requestList[i].contactno;
                    renew_user_id = requestList[i].userid;
                    renew_ins_category = requestList[i].category;
                    ins_option = requestList[i].option;
                    print("Request ID- $renew_user_requestid");// assume that id is in .id field
                    print("User Id- $renew_user_id");
                    print("Category- $renew_ins_category");
                    print("Option- $ins_option");
                    print("Contact Number- $renew_user_contactno");
                    if(renew_ins_category == 'health' && ins_option == 'renew'){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => healthRenewForm(userid: renew_user_id ,requestid: renew_user_requestid,category: renew_ins_category,option: ins_option)));

                    }
                  },
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Request ID: ${requestList[i].requestid}",
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Category: ${requestList[i].category}",
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Option: ${requestList[i].option}",
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Contact No: ${requestList[i].contactno}",
                        ),
                      ),
                      // Padding(padding: EdgeInsets.only(bottom: 10.0),
                      //   child: Text(
                      //     "Option: $index",
                      //   ),
                      // ),
                    ],
                  ),
                )

            ),
          ),
        ),
      );
    }
    return ListView(children: list);
  }
}
