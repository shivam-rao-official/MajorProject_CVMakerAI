import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/ai_services/ai_helper.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LanguageForm extends StatefulWidget {
  const LanguageForm({Key? key}) : super(key: key);

  @override
  State<LanguageForm> createState() => _LanguageFormState();
}

class _LanguageFormState extends State<LanguageForm> {
  final _languageFormKey = GlobalKey<FormState>();
  final _languageController = TextEditingController();
  final _generatedLanguageController = TextEditingController();
  final _generatedDataStorageController = Get.put(FormDataLocalStorage());

  var _generatedLanguage;
  bool _generateContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedLanguage = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "Language",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _languageFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _languageController,
                  hintText: "Write the languages you know separated by comma",
                  maxLines: 10,
                  validator: (val) {
                    if (val == null || val.isEmpty) return null;
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                _generateContent
                    ? const CircularProgressIndicator()
                    : CustomButton(
                  btnLabel: _generatedLanguage.toString().isEmpty
                      ? "SAVE"
                      : "REGENERATE",
                  onPressed: () async {
                    if (_languageFormKey.currentState!.validate()) {
                      _generatedLanguage = "";
                      _generateContent = true;
                      setState(() {});
                      _generatedLanguage = await AiHelper().generate(
                          _languageController.value.text, "languages known");
                      _generatedLanguageController.text = _generatedLanguage;
                      _generateContent = false;
                      setState(() {});
                    }
                  },
                ),
                /**
                 *    BELOW LINES OF CODE WILL ONLY VISIBLE IN APP WHEN WE GET AN RESPONSE FROM CHATGPT API
                 *    AND THEN STORE IT IN _generatedWrokExp
                 */
                const SizedBox(height: 30),
                _generatedLanguage.toString().isNotEmpty
                    ? TextFormField(
                  controller: _generatedLanguageController,
                  maxLines: 10,
                  onSaved: (val) {
                    _generatedLanguageController.text = val!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                )
                    : Container(),
                const SizedBox(height: 20),
                _generatedLanguage.toString().isNotEmpty
                    ? CustomButton(
                  btnLabel: "SAVE",
                  onPressed: () {
                    _generatedDataStorageController
                        .saveLanguage(_generatedLanguageController.text.trim());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Data Saved',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
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
