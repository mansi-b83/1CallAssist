import 'package:demo/screens/reset_password.dart';
import 'package:demo/screens/signup_screen.dart';
import 'package:demo/screens/employee_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key}) : super(key: key);


  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo.jpg"),
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
                firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
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
                      print('Third Part SignIn');
                      tpflag = 'tp';
                    })
                  ],
                )

                // Container(
                //   width: 200,
                //     firebaseUIButton(context, 'Employee Signin',(){
                //       print('Emp signin');
                //     })
                // )



                // Padding(padding: EdgeInsets.only(top: 30),
                //     child: Row(
                //       children: [
                //         EmployeeSignIn(context),
                //         ThirdpartySignIn(context)
                //       ],
                //
                //     ),
                // ),


                // Row(
                //   children: [
                //     Padding(padding: EdgeInsets.only(top: 20.0),
                //         child: Align(
                //           alignment: Alignment.bottomLeft,
                //           child: EmployeeSignIn(context),
                //         ),
                //     ),
                //   ],
                // )
                // EmployeeSignIn(context)

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

  // Widget EmployeeSignIn(BuildContext context) {
  //   return GestureDetector(
  //
  //     child: Container(
  //         height: 60,
  //         // width: 200,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(16),
  //           ),
  //         ),
  //         child:SizedBox(
  //           width:  170,
  //           child: Center(
  //             child: Text(
  //               'Employee SignIn',
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               textAlign: TextAlign.justify,
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 22,
  //               ),
  //             ),
  //           ),
  //         )
  //     ),

      // child: TextButton(
      //   child: const Text(
      //     "Forgot Password?",
      //     style: TextStyle(color: Colors.white70),
      //     textAlign: TextAlign.right,
      //   ),
      //   onPressed: () => Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => ResetPassword())),
      // ),
  //   );
  // }

  // Widget ThirdpartySignIn(BuildContext context) {
  //   return Padding(padding: EdgeInsets.only(left: 20.0),
  //     child: GestureDetector(
  //       child: Container(
  //         height: 60,
  //         // width: 200,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(22),
  //           ),
  //         ),
  //         child: SizedBox(
  //             width: 170,
  //             child: Center(
  //               child: Text(
  //                 'Third Party SignIn',
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 22,
  //                 ),
  //               ),
  //             )
  //
  //
  //         ),
  //       ),

        // child: TextButton(
        //   child: const Text(
        //     "Forgot Password?",
        //     style: TextStyle(color: Colors.white70),
        //     textAlign: TextAlign.right,
        //   ),
        //   onPressed: () => Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => ResetPassword())),
        // ),
    //   ),
    // );
  // }
}