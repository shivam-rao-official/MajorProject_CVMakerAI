import 'package:cvmaker_app_sarah_proj/services/ai_services/ai_helper.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({Key? key}) : super(key: key);

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {

  final _educationSummaryFormKey = GlobalKey<FormState>();
  final _educationSummaryController = TextEditingController();


  var _generatedEducation;

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
                  maxLines: 30,
                  validator: (val) {
                    if(val == null || val.isEmpty) return "Education Summary is required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  btnLabel: "SAVE",
                  onPressed: () async{
                    _generatedEducation = "";
                    setState(() {});
                    if (_educationSummaryFormKey.currentState!.validate()) {
                      _generatedEducation = await AiHelper()
                          .generate(_educationSummaryController.value.text, "education");
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      _prefs.setString("education", _generatedEducation);
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
                  initialValue: _generatedEducation.toString().trim(),
                  maxLines: 10,
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
