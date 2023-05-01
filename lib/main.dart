import 'package:cvmaker_app_sarah_proj/forms/education.dart';
import 'package:cvmaker_app_sarah_proj/forms/hobbies.dart';
import 'package:cvmaker_app_sarah_proj/forms/languages.dart';
import 'package:cvmaker_app_sarah_proj/forms/personal_details.dart';
import 'package:cvmaker_app_sarah_proj/forms/profile.dart';
import 'package:cvmaker_app_sarah_proj/forms/skills.dart';
import 'package:cvmaker_app_sarah_proj/forms/work_ex.dart';
import 'package:cvmaker_app_sarah_proj/screens/generate_cv.dart';
import 'package:cvmaker_app_sarah_proj/screens/home.dart';
import 'package:cvmaker_app_sarah_proj/screens/login.dart';
import 'package:cvmaker_app_sarah_proj/screens/register.dart';
import 'package:cvmaker_app_sarah_proj/screens/view_cv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'UserDataStorage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _userService = Get.put(UserDataStorage());
  var id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = _userService.retrieveId();
    print(id);
  }
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      routes: {
        "/login": (context) => const LoginScreen(),
        "/home": (context) => const HomeScreen(),
        "/register": (context) => const RegisterScreen(),
        "/form-personalDetail": (context) => const PersonalDetailsForm(),
        "/form-educationSummary": (context) => const EducationForm(),
        "/form-workExperienceForm": (context) => const WorkExperienceForm(),
        "/form-skillsForm": (context) => const SkillsForm(),
        "/form-hobbiesForm": (context) => const HobbiesForm(),
        "/form-languageForm": (context) => const LanguageForm(),
        "/form-generateObjective": (context) => const ProfileForm(),
        "/generateCvScreen": (context) => const GenerateCVScreen(),
         },
      home: _userService.retrieveId().isEmpty ? const RegisterScreen(): const HomeScreen(),
    );
  }
}
