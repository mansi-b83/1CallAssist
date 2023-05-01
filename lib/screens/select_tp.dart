import 'package:flutter/material.dart';
import 'package:demo/screens/select_tp_life.dart';
import 'package:demo/screens/select_tp_health.dart';
// import 'package:icon_forest/icon_forest.dart';

class SelectTp extends StatefulWidget {
  final String? curr_docid;
  final String? reqid;
  const SelectTp({Key? key,@required this.curr_docid,@required this.reqid}) : super(key: key);

  @override
  State<SelectTp> createState() => _SelectTpState();
}

class _SelectTpState extends State<SelectTp> {
  int current_index = 0;
  String? docid;
  String? rid;
  List<Widget> pages = [];

  void OnTapped(int index) {
    setState(() {
      current_index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    docid = widget.curr_docid;
    rid = widget.reqid;
    pages = [healthTp(docid: docid,rid: rid), LifeTp(docid: docid,rid: rid)];
    return Scaffold(
      body: pages[current_index],
      bottomNavigationBar: Container(
        height: 70,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromARGB(255, 241, 162, 27),
              iconSize: 20.0,
              selectedIconTheme: IconThemeData(size: 28.0),
              selectedItemColor: Color.fromARGB(255, 255, 255, 255),
              unselectedItemColor: Colors.black,
              selectedFontSize: 16.0,
              unselectedFontSize: 12,
              currentIndex: current_index,
              onTap: OnTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.health_and_safety),
                  // icon: Text('Health'
                  //     ''),
                  label: "Health",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  // icon: Text('Life',
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //   )
                  // ),
                  label: 'Life',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.person),
                //   label: "Account",
                // ),
              ]),
        ),
      ),
    );
  }
}