import 'package:demo/screens/reset_password.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/employee_signin.dart';
import'package:demo/screens/thirdparty_signin.dart';
import 'package:demo/screens/userside_bottomnav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);


  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  String? empflag;
  String? tpflag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              // hexStringToColor("CB2B93"),
              // // hexStringToColor("9546C4"),
              // hexStringToColor("5E61F4")
              hexStringToColor("FAD889"),
              hexStringToColor("FCBC2F"),

            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/1callassist_logo.png"),

                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", () async{
                  // final SharedPreferences prefs = await SharedPreferences.getInstance();
                  // prefs.setString('email', _emailTextController.text);
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => User_Botnav()));
                        print('Authenticated ${_emailTextController.text}');
                        authenticate_stakeholdertype();
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UIButton(context, 'Employee SignIn', (){
                      print('Employee Signin');
                      empflag = 'emp';
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Emp_SignIn()));
                    }),
                    UIButton(context, 'Third Party SignIn', (){
                      print('Third Party SignIn');
                      tpflag = 'tp';
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdParty_SignIn()));
                    })
                  ],
                )

              ],
            ),
          ),
        ),
      ),

    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }

  Future authenticate_stakeholdertype() async{
    print('hello....${_emailTextController.text}');
    AggregateQuerySnapshot query = await FirebaseFirestore.instance
        .collection('Users')
        .where("Email", isEqualTo: '${_emailTextController.text}')
        .count()
        .get();
        print('${query.count}');
        if(query.count == 1){
          print('is a user ${_emailTextController.text}');
          Navigator.push(context, MaterialPageRoute(builder: (context) => User_Botnav()));
        }
        else{
          final snackBar = SnackBar(
            content: const Text('Invalid User'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: () {
                // Some code to undo the change.
                // Navigator.push(context, MaterialPageRoute(builder: (context) => EmpNavbar()));
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        // else(
        //
        // )
    //     .then((value){
    //       print('is a user ${_emailTextController.text}');
    //       // Navigator.push(context, MaterialPageRoute(builder: (context) => User_Botnav()));
    // }).catchError((error) => print('Invalid User'));
  }

}