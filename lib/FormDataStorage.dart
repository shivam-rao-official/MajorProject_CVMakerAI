import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDataLocalStorage extends GetxController {
  var skills = "".obs;
  var skillArr = [].obs;
  var header = "".obs;
  var education = "".obs;
  var hobbies = "".obs;
  var workExp = "".obs;
  var language = "".obs;
  var profile = "".obs;
  var userName = "".obs;


  void saveSkills(String skills) {
    this.skills.value = skills;
    // skills = skills.trim();
    // List<String> lines = skills.split("\n");
    // for(String line in lines) {
    //   List<String> part = line[]
    // }
    // print(skillArr.value);
  }

  String retrieveSkills() {
    if (skills.isEmpty) return "No Skills Added";
    return skills.value;
    // if (skillArr.isEmpty) return "No Skills Added";
    // return skillArr.value;
  }
  void saveHeader(String header, String usrname) {
    this.header.value = header;
    userName.value = usrname;
  }

  String retrieveHeader() {
    if (header.isEmpty) return "No Headers Added";
    return header.value;
  }
  void saveEducation(String education) {
    this.education.value = education;
  }

  String retrieveEducation() {
    if (education.isEmpty) return "No Education Added";
    return education.value;
  }
  void saveHobbies(String hobby) {
    hobbies.value = hobby;
  }

  String retrieveHobbies() {
    if (hobbies.isEmpty) return "No Hobbies Added";
    return hobbies.value;
  }
  void saveLanguage(String language) {
    this.language.value = language;
  }

  String retrieveLanguage() {
    if (language.isEmpty) return "No Language Added";
    return language.value;
  }

  void saveWorkExp(String workExp) {
    this.workExp.value = workExp;
  }

  String retrieveWorkExp() {
    if (workExp.isEmpty) return "No Work Experience Added";
    return workExp.value;
  }

  void saveProfile(String profile) {
    this.profile.value = profile;
  }

  String retrieveProfile() {
    if (profile.isEmpty) return "No Objective created";
    return profile.value;
  }
}