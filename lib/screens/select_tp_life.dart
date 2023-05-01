import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/select_tp_health.dart';
import 'package:demo/screens/tplist.dart';
import 'package:flutter/material.dart';

import 'Employees/empnavbar.dart';

class LifeTp extends StatefulWidget {
  final String? docid;
  final String? rid;
  const LifeTp({Key? key,@required this.docid,@required this.rid}) : super(key: key);

  @override
  State<LifeTp> createState() => _LifeTpState();
}

class _LifeTpState extends State<LifeTp> {
  String? company_name;
  String? insurance_provided_type;
  // bool? check1 = false;
  // int? cflag;
  String? company;
  List<Object> _lifedatafetch = [];
  String? curr_userdocid,curr_userreqid;
  final databaseReference = FirebaseFirestore.instance;
  // int current_index = 0;
  // final List<Widget> pages = [healthTp(), LifeTp()];
  //
  // void OnTapped(int index) {
  //   setState(() {
  //     current_index = index;
  //   });
  // }


  @override
  void initState() {
    super.initState();
    print('Hello');
    getlifedata();
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
        child: _createCompanyList(_lifedatafetch),
      ),
    );

  }
  Future getlifedata() async {
    print('Hello');
    var data = await FirebaseFirestore.instance
        .collection('ThirdParties')
        .where("InsuranceProvided", isEqualTo: 'Life')
    // .orderBy('Date', descending: false)
        .get();
    setState(() {
      _lifedatafetch = List.from(data.docs.map((doc) => lifetpdata.fromSnapshot(doc)));
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
  }
  void _onSelected(bool selected, String companyName) {
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
    print('xxx');
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

}
