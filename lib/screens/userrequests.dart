import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/signin_screen.dart';

class UserRequests extends StatefulWidget {
  const UserRequests({Key? key}) : super(key: key);

  @override
  State<UserRequests> createState() => _UserRequestsState();
}

class _UserRequestsState extends State<UserRequests> {
  List _requestList = [];
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void didChangeDependencies(){
    getUserRequests();
    super.didChangeDependencies();
  }
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
          // LOGOUT Feature
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
      body: SafeArea(
          child: _createRequestCard(_requestList),
      )

    );
  }
  Future getUserRequests() async{
    var data = await FirebaseFirestore.instance
        .collection('User_Requests')
        .where("UserId", isEqualTo: user?.uid)
    // .orderBy('Date', descending: false)
        .get();

    setState(() {
      _requestList = List.from(data.docs.map((doc) => UserReq.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
    });

  }
  Widget _createRequestCard(List requestList){

    List<Widget> list = <Widget>[];
    for (int i = 0; i < requestList.length; i++) {
      list.add(
        Container(
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(12.0),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print("Request ID- ${requestList[i].reqid}");
                    print("Status- ${requestList[i].req_status}");
                  },
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Request ID: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                    "${requestList[i].reqid}",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                    "Status: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )
                                ),
                              ],
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "${requestList[i].req_status}",
                                    ),
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      // Padding(padding: EdgeInsets.only(bottom: 10.0),
                      //   child: Text(
                      //     "Option: ${requestList[i].option}",
                      //   ),
                      // ),
                      // Padding(padding: EdgeInsets.only(bottom: 10.0),
                      //   child: Text(
                      //     "Contact No: ${requestList[i].contactno}",
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
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}

class UserReq{
  String? reqid;
  String? req_status;

  UserReq();

  Map<String, dynamic> toJson() => {'RequestID': reqid,'Status': req_status};

  UserReq.fromSnapshot(snapshot)
      :reqid = snapshot.data()['RequestID'],
        req_status = snapshot.data()['Status'];
}

