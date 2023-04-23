import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDataLocalStorage extends GetxController {
  var skills = "".obs;
  var header = "".obs;
  var education = "".obs;
  var hobbies = "".obs;
  var workExp = "".obs;

  void saveSkills(String skills) {
    this.skills.value = skills;
  }

  String retrieveSkills() {
    if (skills.isEmpty) return "No Skills Added";
    return skills.value;
  }
  void saveHeader(String header) {
    this.header.value = header;
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

  void saveWorkExp(String workExp) {
    this.workExp.value = workExp;
  }

  String retrieveWorkExp() {
    if (workExp.isEmpty) return "No Work Experience Added";
    return workExp.value;
  }
}