import 'dart:convert';

import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/api_services/APIConstants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CVService {
  var userService = Get.put(UserDataStorage());
  final _header = {
    "Content-Type": "application/json",
  };

  Future<dynamic> fetchCV() async{
    var url = Uri.parse("$baseUrl$fetchAllCv?userId=${userService.retrieveId()}");

    var resp = await http.get(url, headers: _header);
    var decodedResp = jsonDecode(resp.body);
    return decodedResp["body"]["data"];
  }
}