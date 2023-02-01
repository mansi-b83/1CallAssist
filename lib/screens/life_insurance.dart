import 'package:flutter/material.dart';

class LifeInsurance extends StatefulWidget {
  const LifeInsurance({Key? key}) : super(key: key);

  @override
  State<LifeInsurance> createState() => _LifeInsuranceState();
}

class _LifeInsuranceState extends State<LifeInsurance> {
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
      body: Container(
        child: Center(
          child: Text(
            'Life Insurance Page',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
