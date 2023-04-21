import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Payment_Integrate extends StatefulWidget {
  final String req_id;
  final String quotationURL;
  const Payment_Integrate({Key? key,required this.req_id,required this.quotationURL}) : super(key: key);

  @override
  State<Payment_Integrate> createState() => _Payment_IntegrateState();
}

class _Payment_IntegrateState extends State<Payment_Integrate> {
  var _razorpay = Razorpay();
  TextEditingController amountController = TextEditingController();
  final databaseReference = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  String? requestid;
  String? policynum;
  String? quoteurl;

  @override
  void initState(){
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    requestid = widget.req_id;
    quoteurl = widget.quotationURL;
    // Do something when payment succeeds
    print('Payment Successfully Done');
    const available_chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    var _rnd = Random();
    // final reqid_list = [];
    policynum = List.generate(6, (index) => available_chars[_rnd.nextInt(available_chars.length)]).join();
    await databaseReference
        .collection('Employee_Clients')
        .where('RequestID' , isEqualTo: '$requestid')
        .get()
        .then((value) => value.docs.forEach((doc) {
      doc.reference.update({'QuotationPurchased' : 'Yes'});
    })).catchError((error) => print('Purchase status not updated: $error'));
    
    await databaseReference
    .collection('Purchased_Quotations')
    .add({
      'UserID' : user?.uid,
      'RequestID' : '$requestid',
      'PolicyNumber' : '$policynum',
      'QuotationURL' : '$quoteurl',
    })
        .then((value) => print("Quote purchase details Added"))
        .catchError((error) => print("Failed to add quote purchase details: $error"));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('Payment Failed');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
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
        // title: Text(
        //   'Select Companies',
        // ),
        // actions: [
        //   IconButton(
        //       onPressed: (){
        //         signOut();
        //       },
        //       icon: Icon(Icons.logout_outlined))
        // ],
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'Contact Number',
                    hintText: 'Enter Amount',
                  ),

                  // onChanged: (value){
                  //   setState(() {
                  //     age = int.parse(value);
                  //     print(age);
                  //   });
                  // }
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 15.0,top: 30.0,bottom: 15.0,right: 15.0),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  onPressed: () {
                    var options = {
                      'key': 'rzp_test_Q5sQi7iwtRT7zw',
                      'amount': (int.parse(amountController.text) * 100).toString(), //in the smallest currency sub-unit.
                      // 'name': 'Freya Mehta',
                      'description': 'Insurance Buy',
                      'timeout': 300, // in seconds
                      // 'prefill': {
                      //   'contact': '7676443211',
                      //   'email': 'freyamehta@gmail.com'
                      // }
                    };
                    _razorpay.open(options);
                  },
                  child: Text(
                    'Pay',
                  )
              ),
            // )
          ],
        ),
      ),
    );

  }
  @override
  void dispose(){
    _razorpay.clear();
    super.dispose();

  }
}


