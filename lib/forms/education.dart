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

class EducationForm extends StatefulWidget {
  const EducationForm({Key? key}) : super(key: key);

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final _educationSummaryFormKey = GlobalKey<FormState>();
  final _educationSummaryController = TextEditingController();
  final _generatedDataStorageController = Get.put(FormDataLocalStorage());
  final _generatedEducationController = TextEditingController();
  final _userService = Get.put(UserDataStorage());

  var _generatedEducation;
  bool generatingContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedEducation = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "Education Summary Form",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _educationSummaryFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _educationSummaryController,
                  hintText: "Write a brief about your education summary...",
                  maxLines: 10,
                  validator: (val) {
                    if (val == null || val.isEmpty)
                      return "Education Summary is required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                generatingContent
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        btnLabel: _generatedEducation.toString().isEmpty
                            ? "SAVE"
                            : "REGENERATE",
                        onPressed: () async {
                          if (_educationSummaryFormKey.currentState!
                              .validate()) {
                            _generatedEducation = "";
                            generatingContent = true;
                            setState(() {});
                            _generatedEducation = await AiHelper().generate(
                                _educationSummaryController.value.text,
                                "education");
                            _generatedEducationController.text =
                                _generatedEducation;
                            generatingContent = false;
                            setState(() {});
                          }
                        },
                      ),
                /**
                 *    BELOW LINES OF CODE WILL ONLY VISIBLE IN APP WHEN WE GET AN RESPONSE FROM CHATGPT API
                 *    AND THEN STORE IT IN _generatedWrokExp
                 */
                const SizedBox(height: 30),
                _generatedEducation.toString().isNotEmpty
                    ? TextFormField(
                        controller: _generatedEducationController,
                        maxLines: 10,
                        onSaved: (val) {
                          _generatedEducationController.text = val!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20),
                _generatedEducation.toString().isNotEmpty
                    ? CustomButton(
                        btnLabel: "SAVE",
                        onPressed: () async {
                          Map<String, String> education = {
                            "userGivenString": _educationSummaryController.text,
                            "aiGeneratedText":
                                _generatedEducationController.text.trim()
                          };
                          var resp = await FormsService().addEducation(
                              _userService.retrieveId(), education);
                          _generatedDataStorageController.saveEducation(
                              _generatedEducationController.text.trim(),
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
