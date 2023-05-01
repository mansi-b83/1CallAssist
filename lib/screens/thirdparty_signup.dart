import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/thirdpartnavbar.dart';
import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/healthbuy_form.dart';
import 'package:demo/screens/tp_homepage.dart';
import '../reusable_widgets/reusable_widget.dart';
import '../utils/color_utils.dart';
// import 'package:multiselect/multiselect.dart';
// import 'package:getwidget/getwidget.dart';
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
  String? healthins;
  String? lifeins;
  bool? check1 = false,check2 = false;
  int? lflag = 0;
  int? hflag = 1;
  List<String> insurance = ['Health', 'Life'];
  List<String> selectedInsurance = [];

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
                // SizedBox(
                //   height: 20,
                //   child: Text(
                //     'Which type of insurance you will provide?',
                //     style: TextStyle(
                //       fontSize: 18,
                //     )
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    // width: 750,
                    // height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10.0,top:15.0),
                              child: Icon(
                                Icons.health_and_safety_outlined,
                                color: Colors.black.withOpacity(0.3),
                              ),

                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0,top:15.0),
                              child: Text(
                                'Select insurance you will provide',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                // padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                child: Theme(
                                  data: ThemeData(unselectedWidgetColor: Colors.black.withOpacity(0.3)),
                                  child: CheckboxListTile(
                                    checkColor: Colors.black,
                                    activeColor: Colors.white,
                                    controlAffinity: ListTileControlAffinity.leading,
                                    // fillColor: MaterialStateProperty.resolveWith(getColor),
                                    value: check1,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        check1 = value!;
                                        if(check1!){
                                          hflag = 1;
                                          healthins = 'health';
                                          print(healthins);
                                        }
                                        else{
                                          hflag =0;
                                        }
                                      });
                                    },
                                    title: Text('Health',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.3)
                                      ),

                                    ),
                                  ),
                                ),
                            ),
                            Flexible(
                              child: Theme(
                                data: ThemeData(unselectedWidgetColor: Colors.black.withOpacity(0.3)),
                                child: CheckboxListTile(
                                  checkColor: Colors.black,
                                  activeColor: Colors.white,
                                  autofocus: false,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: check2,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      check2 = value!;
                                      if(check2!){
                                        lflag = 1;
                                        lifeins = 'life';
                                        print(lifeins);
                                      }
                                      else{
                                        lflag = 0;
                                     }
                                    });
                                  },
                                  title: Text('Life',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.3)
                                    ),
                                  ),
                                // tileColor: Colors.white.withOpacity(0.9),
                                ),
                              )
                            ),
                          ],
                        )
                      ],
                    )
                    // child: Text(
                    //   'Select insurance you will provide',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white.withOpacity(0.9),
                    //   ),
                    // ),
                    // child: Row(
                    //   children: [
                    //     // Text('Select insurance you will provide')
                    //
                    //   ],
                    // ),
                  ),
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
                    printdetails();
                    addThirdPartyDetails();
                    // addEmployeeDetails();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => TpHomePage()));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdPartyNavbar()));
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
  void printdetails(){
    print(_tpEmailController.text);
    print(_tpContactnumController.text);
    print(_tpCompnameController.text);
    print(_tpCompaddressController.text);
    if(hflag == 1){
      print(healthins);
    }
    // print(healthins);
    if(lflag == 1){
      print(lifeins);
    }
    // print(lifeins);

  }
  void addThirdPartyDetails() async{
    final User? user = await FirebaseAuth.instance.currentUser;
    String? provider_instype;
    final useruid = user?.uid;
    print(useruid);
    if (hflag == 1 &&  lflag == 1){
      provider_instype = 'Health and Life';
    }
    else{
      if(hflag == 1){
        provider_instype = 'Health';
      }
      if(lflag == 1){
        provider_instype = 'Life';
      }
    }
    print(provider_instype);

    // print(_tpEmailController.text);
    // print(_tpContactnumController.text);
    // print(_tpCompnameController.text);
    // print(_tpCompaddressController.text)
    // print(healthins);
    // print(lifeins);


    await FirebaseFirestore.instance.collection('ThirdParties').doc(user?.uid)
        .set({
      'Email':_tpEmailController.text,
      'ContactNumber' : _tpContactnumController.text,
      'CompanyName': _tpCompnameController.text,
      'InsuranceProvided': provider_instype,
      'CompanyAddress': _tpCompaddressController.text
    });

  }
}
