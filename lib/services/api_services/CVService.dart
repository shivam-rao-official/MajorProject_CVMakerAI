import 'dart:convert';

import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/api_services/APIConstants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CVService {
  var userService = Get.put(UserDataStorage());
  var formDataStorage = Get.put(FormDataLocalStorage());
  final _header = {
    "Content-Type": "application/json",
  };

  Future<dynamic> fetchCV() async{
    var url = Uri.parse("$baseUrl$fetchAllCv?userId=${userService.retrieveId()}");

    var resp = await http.get(url, headers: _header);
    var decodedResp = jsonDecode(resp.body);
    return decodedResp["body"]["data"];
  }

  Future<dynamic> saveCV(String fileName) async{
    var url = Uri.parse("$baseUrl$saveCv?userId=${userService.retrieveId()}");
    var req = formDataStorage.retrieveId();
    req["cvName"] = fileName;
    var body = jsonEncode(req);
    var resp = await http.post(url, headers: _header,body: body);
    var decodedResp = jsonDecode(resp.body);
    print(decodedResp.toString());
    return decodedResp;
  }

}