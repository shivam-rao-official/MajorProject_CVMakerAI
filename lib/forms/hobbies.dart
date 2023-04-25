import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/ai_services/ai_helper.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class HobbiesForm extends StatefulWidget {
  const HobbiesForm({Key? key}) : super(key: key);

  @override
  State<HobbiesForm> createState() => _HobbiesFormState();
}

class _HobbiesFormState extends State<HobbiesForm> {
  final _hobbiesFormKey = GlobalKey<FormState>();
  final _hobbiesController = TextEditingController();
  final _generatedHobbyController = TextEditingController();
  final _generatedDataStorageController = Get.put(FormDataLocalStorage());

  var _generatedHobbies;
  bool _generateContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedHobbies = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "Hobbies Summary",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _hobbiesFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _hobbiesController,
                  hintText: "Write few hobbies",
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
                        btnLabel: _generatedHobbies.toString().isEmpty
                            ? "SAVE"
                            : "REGENERATE",
                        onPressed: () async {
                          if (_hobbiesFormKey.currentState!.validate()) {
                            _generatedHobbies = "";
                            _generateContent = true;
                            setState(() {});
                            _generatedHobbies = await AiHelper().generate(
                                _hobbiesController.value.text, "hobbies");
                            _generatedHobbyController.text = _generatedHobbies;
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
                _generatedHobbies.toString().isNotEmpty
                    ? TextFormField(
                        controller: _generatedHobbyController,
                        maxLines: 10,
                        onSaved: (val) {
                          _generatedHobbyController.text = val!;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20),
                _generatedHobbies.toString().isNotEmpty
                    ? CustomButton(
                        btnLabel: "SAVE",
                        onPressed: () {
                          _generatedDataStorageController
                              .saveHobbies(_generatedHobbyController.text.trim());
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
