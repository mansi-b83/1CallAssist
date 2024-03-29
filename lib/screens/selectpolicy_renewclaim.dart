
import 'package:demo/screens/contact_details.dart';
import 'package:demo/screens/policynumlist.dart';
import 'package:demo/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RenewClaimPolicy extends StatefulWidget {
  final String? catg;
  final String? opt;
  const RenewClaimPolicy({Key? key, @required this.catg, @required this.opt}) : super(key: key);

  @override
  State<RenewClaimPolicy> createState() => _RenewClaimPolicyState();
}

class _RenewClaimPolicyState extends State<RenewClaimPolicy> {
  final User? user = FirebaseAuth.instance.currentUser;
  final databaseReference = FirebaseFirestore.instance;
  List _policynumList = [];
  String? chosencategory;
  String? chosenoption;

  @override
  void didChangeDependencies(){
    getPolicyNum();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    chosencategory = widget.catg;
    chosenoption = widget.opt;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: createPolicyNumCards(_policynumList),
    );
  }
  Future getPolicyNum() async{
    print('Hello');
    var data = await databaseReference
        .collection('Purchased_Quotations')
        .where("UserID", isEqualTo: '${user?.uid}')
    // .orderBy('Date', descending: false)
        .get();

    setState(() {
      _policynumList = List.from(data.docs.map((doc) => PolicyNum.fromSnapshot(doc)));
      // print(requestid);
      // print(_requestList);
    });
  }

  Widget createPolicyNumCards(List PolicyNumList){
    List<Widget> list = <Widget>[];
    if(PolicyNumList.length > 0){
      for(int i = 0; i < PolicyNumList.length; i++){
        if(chosenoption == 'renew'){
          list.add(
            Container(
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Policy Number: ${PolicyNumList[i].policynum}",
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  child: Text('Renew'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                                  ),
                                  onPressed: (){
                                    print('Renew button pressed ${PolicyNumList[i].userid}');
                                    String pnum = PolicyNumList[i].policynum;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetail(finalcatg: chosencategory, finalopt: chosenoption, policynum: pnum)));
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    )

                ),
              ),
            ),
          );
        }
        else if(chosenoption == 'claim'){
          list.add(
            Container(
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Policy Number: ${PolicyNumList[i].policynum}",
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(padding: EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  child: Text('Claim'),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.orangeAccent)
                                  ),
                                  onPressed: (){
                                    print('Claim button pressed ${PolicyNumList[i].userid}');
                                    print('Policy Number ${PolicyNumList[i].policynum}');
                                    String pnum = PolicyNumList[i].policynum;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactDetail(finalcatg: chosencategory, finalopt: chosenoption, policynum: pnum)));
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPDF(pathPDF: quotationList[i].quotation_url)));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),

                    )

                ),
              ),
            ),
          );
        }
      }
    }
    else{
      return Center(
        child: Text(
          'No policies purchased',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return ListView(children: list);
  }

  void signOut() async{
    final FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
