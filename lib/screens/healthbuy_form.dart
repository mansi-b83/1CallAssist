import 'package:demo/screens/select_tp.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class healthbuyForm extends StatefulWidget {
  final String? userid;
  final String? category;
  final String? requestid;
  final String? option;
  // final List? famdetails;
  const healthbuyForm({Key? key, @required this.userid,@required this.requestid,@required this.category,@required this.option}) : super(key: key);

  @override
  State<healthbuyForm> createState() => _healthbuyFormState();
}

class _healthbuyFormState extends State<healthbuyForm> {
  String? smoke,selected_gender;
  String? tobacco;
  String instype = 'Individual';
  int? flag = 0;
  int? age,noofmem;
  double? bmi;
  String? disease;
  bool _showTextField = false;
  bool _showdiseasenametxtbox = false;
  // final List<FamControllers> famdetailsControllers = List<FamControllers>();
  var gender = [
    'Male',
    'Female',
    'Other',
  ];
  var types = [
    'Family',
    'Individual',
  ];
  List buy_famdetails =[];
  String? buy_userid,buy_requestid,buy_category,ins_option;
  String? newid;

  TextEditingController numofmem_contr = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController diseaseController = TextEditingController();
  TextEditingController bmi_contr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // buy_famdetails = widget.famdetails!;
    buy_category = widget.category;
    buy_requestid = widget.requestid;
    buy_userid = widget.userid;
    ins_option = widget.option;
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Health Insurance'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          // padding: EdgeInsets.only(top: 40.0),

          // child: AlertDialog(
          //   insetPadding: EdgeInsets.all(0),
            child: Form(
              key: _formKey,
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
               // child: Column(
                 children: [
                   Padding(padding: EdgeInsets.only(left: 10.0,top: 30.0,bottom: 15.0,right: 15.0),
                     child: TextField(
                         controller: ageController,
                         keyboardType: TextInputType.number,
                         decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           // labelText: 'Contact Number',
                           hintText: 'Enter Age',
                         ),

                         onChanged: (value){
                           setState(() {
                             age = int.parse(value);
                             print(age);
                           });
                         }
                     ),
                   ),
                   Padding(padding: EdgeInsets.all(10),
                       child: Align(
                         alignment: Alignment.centerLeft,
                         child: DropdownButton(
                           hint: Text('Gender'),
                           value: selected_gender,
                           icon: Icon(Icons.keyboard_arrow_down,
                             color: Colors.black,
                           ),
                           items: gender.map((String items) {
                             return DropdownMenuItem(
                               value: items,
                               child: Text(items,),
                             );
                           }).toList(),
                           onChanged: (String? newval){
                             setState(() {
                               selected_gender = newval!;
                               print(selected_gender);
                             });
                           },
                         ),
                       )
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                         'Do you smoke?',
                         style: TextStyle(
                           fontSize: 18,
                           // color: Colors.grey,
                         ),
                       ),
                     )
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Flexible(
                           child: RadioListTile(
                             title: Text("Yes"),
                             value: "yes",
                             groupValue: smoke,
                             onChanged: (value){
                               setState(() {
                                 smoke = value.toString();
                                 print(smoke);
                               });
                             },
                           ),
                         ),
                         Flexible(
                           child: RadioListTile(
                             title: Text("No"),
                             value: "no",
                             groupValue: smoke,
                             onChanged: (value) {
                               setState(() {
                                 smoke = value.toString();
                                 print(smoke);
                               });
                             },
                           ),
                         )

                       ],
                     ),
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Align(
                       alignment: Alignment.centerLeft,
                       child: Text(
                         'Do you consume Tobacco?',
                         style: TextStyle(
                           fontSize: 18,
                           // color: Colors.grey,
                         ),
                       ),
                     )
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Flexible(
                           child: RadioListTile(
                             title: Text("Yes"),
                             value: "yes",
                             groupValue: tobacco,
                             onChanged: (value){
                               setState(() {
                                 tobacco = value.toString();
                                 print(tobacco);
                               });
                             },
                           ),
                         ),
                         Flexible(
                           child: RadioListTile(
                             title: Text(" No"),
                             value: "no",
                             groupValue: tobacco,
                             onChanged: (value){
                               setState(() {
                                 tobacco = value.toString();
                                 print(tobacco);
                               });
                             },
                           ),
                         )
                       ],
                     ),
                   ),
                   Padding(padding: EdgeInsets.all(10.0),
                     child: TextFormField(
                       controller: bmi_contr,
                       decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         // labelText: 'Contact Number',
                         hintText: 'BMI',
                       ),
                       keyboardType: TextInputType.number,
                       onChanged: (value) {
                         setState(() {
                           bmi = double.parse(value);
                           print(bmi);
                         });
                       },
                     ),
                   ),
                   // Padding(padding: EdgeInsets.only(right: 15.0),
                   //   child: TextFormField(
                   //     controller: numofmem_contr,
                   //     decoration: InputDecoration(
                   //       border: OutlineInputBorder(),
                   //       // labelText: 'Contact Number',
                   //       hintText: 'Number of Members',
                   //     ),
                   //     keyboardType: TextInputType.number,
                   //     onChanged: (value) {
                   //       setState(() {
                   //         noofmem = int.parse(value);
                   //         print(noofmem);
                   //       });
                   //     },
                   //   ),
                   // ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Row(
                       children: [
                         Flexible(
                           child: Text(
                             'Insurance Type',
                             style: TextStyle(
                               fontSize: 18,
                             ),
                           ),
                         ),
                         Flexible(
                           child: DecoratedBox(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                               color: Colors.white12,
                               border: Border.all(color: Colors.white10, width: 3),
                               // boxShadow: <BoxShadow>[
                               //   BoxShadow(
                               //       color: Color.fromRGBO(0, 0, 0, 0.10), //shadow for button
                               //       blurRadius: 3
                               //   ) //blur radius of shadow
                               // ]
                             ),
                             child: Padding(padding: EdgeInsets.all(10),
                               child: DropdownButton(
                                 value: instype,
                                 icon: Icon(Icons.keyboard_arrow_down),
                                 items: types.map((String items){
                                   return DropdownMenuItem(
                                     value: items,
                                     child: Text(items),
                                   );
                                 }).toList(),
                                 onChanged: (String? typeval) {
                                   setState(() {
                                     instype = typeval!;
                                     print(instype);
                                     if(instype == 'Family'){
                                       flag = 1;
                                       print(flag);
                                       _showTextField = true;
                                     }else{
                                       flag = 0;
                                       _showTextField = false;
                                     }
                                     // print(flag);
                                   });
                                 },
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Visibility(
                         visible: _showTextField,
                         child: Row(
                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             SizedBox(
                               width: 200,
                               // child:  Padding(padding: EdgeInsets.all(10.0),
                                 child: TextFormField(
                                   controller: numofmem_contr,
                                   decoration: InputDecoration(
                                     border: OutlineInputBorder(),
                                     // labelText: 'Contact Number',
                                     hintText: 'Number of members',
                                   ),
                                   keyboardType: TextInputType.number,
                                   onChanged: (value) {
                                     setState(() {
                                       noofmem = int.parse(value);
                                       print(noofmem);
                                     });
                                   },
                                 ),
                               // ),
                             ),
                             // SizedBox(
                             //   height: 40,
                             //   width: 110,
                             //     child: ElevatedButton(
                             //       child: Text('Add entries',
                             //         style: TextStyle(
                             //           fontSize: 16,
                             //         ),
                             //       ),
                             //       onPressed: () async {
                             //         List<FamDetailsEntry> persons = await Navigator.push(context, MaterialPageRoute(builder: (context) => _famDetails()));
                             //         if (persons != null){
                             //           buy_famdetails =[];
                             //           for(int i = 0;i<persons.length;i++){
                             //             buy_famdetails.add(persons[i]);
                             //           }
                             //         }
                             //         // setState(() {
                             //         //
                             //         // });
                             //       },
                             //       style: ButtonStyle(
                             //         backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                             //       ),
                             //
                             //     ),
                             // ),
                           ],
                         )

                     ),
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Text(
                       'Any existing disease or illness?',
                       style: TextStyle(
                         fontSize: 18,
                         // color: Colors.grey,
                       ),
                     ),
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Flexible(
                           child: RadioListTile(
                             title: Text("Yes"),
                             value: "yes",
                             groupValue: disease,
                             onChanged: (String? disval) {
                               setState(() {
                                 disease = disval!;
                                 print(disease);
                                 _showdiseasenametxtbox = true;
                               });
                             },
                           ),
                         ),
                         Flexible(
                           child: RadioListTile(
                             title: Text(" No"),
                             value: "no",
                             groupValue: disease,
                             onChanged: (String? value){
                               setState(() {
                                 disease = value!;
                                 print(disease);
                                 _showdiseasenametxtbox = false;
                               });
                             },

                           ),
                         )
                       ],
                     ),
                   ),

                   Padding(padding: EdgeInsets.all(10),
                     child: Visibility(
                       visible: _showdiseasenametxtbox,
                       child: TextFormField(
                         controller: diseaseController,
                         decoration: InputDecoration(
                           border: OutlineInputBorder(),
                           // labelText: 'Contact Number',
                           hintText: 'Enter disease/illness',
                         ),
                       ),
                     ),
                   ),

                   Center(
                     child: Padding(padding: EdgeInsets.all(20),
                       child: SizedBox(
                         height: 50,
                         child: ElevatedButton.icon(
                           icon: Icon(Icons.send_outlined),
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all(Color(0xFFfe846f)),
                           ),
                           onPressed: (){
                             print("button pressed");
                             final form = _formKey.currentState;
                             if (form != null && !form.validate()){
                               return;
                             }
                             else{
                               form?.save();
                               sendbuyforminput();
                               // _sendFinalUserinfo(context);
                               // create_pdf();

                             }
                           },
                           label: Text(
                             'Send',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 22,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],
               ),
              // ),
            ),
          // )
        ),
      );
    // );
  }
  // void create_pdf() async{
  //   PdfDocument document = PdfDocument();
  //   document.pages.add();
  //
  //   List<int> bytes = await document.save();
  //   document.dispose();
  //
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) => )
  //   saveAndLaunchFile(bytes, 'Output.pdf');
  //
  // }
  void sendbuyforminput() async{
    // await Navigator.push(context, MaterialPageRoute(builder: (context) => PDFPreviewPage(userage: age, smoke_status: smoke, tobacco_status: tobacco, ins_type: instype, disease_status: disease)));
    await databaseReference.collection("Employee_Clients")
        .add({
            'Category' : '$buy_category',
            'Option' : '$ins_option',
            'RequestID' : '$buy_requestid',
            'UserID' : '$buy_userid',
            'EmployeeID' : user?.uid,
            'Age' : '$age',
            'Gender': '$selected_gender',
            'Smoke' : '$smoke',
            'Tobacco' : '$tobacco',
            'BMI' : '$bmi',
            'InsuranceType' : '$instype',
            // 'Members' : FieldValue.arrayUnion(buy_famdetails),
            'ExistingDisease' : '$disease',
        })
          .then((value) {
            newid = value.id;
            print("User Request Added $newid");
          })
          .catchError((error) => print("Failed to add user: $error"));

      if(disease == 'yes'){
        await databaseReference.collection('Employee_Clients').doc(newid)
            .update({
          'DiseaseName': '${diseaseController.text}'
        })
            .then((value) => print('disease name added'))
            .catchError((error) => print("Failed to add disease: $error"));

      }
      if(instype == 'Family'){
          await databaseReference.collection('Employee_Clients').doc(newid)
              .update({
            'Members' : noofmem,
          })
              .then((value) => print('No of members added'))
              .catchError((error) => print("Failed to add no of memebers: $error"));
      }
      if(instype == 'Individual'){
        await databaseReference.collection('Employee_Clients').doc(newid)
          .update({
          'Members' : 0,
        })
          .then((value) => print('No of members added'))
          .catchError((error) => print("Failed to add no of memebers: $error"));
      }
      // if(instype == 'Family') {
      //   await databaseReference.collection('Employee_Clients').doc(newid)
      //       .update({
      //     'MemberDetails' : FieldValue.arrayUnion(buy_famdetails),
      //   })
      //       .then((value) => print('famdetails added'))
      //       .catchError((error) => print("Failed to add family details: $error"));
      // }
      
      await databaseReference.collection('User_Requests')
          .where('RequestID', isEqualTo: '$buy_requestid')
          .get()
          .then((value) => value.docs.forEach((doc) {
            doc.reference.update({'Status' : 'Necessary details collected'});
      })).catchError((error) => print('Status not updated: $error'));


      print('Age- $age');
      print('Smoke- $smoke');
      print('Tobacco- $tobacco');
      if(flag == 1){
        print('Insurance Type- $instype');
        print('Number of members- ${numofmem_contr.text}');
        print('Family Details- $buy_famdetails');
      }
      else{
        print('Insurance Type- $instype');
      }
      print('Any existing disease?- $disease');
      if(disease == 'yes'){
        print('Disease - ${diseaseController.text}');
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTp(curr_docid: newid,reqid: buy_requestid)));
    // else{
    //   print('Age- $age');
    //   print('Smoke- $smoke');
    //   print('Tobacco- $tobacco');
    //   print('Insurance Type- $instype');
    //   print('Any existing disease?- $disease');
    //   if(disease == 'yes'){
    //     print('Disease - ${diseaseController.text}');
    //   }
      // print()
  }
}


// class _famDetails extends StatefulWidget {
//   const _famDetails({Key? key}) : super(key: key);
//
//   @override
//   State<_famDetails> createState() => _famDetailsState();
// }

// class _famDetailsState extends State<_famDetails> {
//   var fam_relation = <TextEditingController>[];
//   var fam_age = <TextEditingController>[];
//   var cards = <Card>[];
//
//   Card createCard(){
//     var famrelationController = TextEditingController();
//     var fammem_ageController = TextEditingController();
//     fam_relation.add(famrelationController);
//     fam_age.add(fammem_ageController);
//     return Card(
//       margin: EdgeInsets.all(20),
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//           // Text('Pe ${cards.length + 1}'),
//           TextField(
//             controller: famrelationController,
//             decoration: InputDecoration(labelText: 'Realtionship')),
//           TextField(
//             controller: fammem_ageController,
//             decoration: InputDecoration(labelText: 'Age')),
//           ],
//         ),
//     );
//   }
//   @override
//   void initState() {
//     super.initState();
//     cards.add(createCard());
//   }
//   _onDone() {
//     List<FamDetailsEntry> entries = [];
//     for (int i = 0; i < cards.length; i++) {
//       var fammem_rel = fam_relation[i].text;
//       var fammem_age = fam_age[i].text;
//       entries.add(FamDetailsEntry(fammem_rel, fammem_age));
//     }
//
//     // for(int j=0;j < entries.length; j++){
//     //   print('Entry $j - ${entries[j]}');
//     // }
//     print('Entries $entries');
//     Navigator.pop(context,entries);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: Colors.orangeAccent,
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: cards.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return cards[index];
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               child: Text('add new',
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//
//               ),
//               onPressed: () => setState(() => cards.add(createCard())),
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
//               ),
//             ),
//           )
//         ],
//       ),
//       floatingActionButton:
//       FloatingActionButton(child: Icon(Icons.done),
//         onPressed: _onDone,
//         backgroundColor: Colors.orangeAccent,
//       ),
//     );
//   }
//   // void addHealthBuyDetails() async{
//   //
//   // }
// }

// class FamDetailsEntry {
//   final String relation;
//   final String age;
//   FamDetailsEntry(this.relation, this.age);
//   @override
//   String toString() {
//     return 'Relation= $relation, Age= $age';
//   }
// }



