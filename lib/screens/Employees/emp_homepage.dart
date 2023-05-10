import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/Employees/quotation_receivedpage.dart';


class EmpHomePage extends StatefulWidget {
  const EmpHomePage({Key? key}) : super(key: key);

  @override
  State<EmpHomePage> createState() => _EmpHomePageState();
}

class _EmpHomePageState extends State<EmpHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(20.0),
                        child: Text('Received Quatations'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          child: Text(
                            'Click Here',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xFFfe846f))
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => QuatationsRecdPage()));
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
