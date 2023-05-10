import 'package:demo/screens/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ApiService/apiServiceGetPremium.dart';

class SuggestedPremium extends StatefulWidget {
  String requestID;
   SuggestedPremium(this.requestID);

  @override
  State<SuggestedPremium> createState() => _SuggestedPremiumState();
}

class _SuggestedPremiumState extends State<SuggestedPremium> {
  void signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext,
        MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  final apiServiceGetPremium _serviceGetPremium = apiServiceGetPremium();

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              signOut();
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: FutureBuilder(
            future: _serviceGetPremium.getSuggesstedPremium(widget.requestID),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Text(
                    snapshot.data!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "Retrieveing Data",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
            })),
      ),
    );
  }
}
