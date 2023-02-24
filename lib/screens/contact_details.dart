import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/requestid_generated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:date_field/date_field.dart';

import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;

class ContactDetail extends StatefulWidget {
  final String? finalcatg;
  final String? finalopt;
  const ContactDetail({Key? key,@required this.finalcatg,@required this.finalopt  }) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {

  String? _phonenum;
  String? _preftime;
  String? final_category;
  String? final_option;
  String? request_id;
  var dateString;
  var dateTime;
  var date;
  TextEditingController _timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    dateString = DateTime.now().toString();
    dateTime = DateTime.parse(dateString!);
    date = "${dateTime.day}-${dateTime.month}-${dateTime.year} ${dateTime.hour}.${dateTime.minute}.${dateTime.second}";
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // CollectionReference users_requestdetails = FirebaseFirestore.instance.collection('UserRequest_data');
  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final_category = widget.finalcatg;
    final_option = widget.finalopt;
    // final format = DateFormat('dd-MM-yyyy HH:mm:ss');

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
        actions: [
          IconButton(
              onPressed: (){
                signOut();
              },
              icon: Icon(Icons.logout_outlined))
        ],
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
                        // icon: Icons.timer_outlined,
                        controller: _timeController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Preffered Callback Time',
                          hintText: 'Enter Callback Time',
                          prefixIcon: Padding(// add padding to adjust icon
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(Icons.timer_outlined),
                          ),
                        ),
                        onTap: () async{
                          TimeOfDay? selectedtime = await showTimePicker(

                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, child) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      // Using 12-Hour format
                                        alwaysUse24HourFormat: false
                                    ),
                                    // If you want 24-Hour format, just change alwaysUse24HourFormat to true
                                    child: child!
                                );

                              }
                          );
                          if(selectedtime != null){
                            print(selectedtime.format(context));
                            final now = new DateTime.now();
                            final dateandtime = DateTime(now.year, now.month, now.day, selectedtime.hour, selectedtime.minute);
                            final formattedtime = DateFormat.jm(); //"6:00 AM"
                            // print(formattedtime);
                            String time = formattedtime.format(dateandtime);
                            print(time);
                            setState(() {
                              _timeController.text = time; //set the value of text field.
                            });
                            // var parsedtime = DateFormat.jm().parse(selectedtime.format(context).toString());
                            // print('Parsed Time $parsedtime');
                            // String formattedTime = await DateFormat('HH:mm:ss').format(parsedtime);
                            // print(formattedTime);
                            // setState(() {
                            //   _timeController.text = formattedTime; //set the value of text field.
                            // });
                          }
                        },
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
      print(final_category);
      print(final_option);
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
    await databaseReference.collection("User_Requests")
        // .doc(user?.uid).collection(date)
        .add({
          'ContactNo': '$_phonenum',
          'PrefferedTime': '$_preftime',
          'Category': '$final_category',
          'Option': '$final_option',
          'RequestID' : '$request_id',
          'UserId' : user?.uid,
          'Date' : date
        })
    .then((value) => print("User Request Added"))
    .catchError((error) => print("Failed to add user: $error"));
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
