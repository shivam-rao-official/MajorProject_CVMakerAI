import 'dart:convert';

import 'package:cvmaker_app_sarah_proj/services/api_services/APIConstants.dart';
import 'package:http/http.dart' as http;
class FormsService {

  final _header = {
    "Content-Type": "application/json",
  };

  Future<dynamic> addProfile(String userId, Map<String, dynamic> reqBody) async{

    var url = Uri.parse("$baseUrl$addProfileEndpoint?userId=$userId");

    var body = jsonEncode(reqBody);
    var resp = await http.post(url, headers: _header, body: body);
    var decodedResp = jsonDecode(resp.body);
    return decodedResp;
  }

  Future<dynamic> addEducation(
      String userId, Map<String, dynamic> reqBody) async {
    
    var url = Uri.parse("$baseUrl$addEducationEndpoint?userId=$userId");

    var body = jsonEncode(reqBody);
    var resp = await http.post(url, headers: _header, body: body);
    var decodedResp = jsonDecode(resp.body);
    return decodedResp;
  }

  Future<dynamic> addSkills(
      String userId, Map<String, dynamic> reqBody) async {
    var url = Uri.parse("$baseUrl$addSkillsEndpoint?userId=$userId");

    var body = jsonEncode(reqBody);
    var resp = await http.post(url, headers: _header, body: body);
    var decodedResp = jsonDecode(resp.body);
    return decodedResp;
  }

  Future<dynamic> addWorkExp(
      String userId, Map<String, dynamic> reqBody) async {
    var url = Uri.parse("$baseUrl$addWorkExpEndpoint?userId=$userId");

    var body = jsonEncode(reqBody);
    var resp = await http.post(url, headers: _header, body: body);
    var decodedResp = jsonDecode(resp.body);
    print(decodedResp["statusCode"]);
    return decodedResp;
  }

  Future<dynamic> addHobbies(
      String userId, Map<String, dynamic> reqBody) async {
    var url = Uri.parse("$baseUrl$addHobbiesEndpoint?userId=$userId");

    var body = jsonEncode(reqBody);
    var resp = await http.post(url, headers: _header, body: body);
    var decodedResp = jsonDecode(resp.body);
    print(decodedResp["statusCode"]);
    return decodedResp;
  }

  Future<dynamic> addLanguage(
      String userId, Map<String, dynamic> reqBody) async {
    var url = Uri.parse("$baseUrl$addLanguageEndpoint?userId=$userId");

    var body = jsonEncode(reqBody);
    var resp = await http.post(url, headers: _header, body: body);
    var decodedResp = jsonDecode(resp.body);
    print(decodedResp["statusCode"]);
    return decodedResp;
  }

  fetchCv(int cvId) async{
    var url = Uri.parse("$baseUrl$fetchCV?cvId=$cvId");

    var resp = await http.get(url, headers: _header);
    var decodedResp = jsonDecode(resp.body);
    print(decodedResp);
    return decodedResp;
  }
}