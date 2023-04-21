import 'package:demo/screens/interested_quotations.dart';
import 'package:demo/screens/user_accountinfo.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
class User_Botnav extends StatefulWidget {
  const User_Botnav({Key? key}) : super(key: key);

  @override
  State<User_Botnav> createState() => _User_BotnavState();
}

class _User_BotnavState extends State<User_Botnav> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Text('hello'),
    // Text('Account'),

    HomeScreen(),
    User_AccountInfo(),
    User_InterestedQuotations(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // late int _currentIndex;
  // late List<Widget> _children;
  //
  // @override
  // void initState() {
  //   _currentIndex = 0;
  //   _children = [
  //       HomeScreen(),
  //       User_AccountInfo(),
  //       User_InterestedQuotations(),
  //   ];
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    // return CupertinoTabScaffold(
    //     tabBar: CupertinoTabBar(
    //       currentIndex: _currentIndex,
    //       onTap: onTabTapped,
    //       // selectedItemColor: Colors.amber[800],
    //       items: [
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.home),
    //           label: 'Home',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.account_box_rounded),
    //           label: 'Account',
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.text_snippet_rounded),
    //           label: 'Quotations',
    //         ),
    //       ],
    //
    //     ),
    //     tabBuilder: (BuildContext context, int index) {
    //       return CupertinoTabView(
    //         builder: (BuildContext context) {
    //           return SafeArea(
    //             top: false,
    //             bottom: false,
    //             child: CupertinoApp(
    //               home: CupertinoPageScaffold(
    //                 resizeToAvoidBottomInset: false,
    //                 child: _children[_currentIndex],
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     }
    // );
    return Scaffold(
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
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Account',
            // backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_rounded),
            label: 'Quotations',
            // backgroundColor: Colors.green,
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index){
          setState((){
            _selectedIndex = index;
          });
        },
      ),
    );
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
