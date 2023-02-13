import 'package:flutter/material.dart';
import 'package:demo/screens/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/healthbuy_form.dart';
import 'package:demo/screens/thirdparty_signup.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
class ThirdParty_SignIn extends StatefulWidget {
  const ThirdParty_SignIn({Key? key}) : super(key: key);

  @override
  State<ThirdParty_SignIn> createState() => _ThirdParty_SignInState();
}

class _ThirdParty_SignInState extends State<ThirdParty_SignIn> {
  TextEditingController _EmppasswordController = TextEditingController();
  TextEditingController _EmpemailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: const Text(
        //   "Sign Up",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
      ),
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
                reusableTextField("Enter Email", Icons.person_outline, false,
                    _EmpemailController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _EmppasswordController),
                // const SizedBox(
                //   height: 20,
                // ),
                // reusableTextField("Enter Contact Number", Icons.contact_emergency_outlined, true,
                //     _EmpcontactnumController),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _EmpemailController.text,
                      password: _EmppasswordController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => healthbuyForm()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),


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
                MaterialPageRoute(builder: (context) => ThirdParty_SignUp()));
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
}
