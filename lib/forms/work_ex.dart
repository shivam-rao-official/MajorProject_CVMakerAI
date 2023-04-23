import 'package:cvmaker_app_sarah_proj/services/ai_services/ai_helper.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkExperienceForm extends StatefulWidget {
  const WorkExperienceForm({Key? key}) : super(key: key);

  @override
  State<WorkExperienceForm> createState() => _WorkExperienceFormState();
}

class _WorkExperienceFormState extends State<WorkExperienceForm> {
  final _workExpFormKey = GlobalKey<FormState>();
  final _workExpController = TextEditingController();

  var _generatedWorkExp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedWorkExp = "";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "Work Experience Summary",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _workExpFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _workExpController,
                  hintText:
                      "Write a brief about your past work experience. "
                          "If you are fresher you can add your Internships and projects you work on....",
                  maxLines: 10,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Work Experience is not mandatory.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  btnLabel: "SAVE",
                  onPressed: () async {
                    _generatedWorkExp = "";
                    setState(() {});
                    if (_workExpFormKey.currentState!.validate()) {
                      _generatedWorkExp = await AiHelper()
                          .generate(_workExpController.value.text, "work experience");
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      _prefs.setString("education", _generatedWorkExp);
                      setState(() {});
                    }
                  },
                ),
                /**
                 *    BELOW LINES OF CODE WILL ONLY VISIBLE IN APP WHEN WE GET AN RESPONSE FROM CHATGPT API
                 *    AND THEN STORE IT IN _generatedWrokExp
                 */
                const SizedBox(height: 30),
                _generatedWorkExp.toString().isNotEmpty
                    ? TextFormField(
                  initialValue: _generatedWorkExp.toString().trim(),
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                )
                    : Container(),
                const SizedBox(height: 20),
                _generatedWorkExp.toString().isNotEmpty
                    ? CustomButton(
                  btnLabel: "SAVE",
                  onPressed: () {},
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
