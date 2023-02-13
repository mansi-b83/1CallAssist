import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/healthbuy_form.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
class ThirdParty_SignUp extends StatefulWidget {
  const ThirdParty_SignUp({Key? key}) : super(key: key);

  @override
  State<ThirdParty_SignUp> createState() => _ThirdParty_SignUpState();
}

class _ThirdParty_SignUpState extends State<ThirdParty_SignUp> {

  TextEditingController _tpEmailController = TextEditingController();
  TextEditingController _tpPasswordController = TextEditingController();
  TextEditingController _tpCompnameController = TextEditingController();
  TextEditingController _tpContactnumController = TextEditingController();
  TextEditingController _tpCompaddressController = TextEditingController();
  //upload company pancard
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
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Email", Icons.email_outlined, false,
                    _tpEmailController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Contact Number", Icons.phone_outlined,false,
                    _tpContactnumController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Company Name", Icons.corporate_fare_outlined, false,
                    _tpCompnameController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Company Address", Icons.location_on_outlined, false,
                    _tpCompaddressController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outlined, true,
                    _tpPasswordController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign Up", () async {
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: _tpEmailController.text,
                      password: _tpPasswordController.text)
                      .then((value) {
                    print("Created New Account");
                    addThirdPartyDetails();
                    // addEmployeeDetails();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => healthbuyForm()));
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
  void addThirdPartyDetails() async{
    final User? user = await FirebaseAuth.instance.currentUser;
    final useruid = user?.uid;
    print(useruid);
    await FirebaseFirestore.instance.collection('ThirdParties').doc(user?.uid)
        .set({
      'Email':_tpEmailController.text,
      'ContactNumber' : _tpContactnumController.text,
      'CompanyName': _tpCompnameController.text,
      'CompanyAddress': _tpCompaddressController.text
    });

  }
}
