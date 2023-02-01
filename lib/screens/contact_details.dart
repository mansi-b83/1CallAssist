import 'dart:math';
import 'package:flutter/material.dart';
import 'package:demo/screens/requestid_generated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;

class ContactDetail extends StatefulWidget {
  final String? finalval;
  const ContactDetail({Key? key,@required this.finalval}) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {

  String? _phonenum;
  String? _preftime;
  String? final_catgandoption;
  String? request_id;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // CollectionReference users_requestdetails = FirebaseFirestore.instance.collection('UserRequest_data');
  final databaseReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final_catgandoption = widget.finalval;

    // CollectionReference users_requestdetails = FirebaseFirestore.instance.collection('UserRequest_data');
    // Future<void> addUserRequest() {
    //   // Call the user's CollectionReference to add a new user
    //   print('hello');
    //   return users_requestdetails
    //       .add({
    //     'contactno': _phonenum,
    //     'preffered_time': _preftime,
    //     // 'RequestID': request_id
    //   })
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }
    return Scaffold(
        // resizeToAvoidBottomInset : false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Container(

              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(top: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Contact Details',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(10),
                      child: Text(
                        'Kindly provide your contact details. We will reach ou to you soon',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(left: 15.0,top: 30.0,bottom: 15.0,right: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Contact Number',
                          hintText: 'Enter Contact Number',
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Contact Number is required";
                          }
                          if(value.length != 10){
                            return "Enter valid contact number";
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          _phonenum = value!;
                        },
                      ),
                    ),

                    Padding(padding: EdgeInsets.all(15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Preffered Callback Time',
                          hintText: 'Enter Callback Time',
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Preffered Callback Time is required";
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (value){
                          _preftime = value!;
                        },
                      ),
                    ),

                    Center(
                      child: Padding(padding: EdgeInsets.only(left: 0.0,right: 0.0,top: 100.0,bottom: 0.0),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            print("button pressed");
                            final form = _formKey.currentState;
                            if (form != null && !form.validate()){
                              return;
                            }
                            else{
                              form?.save();
                              _sendFinalUserinfo(context);
                              // addUserRequest();
                            }
                            // form?.save();

                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
      )
    );
  }

  void _sendFinalUserinfo(BuildContext context){

    const available_chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var _rnd = Random();
    // final reqid_list = [];
    request_id = List.generate(8, (index) => available_chars[_rnd.nextInt(available_chars.length)]).join();
    // request_id = 'rn9CCUMA';
    bool found = globals.reqid_list.contains(request_id);
    if(found){
      _sendFinalUserinfo(context);
      // globals.reqid_list.add('found id');
      // print('hey');

    }
    else{
      globals.reqid_list.add(request_id);
      print(final_catgandoption);
      print(_phonenum);
      print(_preftime);
      print(request_id);
      print(globals.reqid_list);
      addUserRequest();
      // Navigator.push(context , MaterialPageRoute(builder: (context) => UserRequestGenerated(pno: _phonenum, time: _preftime, catgandopt: final_catgandoption, reqid: request_id)));
      // FirebaseFirestore.instance
      //     .collection('UserRequest_data')
      //     .add({'contactno': '$_phonenum', 'preffered_time': '$_preftime', 'RequestID': '$request_id' });
      Navigator.push(context , MaterialPageRoute(builder: (context) => UserRequestGenerated(reqid: request_id)));

    }
  }
  void addUserRequest() async{
    await databaseReference.collection("UserRequest_data")
        .add({
      'contactno': '$_phonenum',
      'preffered_time': '$_preftime',
      'Category': '$final_catgandoption',
      'RequestID' : '$request_id'
    })
    .then((value) => print("User Request Added"))
    .catchError((error) => print("Failed to add user: $error"));
  }
}
