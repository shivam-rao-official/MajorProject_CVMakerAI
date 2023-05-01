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

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _profileFormKey = GlobalKey<FormState>();
  final _profileController = TextEditingController();
  final _generatedProfileController = TextEditingController();
  final _generatedDataStorageController = Get.put(FormDataLocalStorage());
  final _userStorage = Get.put(UserDataStorage());

  var _generatedProfile;

  bool generatingContent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _generatedProfile = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(61),
        child: CustomAppbar(
          appBarLabel: "CV Summary",
          isActionBtnRequired: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _profileFormKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextFields(
                  controller: _profileController,
                  hintText: "Write few keywords to generate a profile/objective e.g, fresher etc.",
                  maxLines: 5,
                  validator: (val) {
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                generatingContent
                    ? const CircularProgressIndicator()
                    : CustomButton(
                  btnLabel: _generatedProfile.toString().isEmpty
                      ? "GENERATE"
                      : "REGENERATE",
                  onPressed: () async {
                    if (_profileFormKey.currentState!.validate()) {
                      _generatedProfile = "";
                      generatingContent = true;
                      setState(() {});
                      _generatedProfile = await AiHelper().generate(
                          _profileController.value.text, "objective");
                      _generatedProfileController.text = _generatedProfile;
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
                _generatedProfile.toString().isNotEmpty
                    ? TextFormField(
                  controller: _generatedProfileController,
                  onSaved: (val) {
                    _generatedProfileController.text = val!;
                  },
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                )
                    : Container(),
                const SizedBox(height: 20),
                _generatedProfile.toString().isNotEmpty
                    ? CustomButton(
                  btnLabel: "SAVE",
                  onPressed: () async{
                    Map<String, dynamic> profile = {
                      "userGivenString": _profileController.text,
                      "aiGeneratedText": _generatedProfileController.text
                    };

                    var resp = await FormsService().addProfile(_userStorage.retrieveId(), profile);
                    _generatedDataStorageController.saveProfile(_generatedProfileController.text.trim());
                    resp == 201 ? ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Data Saved',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    ): ToastMsg().errorToast("Something Gone Wrong");
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
