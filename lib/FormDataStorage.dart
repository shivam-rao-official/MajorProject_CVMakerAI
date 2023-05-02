import 'package:get/get.dart';

class FormDataLocalStorage extends GetxController {
  var skills = "".obs;
  var skillsId="".obs;
  var header = "".obs;
  var headerId="".obs;
  var education = "".obs;
  var educationId="".obs;
  var hobbies = "".obs;
  var hobbiesId="".obs;
  var workExp = "".obs;
  var workExpId="".obs;
  var language = "".obs;
  var languageId="".obs;
  var profile = "".obs;
  var profileId="".obs;
  var userName = "".obs;


  void saveSkills(String skills, String id) {
    this.skills.value = skills;
    skillsId.value = id;
  }

  String retrieveSkills() {
    if (skills.isEmpty) return "No Skills Added";
    return skills.value;
  }
  void saveHeader(String header, String username) {
    this.header.value = header;
    userName.value = username;
  }

  String retrieveHeader() {
    if (header.isEmpty) return "No Headers Added";
    return header.value;
  }
  void saveEducation(String education, String id) {
    this.education.value = education;
    educationId.value = id;
  }

  String retrieveEducation() {
    if (education.isEmpty) return "No Education Added";
    return education.value;
  }
  void saveHobbies(String hobby, String id) {
    hobbies.value = hobby;
    hobbiesId.value = id;
  }

  String retrieveHobbies() {
    if (hobbies.isEmpty) return "No Hobbies Added";
    return hobbies.value;
  }
  void saveLanguage(String language, String id) {
    this.language.value = language;
    languageId.value = id;
  }

  String retrieveLanguage() {
    if (language.isEmpty) return "No Language Added";
    return language.value;
  }

  void saveWorkExp(String workExp, String id) {
    this.workExp.value = workExp;
    workExpId.value = id;
  }

  String retrieveWorkExp() {
    if (workExp.isEmpty) return "No Work Experience Added";
    return workExp.value;
  }

  void saveProfile(String profile, String id) {
    this.profile.value = profile;
    profileId.value = id;
  }

  String retrieveProfile() {
    if (profile.isEmpty) return "No Objective created";
    return profile.value;
  }

  Map<String, String> retrieveId(){
    return {
      "skillsId": skillsId.value,
      "profileId": profileId.value,
      "educationId": educationId.value,
      "workExpId": workExpId.value,
      "hobbiesId": hobbiesId.value,
      "languageId": languageId.value
    };
  }
}