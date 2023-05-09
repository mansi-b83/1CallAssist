import 'package:demo/screens/select_tp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LifeBuyForm extends StatefulWidget {
  final String? userid;
  final String? category;
  final String? requestid;
  final String? option;
  const LifeBuyForm({Key? key, @required this.userid,@required this.requestid,@required this.category,@required this.option}) : super(key: key);

  @override
  State<LifeBuyForm> createState() => _LifeBuyFormState();
}

class _LifeBuyFormState extends State<LifeBuyForm> {
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController nomineenameController = TextEditingController();
  TextEditingController nomineerelationController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController fbsController = TextEditingController();
  TextEditingController restecgController = TextEditingController();
  TextEditingController cpController = TextEditingController();
  TextEditingController thalachController = TextEditingController();
  TextEditingController exangController = TextEditingController();
  TextEditingController cholController = TextEditingController();

  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var gender = [
    'Male',
    'Female',
    'Other',
  ];
  var cptype = [
    'Typical Angina',
    'Atypical Angina',
    'Non-anginal pain',
    'Asymptomatic',
  ];

  var thaltype = [
    'Normal',
    'Fixed Defect',
    'Reversable Defect',
  ];
  int? age,restecg,bp,maxhr,chol,fbs;
  String? selected_gender,selected_cptype,selected_thal;
  String? buy_userid,buy_requestid,buy_category,ins_option;
  String? newid;
  String? aadharnum;
  String? pannum;
  String? nomname;
  String? nomrelation,cp,exang;
  @override
  Widget build(BuildContext context) {
    buy_category = widget.category;
    buy_requestid = widget.requestid;
    buy_userid = widget.userid;
    ins_option = widget.option;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          child: AlertDialog(
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child:Column(
                  children: [
                    SizedBox(
                         child: Padding(padding: EdgeInsets.only(bottom: 15.0),
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
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15.0),
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
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child:  TextFormField(
                          controller: aadharController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // labelText: 'Contact Number',
                            hintText: 'Aadhar Number',
                          ),
                          onChanged: (value) {
                            setState(() {
                              aadharnum = value;
                              print(aadharnum);
                            });
                          }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: panController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'PAN Number',
                            ),
                            onChanged: (value) {
                              setState(() {
                                pannum = value;
                                print(pannum);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: nomineenameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Nominee Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                nomname = value;
                                print(nomname);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: nomineerelationController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Nominee Relation',
                            ),
                            onChanged: (value) {
                              setState(() {
                                nomrelation = value;
                                print(nomrelation);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: bpController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Blood pressure',
                            ),
                            onChanged: (value) {
                              setState(() {
                                bp = int.parse(value);
                                print(bp);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: cholController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Cholestrol',
                            ),
                            onChanged: (value) {
                              setState(() {
                                chol = int.parse(value);
                                print(chol);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: fbsController, decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Fasting Blood sugar',
                            ),
                            onChanged: (value) {
                              setState(() {
                                fbs = int.parse(value);
                                print(fbs);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: restecgController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Resting Electrocardiographic Results',
                            ),
                            onChanged: (value) {
                              setState(() {
                                restecg = int.parse(value);
                                print(restecg);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: TextFormField(
                            controller: thalachController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              // labelText: 'Contact Number',
                              hintText: 'Maximum Heart Rate',
                            ),
                            onChanged: (value) {
                              setState(() {
                                maxhr = int.parse(value);
                                print(maxhr);
                              });
                            }
                          // keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton(
                              hint: Text('Chest Pain type'),
                              value: selected_cptype,
                              icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              items: cptype.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items,),
                                );
                              }).toList(),
                              onChanged: (String? newval){
                                setState(() {
                                  selected_cptype = newval!;
                                  print(selected_cptype);
                                });
                              },
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: DropdownButton(
                              hint: Text('Thalassemia'),
                              value: selected_thal,
                              icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              items: thaltype.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items,),
                                );
                              }).toList(),
                              onChanged: (String? newval){
                                setState(() {
                                  selected_thal = newval!;
                                  print(selected_thal);
                                });
                              },
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Do you have Excercise Induced Angina?',
                              style: TextStyle(
                                fontSize: 16,
                                // color: Colors.grey,
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: RadioListTile(
                                title: Text("Yes"),
                                value: "yes",
                                groupValue: exang,
                                onChanged: (value){
                                  setState(() {
                                    exang = value.toString();
                                    print(exang);
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              child: RadioListTile(
                                title: Text("No"),
                                value: "no",
                                groupValue: exang,
                                onChanged: (value) {
                                  setState(() {
                                    exang = value.toString();
                                    print(exang);
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   child: Padding(
                    //     padding: EdgeInsets.only(bottom: 15),
                    //     child: Align(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text(
                    //         'Do you have Thalassemia?',
                    //         style: TextStyle(
                    //           fontSize: 16,
                    //           // color: Colors.grey,
                    //         ),
                    //       ),
                    //     )
                    //   ),
                    // ),
                    //
                    // SizedBox(
                    //   child: Padding(padding: EdgeInsets.only(bottom: 15.0),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //         Flexible(
                    //           child: RadioListTile(
                    //             title: Text("Yes"),
                    //             value: "yes",
                    //             groupValue: thal,
                    //             onChanged: (value){
                    //               setState(() {
                    //                 thal = value.toString();
                    //                 print(thal);
                    //               });
                    //             },
                    //           ),
                    //         ),
                    //         Flexible(
                    //           child: RadioListTile(
                    //             title: Text("No"),
                    //             value: "no",
                    //             groupValue: thal,
                    //             onChanged: (value) {
                    //             setState(() {
                    //               thal = value.toString();
                    //               print(thal);
                    //             });
                    //           },
                    //         ),
                    //       )
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      child: Padding(padding: EdgeInsets.only(bottom: 20),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.send_outlined),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
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
                  ],
                )
              )
            ),
          ),
        )
      ),
    );
  }
  void sendbuyforminput() async{
    // await Navigator.push(context, MaterialPageRoute(builder: (context) => PDFPreviewPage(userage: age, smoke_status: smoke, tobacco_status: tobacco, ins_type: instype, disease_status: disease)));
    await databaseReference.collection("Employee_Clients")
        .add({
      'Category' : '$buy_category',
      'Option' : '$ins_option',
      'RequestID' : '$buy_requestid',
      'UserID' : '$buy_userid',
      'EmployeeID' : user?.uid,
      'Age' : age,
      'Gender' : '$selected_gender',
      'AadharNumber' : '$aadharnum',
      'PANNumber' : '$pannum',
      'NomineeName' : '$nomname',
      'NomineeRelation' : '$nomrelation',
      'BloodPressure' : bp,
      'Cholestrol' : chol,
      'FastingBloodSugar' : fbs,
      'RestECG' : restecg,
      'MaxHeartRate' : maxhr,
      'ChestPainType' : '$selected_cptype',
      'Thalassemia' : '$selected_thal',
      'ExerciseAngima': '$exang',

      // ''
      // 'Members' : FieldValue.arrayUnion(buy_famdetails),
      // 'ExistingDisease' : '$disease',
    })
        .then((value) {
      newid = value.id;
      print("User Request Added $newid");
    })
        .catchError((error) => print("Failed to add user: $error"));

    // if(disease == 'yes'){
    //   await databaseReference.collection('Employee_Clients').doc(newid)
    //       .update({
    //     'DiseaseName': '${diseaseController.text}'
    //   })
    //       .then((value) => print('disease name added'))
    //       .catchError((error) => print("Failed to add disease: $error"));
    //
    // }
    // if(flag == 1) {
    //   await databaseReference.collection('Employee_Clients').doc(newid)
    //       .update({
    //     'Member' : '$buy_famdetails',
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


    // print('Age- $age');
    // print('Smoke- $smoke');
    // print('Tobacco- $tobacco');
    // if(flag == 1){
    //   print('Insurance Type- $instype');
    //   print('Number of members- ${numofmem_contr.text}');
    //   print('Family Details- $buy_famdetails');
    // }
    // else{
    //   print('Insurance Type- $instype');
    // }
    // print('Any existing disease?- $disease');
    // if(disease == 'yes'){
    //   print('Disease - ${diseaseController.text}');
    // }
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
