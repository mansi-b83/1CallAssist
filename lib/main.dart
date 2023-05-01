import 'package:demo/screens/Employees/empnavbar.dart';
import 'package:demo/screens/home_screen.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:demo/screens/select_tp_health.dart';
import 'package:demo/screens/select_tp.dart';
import 'package:demo/screens/user_payment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(const MyApp());
  // runApp(
  //     MaterialApp(
  //         home: email == null ? Login() : Home()
  //     )
  // );
}
// String finalemail;
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState(){
//     super.initState();
//     getvalidationData();
//   }
//   Future getvalidationData() async{
//     final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     var obtainedEmail = sharedPreferences.getString('email');
//     setState((){
//       finalemail = obtainedEmail!;
//     });
//     print(finalemail);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       // home: const SignInScreen(),
//       home: finalemail == null ? SignInScreen() : HomeScreen()
//       // home: const Payment_Integrate(),
//       // home: SelectTp(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  // final String email;
  const MyApp({Key? key}) : super(key: key);

  // Future getvalidationData() async{
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var obtainedEmail = sharedPreferences.getString('email');
  //   setState((){
  //
  //   })
  // }

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
      // home: email == null ? Login() : Home(),
      // home: const Payment_Integrate(),
      // home: SelectTp(),
    );
  }
}
