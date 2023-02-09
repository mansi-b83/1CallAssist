import 'package:flutter/material.dart';

class healthRenewForm extends StatefulWidget {
  const healthRenewForm({Key? key}) : super(key: key);

  @override
  State<healthRenewForm> createState() => _healthRenewFormState();
}

class _healthRenewFormState extends State<healthRenewForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController healthupdate_contr = TextEditingController();
  TextEditingController prevmedichist_contr = TextEditingController();

  String? policynum;
  String? insurername;
  String? port;
  String? newpolicy;
  String? health_update;
  String? prevmedic_hist;
  int? healthupd_flag;
  int? prevmedic_flag;
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
        backgroundColor: Colors.orangeAccent,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),

          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(padding: EdgeInsets.only(top:30.0,bottom: 10.0,left: 10.0,right:10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Contact Number',
                      hintText: 'Existing Policy Number',
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return " Policy Number is required";
                      }
                    },
                    onSaved: (value){
                      policynum = value!;
                    },
                  ),
                ),

                Padding(padding: EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Contact Number',
                      hintText: 'Existing Insurer Name',
                    ),
                    validator: (value) {
                      if(value!.isEmpty){
                        return " Insurer Name is required";
                      }
                    },
                    onSaved: (value){
                      insurername = value!;
                    },
                  ),
                ),

                Padding(padding: EdgeInsets.all(10),
                  child: Text(
                    'Do ypu want to port??',
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
                          groupValue: port,
                          onChanged: (String? portval) {
                            setState(() {
                              port = portval!;
                              print(port);
                              // _showdiseasenametxtbox = true;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          title: Text(" No"),
                          value: "no",
                          groupValue: port,
                          onChanged: (String? portval){
                            setState(() {
                              port = portval!;
                              print(port);
                              // _showdiseasenametxtbox = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.all(10),
                  child: Text(
                    'Do ypu want New Policy?',
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
                          groupValue: newpolicy,
                          onChanged: (String? newpolicy_val) {
                            setState(() {
                              newpolicy = newpolicy_val!;
                              print(newpolicy);
                              // _showdiseasenametxtbox = true;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          title: Text(" No"),
                          value: "no",
                          groupValue: newpolicy,
                          onChanged: (String? newpolicy_val){
                            setState(() {
                              newpolicy = newpolicy_val!;
                              print(newpolicy);
                              // _showdiseasenametxtbox = false;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),

                Padding(padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: healthupdate_contr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Contact Number',
                      hintText: 'Enter Health Updates(if any)',
                    ),
                    validator: (healthupdate_contr) {
                      healthupd_flag =0;
                      if(healthupdate_contr!.isEmpty){
                        healthupd_flag =1;
                        // health_update = 'None';
                        // print('health_update');
                      }
                    },
                    onSaved: (healthupdate_contr){
                      if(healthupd_flag ==1){
                        health_update = 'None';
                      }
                      else{
                        health_update = healthupdate_contr!;
                      }
                      // health_update = value!;
                      // print(health_update);
                    },
                  ),
                ),

                Padding(padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: prevmedichist_contr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // labelText: 'Contact Number',
                      hintText: 'Previous medical history(if any)',
                    ),
                    validator: (prevmedichist_contr) {
                      prevmedic_flag =0;
                      if(prevmedichist_contr!.isEmpty){
                        prevmedic_flag =1;
                        // health_update = 'None';
                        // print('health_update');
                      }
                    },
                    onSaved: (prevmedichist_contr){
                      if(prevmedic_flag ==1){
                        prevmedic_hist = 'None';
                      }
                      else{
                        prevmedic_hist = prevmedichist_contr!;
                      }
                      // health_update = value!;
                      // print(health_update);
                    },
                  ),
                ),


                Center(
                  child: Padding(padding: EdgeInsets.only(left: 0.0,right: 0.0,top: 100.0,bottom: 0.0),
                    child: GestureDetector(
                      child: Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Create PDF',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        print("button pressed");
                        final form = _formKey.currentState;
                        if (form != null && !form.validate()){
                          return;
                        }
                        else{
                          form?.save();
                          _sendRenewPolicyInfo(context);
                          // addUserRequest();
                        }
                        // form?.save();

                      },
                    ),
                  ),
                ),
              ],
            )
          ),
        ),
      )
    );
  }

  void _sendRenewPolicyInfo(BuildContext context){
    print(policynum);
    print(insurername);
    print(port);
    print(newpolicy);
    print(health_update);
    print(prevmedic_hist);
  }
}
