import 'package:demo/screens/Employees/emp_homepage.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/Employees/buy_requests.dart';
import 'package:demo/screens/Employees/renew_requests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/screens/signin_screen.dart';
// import 'package:flutter_application_3/test2.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

//import 'package:line_icons/line_icons.dart';

class EmpNavbar extends StatefulWidget {
  const EmpNavbar({super.key});
  @override
  _EmpNavbarState createState() => _EmpNavbarState();
}

class _EmpNavbarState extends State<EmpNavbar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    // HomeScreen(),
    EmpHomePage(),
    Buy_Page(),
    RenewApp(),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 20,
        // title: const Text('GoogleNavBar'),
        leading: Icon(Icons.menu),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Buy',
                ),
                GButton(
                  icon: Icons.autorenew,
                  text: 'Renew',
                ),
                GButton(
                  icon: Icons.check_box,
                  text: 'Claim',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
