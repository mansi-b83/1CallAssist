import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class apiServiceGetPremium {
  var PremiumAmount = 0;
  static const String apiURL =
      "mocki.io/v1/4522027d-9411-45e8-b8e3-aae650b66616";

  Future<String> getSuggesstedPremium(requestID) async {
    var url =
        Uri.parse("http://10.0.2.2:5000/get_details/$requestID");
        // Uri.parse("http://127.0.0.1:5000/get_details/$requestID");
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
