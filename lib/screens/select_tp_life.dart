import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/select_tp_health.dart';
import 'package:demo/screens/tplist.dart';
import 'package:flutter/material.dart';

class LifeTp extends StatefulWidget {
  const LifeTp({Key? key}) : super(key: key);

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
      body: SafeArea(

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
    return ListView.builder(
        itemCount: companyList.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              title: Text(
                companyList[i].companyname,
              ),
              leading:Checkbox(
                value: userChecked.contains(companyList[i].companyname),
                onChanged: (val) {
                  print('$val ${companyList[i].companyname}');
                  _onSelected(val!, companyList[i].companyname);
                },
              ),
            ),
          );
        });
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

}
