import 'package:flutter/material.dart';

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
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        child: Center(
          child: Text(
            'Request ID: $requestid_user',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
        )
      ),
    );
  }
}
