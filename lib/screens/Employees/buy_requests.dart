import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/healthbuy_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:demo/screens/Employees/Requests_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/color_utils.dart';
import '../lifebuy_form.dart';

class Buy_Page extends StatefulWidget {
  const Buy_Page({super.key});

  @override
  State<Buy_Page> createState() => _Buy_PageState();
}

class _Buy_PageState extends State<Buy_Page> {
  String? buy_user_requestid;
  String? buy_user_id;
  String? buy_ins_category;
  String? ins_option;
  String? buy_user_contactno;
  List<Object> _buyrequestList = [];

  @override
  void didChangeDependencies(){
    getBuyRequests();
    super.didChangeDependencies();
  }
  _makePhoneCall(contactnumber) async {
    var url = Uri.parse("tel:$contactnumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // void initState(){
  //   getBuyRequests();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Buy Requests'),
      //   backgroundColor: Colors.orangeAccent,
      // ),
      body: SafeArea(
          child: _createRequestCard(_buyrequestList),
        // child: ListView.builder(
        //
        //   itemCount: _requestList.length,
        //   itemBuilder: (context,index) {
        //     return _createRequestCard(_requestList);
            // return ListTile(
            //   title: Text(_requestList[index].requestiD),
            // )
            // return RequestCard(_requestList[index] as Requests);
            // return Text('$_requestList');
          //   return Card(
          // },
        ),
      );
    // );
  }
  
  Future getBuyRequests() async{
    print('Hello');
    var data = await FirebaseFirestore.instance
        .collection('User_Requests')
        .where("Option", isEqualTo: 'buy')
        .orderBy('Date', descending: false)
        .get();

    setState(() {
      _buyrequestList = List.from(data.docs.map((doc) => BuyRequests.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
    });

  }

  Widget _createRequestCard(List requestList){

    List<Widget> list = <Widget>[];
    for (int i = 0; i < requestList.length; i++) {
      if(requestList[i].reqstatus == 'Request generated'){
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
                    // splashColor: Colors.blue.withAlpha(30),
                    // onTap: () {
                      // buy_user_requestid = requestList[i].requestid;
                      // buy_user_contactno = requestList[i].contactno;
                      // buy_user_id = requestList[i].userid;
                      // buy_ins_category = requestList[i].category;
                      // ins_option = requestList[i].option;
                      // print("Request ID- $buy_user_requestid");// assume that id is in .id field
                      // print("User Id- $buy_user_id");
                      // print("Category- $buy_ins_category");
                      // print("Option- $ins_option");
                      // print("Contact Number- $buy_user_contactno");
                      // if(buy_ins_category == 'health' && ins_option == 'buy'){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => healthbuyForm(userid: buy_user_id ,requestid: buy_user_requestid,category: buy_ins_category,option: ins_option)));
                      // }
                      // else if(buy_ins_category == 'life' && ins_option == 'buy'){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => LifeBuyForm(userid: buy_user_id ,requestid: buy_user_requestid,category: buy_ins_category,option: ins_option)));
                      // }
                      // if(ins_category == 'health' && ins_option == 'renew'){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context) => healthRenewForm()));
                      //
                      // }
                    // },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Request ID: ${requestList[i].requestid}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Category: ${requestList[i].category}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),

                          ),
                        ),
                        // Padding(padding: EdgeInsets.only(bottom: 10.0),
                        //   child: Text(
                        //     "Option: ${requestList[i].option}",
                        //   ),
                        // ),
                        Padding(padding: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.call_sharp,
                                  size: 16,
                                  // color: Colors.orangeAccent,
                                  color: Color(0xFFfe846f),
                                ),
                                onTap: () {
                                  _makePhoneCall(requestList[i].contactno);
                                },
                              ),
                              Text(
                                // child: Text(
                                "${requestList[i].contactno}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                // ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              // child: Text('Action Needed',
                              //   style: TextStyle(
                              //   color: Colors.red,
                              //   // textAlign: TextAlign.start,
                              //   ),
                              // ),
                              child: ElevatedButton(
                                child: Text(
                                  'Action needed',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xFFfe846f))
                                ),
                                onPressed: (){
                                  buy_user_requestid = requestList[i].requestid;
                                  buy_user_contactno = requestList[i].contactno;
                                  buy_user_id = requestList[i].userid;
                                  buy_ins_category = requestList[i].category;
                                  ins_option = requestList[i].option;
                                  print('$buy_ins_category $ins_option');
                                  if(buy_ins_category == 'health' && ins_option == 'buy'){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => healthbuyForm(userid: buy_user_id ,requestid: buy_user_requestid,category: buy_ins_category,option: ins_option)));
                                  }
                                  else if(buy_ins_category == 'life' && ins_option == 'buy'){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LifeBuyForm(userid: buy_user_id ,requestid: buy_user_requestid,category: buy_ins_category,option: ins_option)));
                                  }
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
      }
      else if(requestList[i].reqstatus == 'Necessary details collected' || requestList[i].reqstatus == 'Details sent to third party' || requestList[i].reqstatus == 'Quotations received. Soon our executive will contact you'){
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
                    // onTap: () {
                    //   buy_user_requestid = requestList[i].requestid;
                    //   buy_user_contactno = requestList[i].contactno;
                    //   buy_user_id = requestList[i].userid;
                    //   buy_ins_category = requestList[i].category;
                    //   ins_option = requestList[i].option;
                    //   print("Request ID- $buy_user_requestid");// assume that id is in .id field
                    //   print("User Id- $buy_user_id");
                    //   print("Category- $buy_ins_category");
                    //   print("Option- $ins_option");
                    //   print("Contact Number- $buy_user_contactno");
                    //   if(buy_ins_category == 'health' && ins_option == 'buy'){
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => healthbuyForm(userid: buy_user_id ,requestid: buy_user_requestid,category: buy_ins_category,option: ins_option)));
                    //   }
                    //   // if(ins_category == 'health' && ins_option == 'renew'){
                    //   //   Navigator.push(context, MaterialPageRoute(builder: (context) => healthRenewForm()));
                    //   //
                    //   // }
                    // },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Request ID: ${requestList[i].requestid}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Category: ${requestList[i].category}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        // Padding(padding: EdgeInsets.only(bottom: 10.0),
                        //   child: Text(
                        //     "Option: ${requestList[i].option}",
                        //   ),
                        // ),
                        Padding(padding: EdgeInsets.only(bottom: 5.0),
                          // child: Text(
                          //   "Contact No: ${requestList[i].contactno}",
                          // ),
                          child: Row(
                            children: [
                              InkWell(
                                child: Icon(
                                  Icons.call_sharp,
                                  size: 16,
                                  // color: Colors.orangeAccent,
                                  color: Color(0xFFfe846f),
                                ),
                                onTap: () {
                                  _makePhoneCall(requestList[i].contactno);
                                },
                              ),
                              Text(
                                // child: Text(
                                "${requestList[i].contactno}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54,
                                ),
                                // ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              // child: Text('In Process',
                              //   style: TextStyle(
                              //     color: Colors.red,
                              //     // textAlign: TextAlign.start,
                              //   ),
                              // ),
                              child: ElevatedButton(
                                child: Text(
                                  'In Process',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                style: ButtonStyle(

                                    // backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                                    backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xFFfe846f))
                                ),
                                onPressed: (){},
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


