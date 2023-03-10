import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/signin_screen.dart';
class UserRequestGenerated extends StatefulWidget {

  // final String? pno;
  // final String? time;
  // final String? catgandopt;
  final String? reqid;

  //const UserRequestGenerated({Key? key, @required this.pno, @required this.time, @required this.catgandopt, @required this.reqid}) : super(key: key);
  const UserRequestGenerated({Key? key, @required this.reqid}) : super(key: key);
  @override
  State<UserRequestGenerated> createState() => _UserRequestGeneratedState();
}

class _UserRequestGeneratedState extends State<UserRequestGenerated> {

  // String? phonenum;
  // String? preftime;
  // String? category_and_option;
  String? requestid_user;
  @override
  Widget build(BuildContext context) {
    // phonenum = widget.pno;
    // preftime = widget.time;
    // category_and_option = widget.catgandopt;
    requestid_user = widget.reqid;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: (){
                signOut();
              },
              icon: Icon(Icons.logout_outlined))
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text(
              'Request ID: $requestid_user',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
             ),
             // Padding(padding: EdgeInsets.all(10),
             //     child: TextButton(
             //       style: ButtonStyle(
             //         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
             //         backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)
             //       ),
             //       onPressed: () {
             //         Navigator.push(context , MaterialPageRoute(builder: (context) => healthbuyForm()));
             //       },
             //       child: Text('Buy Form'),
             //     )
             // ),
             //  Padding(padding: EdgeInsets.all(10),
             //      child: TextButton(
             //        style: ButtonStyle(
             //            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
             //            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent)
             //        ),
             //        onPressed: () {
             //          Navigator.push(context , MaterialPageRoute(builder: (context) => healthRenewForm()));
             //        },
             //        child: Text('Renew Form'),
             //      )
             //
             //  )


            ],
          )
          // child: Text(
          //   'Request ID: $requestid_user',
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

        ),
      ),
    );
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
