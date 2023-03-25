import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/reusable_widgets/reusable_widget.dart';
import 'package:demo/utils/color_utils.dart';
import'package:demo/screens/Employees/empnavbar.dart';
import 'package:demo/screens/healthbuy_form.dart';

class Emp_SignUp extends StatefulWidget {
  const Emp_SignUp({Key? key}) : super(key: key);

  @override
  State<Emp_SignUp> createState() => _Emp_SignUpState();
}

class _Emp_SignUpState extends State<Emp_SignUp> {

  TextEditingController _EmpemailController = TextEditingController();
  TextEditingController _EmppasswordController = TextEditingController();
  TextEditingController _EmpfullnameController = TextEditingController();
  TextEditingController _EmpcontactnumController = TextEditingController();
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
                hexStringToColor("FCBC2F"),
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
                        _EmpfullnameController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email Id", Icons.email_outlined, false,
                        _EmpemailController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Contact Number", Icons.phone_outlined, false,
                        _EmpcontactnumController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _EmppasswordController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () async {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _EmpemailController.text,
                          password: _EmppasswordController.text)
                          .then((value) {
                        print("Created New Account");
                        addEmployeeDetails();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => EmpNavbar()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                    })
                  ],
                ),
              ),
          ),
      ),
    );
  }
  void addEmployeeDetails() async{
    final User? user = await FirebaseAuth.instance.currentUser;
    final useruid = user?.uid;
    print(useruid);
    await FirebaseFirestore.instance.collection('Employees').doc(user?.uid)
        .set({
      'FullName':_EmpfullnameController.text,
      'Email' : _EmpemailController.text,
      'ContactNumber': _EmpcontactnumController.text
    });

  }
}
