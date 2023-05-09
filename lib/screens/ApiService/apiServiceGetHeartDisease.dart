import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class apiServiceGetHeartDisease {
  var PremiumAmount = 0;


  Future<String> getHeartDiseaseInfo(requestID) async {
    var url =
    Uri.parse("http://10.0.2.2:5000/get_details_heart/$requestID");
    // print(url);
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("response");
      return response.body.toString();
    } else {
      print("else object");
      return "0";
    }
  }
}
