import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/reusable_widgets/reusable_widget.dart';
import 'package:demo/screens/userside_bottomnav.dart';
import 'package:demo/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _fullNameTextController = TextEditingController();
  String? dateString;
  var dateTime;
  var date;


  // final User? user = FirebaseAuth.instance.currentUser;
  // void inputData() async {
  //   final User? user = await FirebaseAuth.instance.currentUser;
  //   final useruid = user?.uid;
  //   // here you write the codes to input the data into firestore
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                // hexStringToColor("CB2B93"),
                // hexStringToColor("9546C4"),
                // hexStringToColor("5E61F4")
                hexStringToColor("FAD889"),
                hexStringToColor("FCBC2F")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Fullname", Icons.person_outline, false,
                        _fullNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () async {
                      print( _fullNameTextController.text);
                      print(_emailTextController.text);

                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                            print("Created New Account");
                            // final userid = user?.uid;
                            // print('Signedup  User: $userid');
                            addUserDetails();
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => User_Botnav()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                      // print('Current user id: $userid');

                    })

                  ],
                ),
              ))),
    );
  }
  void addUserDetails() async{
    final User? user = await FirebaseAuth.instance.currentUser;
    final useruid = user?.uid;
    print(useruid);
    await FirebaseFirestore.instance.collection('Users').doc(user?.uid)
        .set({
      'FullName': _fullNameTextController.text,
      'Email' : _emailTextController.text
    });
  }
}
