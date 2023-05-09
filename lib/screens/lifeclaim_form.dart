import 'package:demo/screens/select_tp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';


class LifeClaim_form extends StatefulWidget {

  final String? userid;
  final String? category;
  final String? option;
  final String? requestid;
  const LifeClaim_form({Key? key,@required this.userid,@required this.category,@required this.option,@required this.requestid}) : super(key: key);

  @override
  State<LifeClaim_form> createState() => _LifeClaim_formState();
}

class _LifeClaim_formState extends State<LifeClaim_form> {
  List<File> images = [];
  String? catg;
  String? opt;
  String? reqid;
  String? userid;
  String? newid;
  TextEditingController policynumController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController nompanController = TextEditingController();
  TextEditingController nomaadharController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  var reasons = [
    'Maturity',
    'Death',
    'Rider',
  ];
  String? selected_reason;
  @override
  Widget build(BuildContext context) {
    catg = widget.category;
    opt = widget.option;
    reqid = widget.requestid;
    userid = widget.userid;
    return Scaffold(
        appBar: AppBar(
          elevation: 20,
          // title: const Text('GoogleNavBar'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          // actions: [
            // IconButton(
            //   // onPressed: (){
            //   //   signOut();
            //   // },
            //   icon: Icon(Icons.logout_outlined),
            // ),
          // ],
          backgroundColor: Colors.orangeAccent,
        ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: policynumController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Your Policy Number'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextField(
              //     controller: mompaniController,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(), hintText: 'Nominee PAN number'),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextField(
              //     controller:  nomaadharController,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(), hintText: 'Nominee Aadhar Number'),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: TextField(
              //     controller: upiController,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(), hintText: 'Nominee UPI ID'),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                      'Reason of claim?',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                )
                // child: TextField(
                //   controller: upiController,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(), hintText: 'Nominee UPI ID'),
                // ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownButton(
                    hint: Text('Select reason'),
                    value: selected_reason,
                    icon: Icon(Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                    items: reasons.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,),
                      );
                    }).toList(),
                    onChanged: (String? newval){
                      setState(() {
                        selected_reason = newval!;
                        print(selected_reason);
                        images = [];
                        // otherrequired_details(selected_reason!);
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              otherrequired_details(),
            ],
          ),
        ),
      )
    );
  }
  Widget otherrequired_details(){
    print('inside otherrequired_details $selected_reason');
    if(selected_reason == 'Maturity'){
      // images = [];
      print('inside if $selected_reason');
      // return Text(
      //   'Hello',
      // );
      return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            // SizedBox(
            //   height: 50,
            // ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  '**Upload Photo ID Proof of the policyholder,copy of bank statement/cancelled cheque',
                  style: TextStyle(
                  color: Colors.red
                  ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                getMultipImage();
              },
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Icon(
                            Icons.upload_file,
                            size: 24,
                          ),
                        )
                    ),
                  ),
              )
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              height: 100,
              child: images.length == 0
                  ? Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("No Images found"),
                ),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.file(
                          images[i],
                          fit: BoxFit.cover,
                        )
                    ),

                  );
                },
                itemCount: images.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: upiController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Your UPI ID'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                color: Colors.orangeAccent,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                onPressed: () async {
                  print('send clicked');
                  for (int i = 0; i < images.length; i++) {
                    String url = await uploadFile(images[i]);
                    downloadUrls.add(url);

                    if (i == images.length - 1) {
                      storeMaturityEntry(downloadUrls, policynumController.text,upiController.text);
                    }
                  }
                },
                child: Text("Send",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    }
    else if(selected_reason == 'Death'){
      // List<File> images = [];
      print('inside else if');
      return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            // SizedBox(
            //   height: 50,
            // ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  '**Upload Death Certificate issued by local authority, Treating Doctor’s Statement, Medical Records, Nominee’s Bank Account Details(copy of bank statement/cancelled cheque)',
                style: TextStyle(
                  color: Colors.red,
                )
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                getMultipImage();
              },
              child:Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Icon(
                          Icons.upload_file,
                          size: 24,
                        ),
                      )
                  ),
                ),
              )
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              height: 100,
              child: images.length == 0
                  ? Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("No Images found"),
                ),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        width: 80,
                        margin: EdgeInsets.only(right: 10),
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.file(
                          images[i],
                          fit: BoxFit.cover,
                        )
                    ),

                  );
                },
                itemCount: images.length,
              ),
            ),
            // const SizedBox(
            //   height: 50,
            // ),
            //
            // // const SizedBox(
            // //   height: 20,
            // // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: TextField(
            //     controller: upiController,
            //     decoration: InputDecoration(
            //         border: OutlineInputBorder(), hintText: 'Nomimee UPI ID'),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: nompanController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nominee PAN number'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller:  nomaadharController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nominee Aadhar Number'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: upiController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nominee UPI ID'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                color: Colors.orangeAccent,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                onPressed: () async {
                  print('send clicked');
                  for (int i = 0; i < images.length; i++) {
                    String url = await uploadFile(images[i]);
                    downloadUrls.add(url);

                    if (i == images.length - 1) {
                      storeDeathandRiderEntry(downloadUrls, policynumController.text,nompanController.text,nomaadharController.text,upiController.text);
                    }
                  }
                },
                child: Text("Send",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    }
    else if(selected_reason == 'Rider'){
      // List<File> images = [];
      print('inside else if');
      return Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            // SizedBox(
            //   height: 50,
            // ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  '**Upload Doctor’s Report, Postmortem Report,Copy of FIR,Nominee’s Photo ID Proof',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                getMultipImage();
              },
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Icon(
                          Icons.upload_file,
                          size: 24,
                        ),
                      )
                  ),
                ),
              )
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              height: 100,
              child: images.length == 0
                  ? Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("No Images found"),
                ),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                        height: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.file(
                          images[i],
                          fit: BoxFit.cover,
                        )
                    ),

                  );
                },
                itemCount: images.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: nompanController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nominee PAN number'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller:  nomaadharController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nominee Aadhar Number'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // const SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: upiController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nominee UPI ID'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                color: Colors.orangeAccent,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                height: 50,
                onPressed: () async {
                  print('send clicked');
                  for (int i = 0; i < images.length; i++) {
                    String url = await uploadFile(images[i]);
                    downloadUrls.add(url);

                    if (i == images.length - 1) {
                      storeDeathandRiderEntry(downloadUrls, policynumController.text,nompanController.text,nomaadharController.text,upiController.text);
                    }
                  }
                },
                child: Text("Send",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    }
    else{
      return Container();
    }
  }
  List<String> downloadUrls = [];

  final ImagePicker _picker = ImagePicker();

  getMultipImage() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      pickedImages.forEach((e) {
        images.add(File(e.path));
      });

      setState(() {});
    }
  }

  Future<String> uploadFile(File file) async {
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  storeMaturityEntry(List<String> imageUrls, String pnum, String upi) async{
    await FirebaseFirestore.instance
        .collection('Employee_Clients')
        .add({
      'Category' : '$catg',
      'Option' : '$opt',
      'RequestID' : '$reqid',
      'UserID' : '$userid',
      'EmployeeID' :  user?.uid,
      'ReasonOfClaim' : '$selected_reason',
      'Documents': imageUrls,
      'PolicyNumber': pnum,
      'UPI_ID': upi
    })
        .then((value) {
      newid = value.id;
      print("Claim Details Added $newid");
    })
        .catchError((error) => print("Failed to add claim details: $error"));
    //     .then((value) {
    //   Get.snackbar('Success', 'Data is stored successfully');
    // });
    await databaseReference.collection('User_Requests')
        .where('RequestID', isEqualTo: '$reqid')
        .get()
        .then((value) => value.docs.forEach((doc) {
      doc.reference.update({'Status' : 'Necessary details collected'});
    })).catchError((error) => print('Status not updated: $error'));

    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTp(curr_docid: newid,reqid: reqid)));
  }

  storeDeathandRiderEntry(List<String> imageUrls, String pnum, String pannum, String aadharnum,String upi) async{
    await FirebaseFirestore.instance
        .collection('Employee_Clients')
        .add({
      'Category' : '$catg',
      'Option' : '$opt',
      'RequestID' : '$reqid',
      'UserID' : '$userid',
      'EmployeeID' :  user?.uid,
      'ReasonOfClaim' : '$selected_reason',
      'Documents': imageUrls,
      'PolicyNumber': pnum,
      'NomineePanNumber' : pannum,
      'NomineeAadharNumber' : aadharnum,
      'NomineeUPI_ID': upi
    })
        .then((value) {
      newid = value.id;
      print("Claim Details Added $newid");
    })
        .catchError((error) => print("Failed to add claim details: $error"));
    //     .then((value) {
    //   Get.snackbar('Success', 'Data is stored successfully');
    // });
    await databaseReference.collection('User_Requests')
        .where('RequestID', isEqualTo: '$reqid')
        .get()
        .then((value) => value.docs.forEach((doc) {
      doc.reference.update({'Status' : 'Necessary details collected'});
    })).catchError((error) => print('Status not updated: $error'));

    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTp(curr_docid: newid,reqid: reqid)));
  }
}
