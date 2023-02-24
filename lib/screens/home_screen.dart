import 'package:flutter/material.dart';
import 'package:demo/screens/insurance.dart';
import '../reusable_widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late String healthval;
  late String lifeval;
  late int flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
                          // LOGOUT Feature
        actions: [
          IconButton(
            onPressed: (){
              signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],

        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  // Padding(padding: EdgeInsets.all(15),
                  Expanded(
                    // child: ClipRRect(
                    //
                    //     borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(context , MaterialPageRoute(builder: (BuildContext context) => Insurance()));
                        // healthval = 'health';
                        flag = 1;
                        _sendCategoryChoice(context);
                      },
                      child: Image.asset(
                        "assets/images/health.png",
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // ),
                  // )


                  // Padding(padding: EdgeInsets.all(15),
                  Expanded(
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(10.0),
                    child: GestureDetector(
                      onTap: (){
                        flag = 2;
                        _sendCategoryChoice(context);
                        // Navigator.push(context , MaterialPageRoute(builder: (BuildContext context) => Insurance()));
                        // lifeval = 'life';
                      },
                      child: Image.asset(
                        "assets/images/life.png",
                        height: 150.0,
                        width: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child:  Padding(padding: EdgeInsets.all(15),
                        child: Text(
                          'Health Insurance',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ),
                  Expanded(
                      child: Padding(padding: EdgeInsets.fromLTRB(25, 15, 15, 15),
                        child: Text(
                          'Life Insurance',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                  )
                ],
              )
            ],
          ),

      ),
    );
  }

  void _sendCategoryChoice(BuildContext context){
    if(flag == 1){
      String category = 'health';
      // late String ;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Insurance(val: category)));
    }
    else{
      String category = 'life';
      Navigator.push(context, MaterialPageRoute(builder: (context) => Insurance(val: category)));

    }
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

}

