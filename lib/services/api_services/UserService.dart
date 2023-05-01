import 'dart:convert';

import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'APIConstants.dart';

class UserService {

  final _userService = Get.put(UserDataStorage());
  final _header = {
    "Content-Type": "application/json",
  };

  Future<dynamic> registerUser(String otp, Map<String, String> requestBody) async{
    var url = Uri.parse("$baseUrl$registerEndpoint?otp=$otp");

    var body = jsonEncode(requestBody);
    var response = await http.post(url, headers: _header, body: body);
    var decodedResponse = jsonDecode(response.body);
    // print(decodedResponse);
    if(decodedResponse["statusCode"] == 200) {
      return decodedResponse["httpStatus"];
    }
    return decodedResponse["body"]["msg"];
  }

  Future<dynamic> generateOtp(String email) async {
    var url = Uri.parse("$baseUrl$generateOtpEndpoint?email=$email");

    var response = await http.post(url, headers: _header);
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['statusCode'] == 200) {
      return decodedResponse["body"]["OTP"];
    }
  }

  Future<dynamic> login(String email, String otp) async {
    var url = Uri.parse("$baseUrl$loginEndpoint?email=$email&otp=$otp");
    var response = await http.post(url, headers: _header);
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse['statusCode'] == 200) {
      print(decodedResponse["body"]["id"]);
      _userService.saveUserData(
          decodedResponse["body"]["name"],
          decodedResponse["body"]["email"],
          decodedResponse["body"]["phone"],
          "",
          decodedResponse["body"]["id"].toString());

      return decodedResponse["httpStatus"];
    }
    return "error Occurred";
  }
}
