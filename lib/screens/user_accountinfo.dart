import 'package:demo/screens/userrequests.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserName{
  // String? companyaddress;
  String? user_name;
  // String? contactno;
  // String? emailid;
  // String? insuranceprovided;

  UserName();

  Map<String, dynamic> toJson() => {'FullName': user_name};

  UserName.fromSnapshot(snapshot)
      :user_name = snapshot.data()['FullName'];
  // contactno = snapshot.data()['ContactNumber'],
  // emailid = snapshot.data()['Email'],
  //       insuranceprovided = snapshot.data()['InsuranceProvided'];
// companyaddress = snapshot.data()['CompanyAddress'];
}


class User_AccountInfo extends StatefulWidget {
  const User_AccountInfo({Key? key}) : super(key: key);

  @override
  State<User_AccountInfo> createState() => _User_AccountInfoState();
}

class _User_AccountInfoState extends State<User_AccountInfo> {
  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  List<Object> _username = [];
  var uname;

  // @override
  // void initState(){
  //   getUserName();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
             StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
               stream: databaseReference
                   .collection('Users')
                   .doc(user?.uid) // 👈 Your document id change accordingly
                   .snapshots(),
               builder:
                   (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                 if (snapshot.hasError) {
                   return const Text('Something went wrong');
                 }
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Text("Loading");
                 }
                 Map<String, dynamic> data =
                 snapshot.data!.data()! as Map<String, dynamic>;
                 return Container(
                   height: 200,
                   color: Colors.grey,
                   child: Column(
                     children: [
                       Padding(padding: EdgeInsets.only(top: 30.0),
                         child: Center(
                           child: Icon(
                             Icons.account_circle_outlined,
                             size: 100.0,
                           ),
                         ),
                       ),
                      Center(
                        child: Text(
                          data['FullName'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ),
                     ],
                   )
                 );// 👈 your valid data here
               },
             ),
          ListTile(
            title: Text('My Requests'),
            trailing: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onPressed: (){
                print('Icon pressed');
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserRequests()));
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('About Us'),
            trailing: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black,
              ),
              onPressed: (){
                print('Icon pressed');
              },
            ),
          )
        ],
      ),
    );
  }
  Future getUserName() async{
    // String? uname;
    var docsnapshot = await databaseReference.collection('Users')
        .doc(user?.uid)
        // .where("InsuranceProvided", isEqualTo: 'Health')
        .get();
    if (docsnapshot.exists) {
      Map<String, dynamic> data = docsnapshot.data()!;

      // You can then retrieve the value from the Map like this:
      uname = data['FullName'];
      print(uname);
    }
        // setState(() {
        //   _username = List.from(data.docs.map((doc) => UserName.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
      //   });
        // .then((snapshot) {
        //   uname = snapshot.data()!['FullName'].toString();
        //   print(uname);
        // });
  }
}
