import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/select_tp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MultiFileUplaodScreen extends StatefulWidget {
  final String? userid;
  final String? category;
  final String? option;
  final String? requestid;
  const MultiFileUplaodScreen({Key? key,@required this.userid,@required this.category,@required this.option,@required this.requestid}) : super(key: key);


  @override
  _MultiFileUplaodScreenState createState() => _MultiFileUplaodScreenState();
}

class _MultiFileUplaodScreenState extends State<MultiFileUplaodScreen> {
  List<File> images = [];
  String? catg;
  String? opt;
  String? reqid;
  String? userid;
  String? newid;
  TextEditingController policynumController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    catg = widget.category;
    opt = widget.option;
    reqid = widget.requestid;
    userid = widget.userid;
    return Scaffold(
      appBar: AppBar(
        title: Text("Claim Insurance"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                getMultipImage();
              },
              child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Icon(
                      Icons.upload_file,
                      size: 50,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              height: 150,
              child: images.length == 0
                  ? Center(
                child: Text("No Images found"),
              )
                  : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 10),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.file(
                        images[i],
                        fit: BoxFit.cover,
                      ));
                },
                itemCount: images.length,
              ),
            ),
            const SizedBox(
              height: 50,
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
                      storeEntry(downloadUrls, policynumController.text,upiController.text);
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
      ),
    );
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

  storeEntry(List<String> imageUrls, String pnum, String upi) async{
    await FirebaseFirestore.instance
        .collection('Employee_Clients')
        .add({
      'Category' : '$catg',
      'Option' : '$opt',
      'RequestID' : '$reqid',
      'UserID' : '$userid',
      'EmployeeID' :  user?.uid,
      'Documents': imageUrls,
      'PolicyNumber': pnum,
      'UPI_ID': upi
        })
        .then((value) {
      newid = value.id;
      print("Renew Details Added $newid");
    })
        .catchError((error) => print("Failed to add renew details: $error"));
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