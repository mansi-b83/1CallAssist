import 'package:flutter/material.dart';
import 'package:demo/screens/contact_details.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Insurance extends StatefulWidget {
  final String? val;
  const Insurance({Key? key,@required this.val}) : super(key: key);

  @override
  State<Insurance> createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  String? chosen_catg;
  String? option;
  @override
  Widget build(BuildContext context) {
    chosen_catg = widget.val;
    return Scaffold(
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
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: GestureDetector(
                      onTap: () {
                        print("Container was tapped");
                        option = 'buy';
                        _sendCategoryAndInsOption(context);
                        // Navigator.push(context , MaterialPageRoute(builder: (BuildContext context) => ContactDetail()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 0.0,top: 55.0,right: 0.0,bottom: 0.0),
                        height: 150,
                        width: 150,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.red,width: 4),
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.orangeAccent,
                          //     blurRadius: 15.0,
                          //   ),
                          // ],
                        ),
                        child: Text(
                          'Buy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                ),

                Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: GestureDetector(
                    onTap: () {
                      print("Container was tapped");
                      option = 'renew';
                      _sendCategoryAndInsOption(context);
                      // Navigator.push(context , MaterialPageRoute(builder: (BuildContext context) => ContactDetail()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 0.0,top: 55.0,right: 0.0,bottom: 0.0),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(80)),
                      ),
                      child: Text(
                        'Renew',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: GestureDetector(
                      onTap: () {
                        print("Container was tapped");
                        option = 'claim';
                        _sendCategoryAndInsOption(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ContactDetail()));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 0.0,top: 55.0,right: 0.0,bottom: 0.0),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 4),
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                        ),
                        child: Text(
                          'Claim',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                ),
              ],
            )
          ],
        ),
    );
  }
  void _sendCategoryAndInsOption(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetail(finalcatg: chosen_catg, finalopt: option)));
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
