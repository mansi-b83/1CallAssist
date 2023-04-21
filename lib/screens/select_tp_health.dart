import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/Employees/emp_homepage.dart';
import 'package:demo/screens/Employees/empnavbar.dart';
import 'package:demo/screens/tplist.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/select_tp_life.dart';

class healthTp extends StatefulWidget {
  final String? docid;
  final String? rid;
  const healthTp({Key? key,@required this.docid,@required this.rid}) : super(key: key);

  @override
  State<healthTp> createState() => _healthTpState();
}

class _healthTpState extends State<healthTp> {
  String? company_name;
  String? insurance_provided_type;
  // bool? check1 = false;
  // int? cflag;
  String? company;
  List<Object> _healthdatafetch = [];
  String? curr_userdocid,curr_userreqid;
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    print('Hello');
    gethealthdata();
    // super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    curr_userdocid = widget.docid;
    curr_userreqid = widget.rid;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Select Companies',
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
        child: _createCompanyList(_healthdatafetch),
      ),
    );

  }

  Future gethealthdata() async {
    print('Hello');
    var data = await FirebaseFirestore.instance
        .collection('ThirdParties')
        .where("InsuranceProvided", isEqualTo: 'Health')
    // .orderBy('Date', descending: false)
        .get();
    setState(() {
      _healthdatafetch = List.from(data.docs.map((doc) => healthtpdata.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
    });
  }
  List userChecked = [];
  Widget _createCompanyList(companyList) {
    // userChecked = [];
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemCount: companyList.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        companyList[i].companyname,
                      ),
                      leading: Checkbox(
                        value: userChecked.contains(companyList[i].companyname),
                        // print('userChecked.contains(companyList[i].companyname)')
                        onChanged: (val) {
                          print('$val ${companyList[i].companyname}');
                          _onSelected(val!, companyList[i].companyname);
                        },
                      ),
                    ),
                  );
                }
            ),
        ),
        // ElevatedButton(
        //     onPressed: (){
        //       print('Button pressed');
        //
        //
        //     },
        //     child: Text(
        //       'OK',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 22,
        //       ),
        //     )
        // )
        Padding(padding: EdgeInsets.fromLTRB(0.0,0.0,20.0,20.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                print('button pressed');
                _sendCompaniesSelected();
                final snackBar = SnackBar(
                  content: const Text('Successfully sent to companies!'),
                  action: SnackBarAction(
                    label: 'Ok',
                    onPressed: () {
                      // Some code to undo the change.
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmpNavbar()));
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Icon(Icons.done, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.orangeAccent, // <-- Button color
                // foregroundColor: Colors.red, // <-- Splash color
                alignment: Alignment.bottomRight,
              ),
            ),
          )

        ),
      ],

    );


    // List<Widget> list = <Widget>[];
    // // var cards = <Card>[];
    // for (int i = 0; i < companyList.length; i++) {
    //   list.add(
    //     Container(
    //       child: Card(
    //         child: Padding(
    //           padding: EdgeInsets.all(12.0),
    //           child: InkWell(
    //             onTap: (){
    //
    //             },
    //             child: Theme(
    //               data: ThemeData(unselectedWidgetColor: Colors.black),
    //               child: CheckboxListTile(
    //                 checkColor: Colors.black,
    //                 activeColor: Colors.white,
    //                 controlAffinity: ListTileControlAffinity.leading,
    //                 // fillColor: MaterialStateProperty.resolveWith(getColor),
    //                 value: check1,
    //                 onChanged: (bool? value) {
    //                   print('value- $value');
    //                   check1 = value;
    //                   print(check1);
    //                   if (check1 == true){
    //                     // for(int j = 0;)
    //                     print('WHEN VALUE TRUE');
    //                   }
    //                   else{
    //                     print('WHEN VALUE FALSE');
    //                   }
    //
    //                   // setState(() {
    //                   //   check1 = value!;
    //                   //   if (check1!) {
    //                   //     print('WHEN VALUE TRUE');
    //                   //     cflag = 1;
    //                   //     // tickedcompany(companyList, i);
    //                   //     company = '${companyList[i].companyname}';
    //                   //     print(company);
    //                   //     // healthins = 'health';
    //                   //     // print(healthins);
    //                   //   }
    //                   //   else {
    //                   //     print('WHEN VALUE FALSE');
    //                   //     cflag = 0;
    //                   //   }
    //                   // });
    //                 },
    //                 title: Text('${companyList[i].companyname}',
    //                   style: TextStyle(
    //                       color: Colors.black
    //                   ),
    //
    //                 ),
    //               ),
    //             ),
    //           )
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }
  void _onSelected(bool selected, String companyName) {
    print(curr_userreqid);
    print(curr_userdocid);
    if (selected == true) {
      setState(() {
        userChecked.add(companyName);
        print(userChecked);
      });
    } else {
      setState(() {
        userChecked.remove(companyName);
        print(userChecked);
      });
    }
  }
  void _sendCompaniesSelected() async{
    await databaseReference.collection('Employee_Clients').doc(curr_userdocid)
        .update({
      'Companies':FieldValue.arrayUnion(userChecked)
    });
    await databaseReference.collection('User_Requests')
        .where('RequestID', isEqualTo: '$curr_userreqid')
        .get()
        .then((value) => value.docs.forEach((doc) {
      doc.reference.update({'Status' : 'Details sent to third party'});
    })).catchError((error) => print('Status not updated: $error'));

  }
  void _updateStatus() async{
    await databaseReference.collection('User_Requests').doc(curr_userdocid)
        .update({
      'Companies':FieldValue.arrayUnion(userChecked)
    });
  }
}