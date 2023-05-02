import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/ai_services/ai_helper.dart';
import 'package:cvmaker_app_sarah_proj/services/api_services/forms_service.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:cvmaker_app_sarah_proj/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsForm extends StatefulWidget {
  const SkillsForm({Key? key}) : super(key: key);

  @override
  State<SkillsForm> createState() => _SkillsFormState();
}

class _SkillsFormState extends State<SkillsForm> {
  final _skillsFormKey = GlobalKey<FormState>();
  final _skillsController = TextEditingController();
  final _generatedSkillsController = TextEditingController();
  final _generatedDataStorageController = Get.put(FormDataLocalStorage());
  final _userService = Get.put(UserDataStorage());

  var _generatedSkills;

  bool generatingContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedSkills = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "Skills Summary",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _skillsFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _skillsController,
                  hintText: "Write something about your skills",
                  maxLines: 5,
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Skill is required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                generatingContent
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        btnLabel: _generatedSkills.toString().isEmpty
                            ? "SAVE"
                            : "REGENERATE",
                        onPressed: () async {
                          if (_skillsFormKey.currentState!.validate()) {
                            _generatedSkills = "";
                            generatingContent = true;
                            setState(() {});
                            _generatedSkills = await AiHelper().generate(
                                _skillsController.value.text, "skills");
                            _generatedSkillsController.text = _generatedSkills;
                            generatingContent = false;
                            setState(() {});
                          }
                        },
                      ),
                /**
             *    BELOW LINES OF CODE WILL ONLY VISIBLE IN APP WHEN WE GET AN RESPONSE FROM CHATGPT API
             *    AND THEN STORE IT IN _generatedSkills
             */
                const SizedBox(height: 30),
                _generatedSkills.toString().isNotEmpty
                    ? TextFormField(
                        controller: _generatedSkillsController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20),
                _generatedSkills.toString().isNotEmpty
                    ? CustomButton(
                        btnLabel: "SAVE",
                        onPressed: () async {
                          Map<String, String> skills = {
                            "userGivenString": _skillsController.text,
                            "aiGeneratedText":
                                _generatedSkillsController.text.trim()
                          };
                          var resp = await FormsService()
                              .addSkills(_userService.retrieveId(), skills);

                          _generatedDataStorageController.saveSkills(
                              _generatedSkillsController.text.trim(),
                              resp["body"]["data"]["profileId"].toString());
                          resp["statusCode"] == 201
                              ? ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Data Saved',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                    backgroundColor: Colors.green,
                                  ),
                                )
                              : ToastMsg().errorToast("Something went wrong");
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
