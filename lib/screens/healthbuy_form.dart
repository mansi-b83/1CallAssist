import 'package:flutter/material.dart';

// void main() async {
//   // WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(const healthbuyForm());
// }
class healthbuyForm extends StatefulWidget {
  const healthbuyForm({Key? key}) : super(key: key);

  @override
  State<healthbuyForm> createState() => _healthbuyFormState();
}

class _healthbuyFormState extends State<healthbuyForm> {
  String? smoke;
  String? tobacco;
  String instype = 'Individual';
  int? flag = 0;
  // int? noofmembers;
  String? disease;
  bool _showTextField = false;
  bool _showdiseasenametxtbox = false;
  // final List<FamControllers> famdetailsControllers = List<FamControllers>();
  var types = [
    'Family',
    'Individual'
  ];
  TextEditingController numofmem_contr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
          // padding: EdgeInsets.only(top: 40.0),

          child: Form(
            key: _formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Padding(padding: EdgeInsets.only(left: 15.0,top: 30.0,bottom: 15.0,right: 15.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: 'Contact Number',
                        hintText: 'Enter Age',
                      ),

                    ),
                  ),

                  Padding(padding: EdgeInsets.all(10),
                    child: Text(
                      'Do you smoke?',
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
                    child: Text(
                      'Do you consume Tobacco?',
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
                            child: Padding(padding: EdgeInsets.only(left: 15.0),
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
                      children: [
                        Flexible(
                            child:  Padding(padding: EdgeInsets.only(right: 15.0),
                              child: TextFormField(
                                  controller: numofmem_contr,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    // labelText: 'Contact Number',
                                    hintText: 'Number of members',
                                  ),
                                  keyboardType: TextInputType.number,
                                  // onChanged: (String? val){
                                  //   setState(() {
                                  //     String _numofmemS = val!;
                                  //     int _numofmem = int.parse(_numofmemS);
                                  //     print(_numofmem);
                                      // if(_numofmem >= 1){
                                      //   print('hey $_numofmem');
                                      //   _showfamdetailstxtbox = true;
                                      // }
                                      // else{
                                      //   _showfamdetailstxtbox = false;
                                      // }
                                    // });
                                // validator: (value) {
                                //   String _numofmemS = value!;
                                //   int _numofmem = int.parse(_numofmemS);
                                //   print(_numofmem);
                                //   if(_numofmem >= 1){
                                //     print('hey $_numofmem');
                                //     _showfamdetailstxtbox = true;
                                //   }
                                //   else{
                                //     _showfamdetailstxtbox = false;
                                //   }
                                //
                                // if(_numofmem >= 1){
                                //   for(int i =0 ; i<_numofmem; i++){
                                //     print('hey');
                                //     Padding(padding: EdgeInsets.all(10),
                                //       child: TextFormField(
                                //         controller: numofmem_contr,
                                //         decoration: InputDecoration(
                                //           border: OutlineInputBorder(),
                                //           // labelText: 'Contact Number',
                                //           hintText: 'Number of members',
                                //         ),
                                //       ),
                                //     );
                                //   }
                                // }
                                //   onChanged: (numofmem_contr){
                                //     int numofmem = int.parse(numofmem_contr.text);
                                //   },
                                // onSaved: (value){
                                //   String _noofmem = value!;
                                //   int m = int.parse(_noofmem);
                                //   noofmembers = m!;
                                //   print(noofmembers);
                                // },
                              ),
                            ),
                        ),
                        Flexible(
                            child: ElevatedButton(
                            child: Text('Add entries'),
                              onPressed: () async {
                                List<FamDetailsEntry> persons = await Navigator.push(context, MaterialPageRoute(builder: (context) => _famDetails()));
                                if (persons != null) persons.forEach(print);
                              },
                            ),
                        ),
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
                          // _sendFinalUserinfo(context);
                          // addUserRequest();
                        }
                        // form?.save();

                      },
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _famDetails extends StatefulWidget {
  const _famDetails({Key? key}) : super(key: key);

  @override
  State<_famDetails> createState() => _famDetailsState();
}

class _famDetailsState extends State<_famDetails> {
  var fam_relation = <TextEditingController>[];
  var fam_age = <TextEditingController>[];
  var cards = <Card>[];

  Card createCard(){
    var famrelationController = TextEditingController();
    var fammem_ageController = TextEditingController();
    fam_relation.add(famrelationController);
    fam_age.add(fammem_ageController);
    return Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Text('Pe ${cards.length + 1}'),
          TextField(
            controller: famrelationController,
            decoration: InputDecoration(labelText: 'Realtionship')),
          TextField(
            controller: fammem_ageController,
            decoration: InputDecoration(labelText: 'Age')),
        ],
        ),
    );
  }
  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }
  _onDone() {
    List<FamDetailsEntry> entries = [];
    for (int i = 0; i < cards.length; i++) {
      var fammem_rel = fam_relation[i].text;
      var fammem_age = fam_age[i].text;
      entries.add(FamDetailsEntry(fammem_rel, fammem_age));
    }
    Navigator.pop(context, entries);
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
        backgroundColor: Colors.orangeAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cards.length,
              itemBuilder: (BuildContext context, int index) {
                return cards[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('add new'),
              onPressed: () => setState(() => cards.add(createCard())),
            ),
          )
        ],
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.done), onPressed: _onDone),
    );
  }
}



class FamDetailsEntry {
  final String relation;
  final String age;

  FamDetailsEntry(this.relation, this.age);
  @override
  String toString() {
    return 'Person: relation= $relation, age= $age';
  }
}