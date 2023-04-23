import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/ai_services/ai_helper.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/genericBtn.dart';
import 'package:cvmaker_app_sarah_proj/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetailsForm extends StatefulWidget {
  final String? masterScreen;
  const PersonalDetailsForm({Key? key, this.masterScreen}) : super(key: key);

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final _personalDetailFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkedInController = TextEditingController();

  final _generatedDataStorageController = Get.put(FormDataLocalStorage());

  var _generatedHeader;
  bool generatingContent = false;

  late final _quillController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedHeader = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "Personal Details Form",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _personalDetailFormKey,
            child: Column(
              children: [
                CustomTextFields(
                  controller: _nameController,
                  hintText: "Name",
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Name is Required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _phoneController,
                  hintText: "Phone Number",
                  maxLength: 10,
                  keyBoardType: TextInputType.phone,
                  validator: (val) {
                    if (val == null || val.isEmpty || val.length != 10) {
                      return "Phone Number is Required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _emailController,
                  hintText: "Email",
                  validator: (val) {
                    if (val == null || val.isEmpty) return "Email is Required";
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _linkedInController,
                  hintText: "Linked In Profile Url",
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "LinkedIn Url is Required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                generatingContent? const CircularProgressIndicator() : CustomButton(
                  btnLabel: _generatedHeader.toString().isEmpty
                      ? "SAVE"
                      : "REGENERATE",
                  onPressed: () async {
                    if (_personalDetailFormKey.currentState!.validate()) {
                    print(_nameController.value.text);
                    _generatedHeader = "";
                    generatingContent = true;
                    setState(() {});

                      _generatedHeader = await AiHelper()
                          .generate("Name: ${_nameController.value.text}, Email: ${_emailController.value.text},"
                          "Phone Number: ${_phoneController.value.text}, LinkedIn Profile Url: ${_linkedInController.value.text} ", "header");
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
                _generatedHeader.toString().isNotEmpty
                // ? QuillEditor.basic(controller: _quillController, readOnly: false)
                    ? TextFormField(
                        initialValue: _generatedHeader.toString().trim(),
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 20),
                _generatedHeader.toString().isNotEmpty
                    ? CustomButton(
                        btnLabel: "SAVE",
                        onPressed: () {
                          _generatedDataStorageController.saveHeader(_generatedHeader);
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
