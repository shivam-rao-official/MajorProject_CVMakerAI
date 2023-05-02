import 'dart:io';

import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/api_services/CVService.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/header.dart';
import 'package:cvmaker_app_sarah_proj/widgets/toast_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class GenerateCVScreen extends StatefulWidget {
  const GenerateCVScreen({Key? key}) : super(key: key);

  @override
  State<GenerateCVScreen> createState() => _GenerateCVScreenState();
}

class _GenerateCVScreenState extends State<GenerateCVScreen> {
  final _aiGeneratedDataController = Get.put(FormDataLocalStorage());
  final _userService = Get.put(UserDataStorage());
  var _onSavedResp;
  final _picker = ImagePicker();
  File? _imageFile;
  GlobalKey key = GlobalKey();

  late final QuillController _quillEducationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppbar(
            appBarLabel: "Generate CV", isActionBtnRequired: false),
      ),
      body: RepaintBoundary(
        key: key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /**
           * HEADER SECTION
           */
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => takePhoto(ImageSource.gallery),
                    child: Container(
                        color: Colors.green,
                        height: 100,
                        width: MediaQuery.of(context).size.width / 4,
                        child: _imageFile == null
                            ? const Placeholder(
                                child: Center(
                                  child: Text("IMAGE"),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(_imageFile!),
                                        fit: BoxFit.fill)),
                              )),
                  ),
                  Container(
                    color: Colors.yellow[200],
                    height: 100,
                    width: (MediaQuery.of(context).size.width - 10) -
                        (MediaQuery.of(context).size.width / 4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userService.retrieveName().isEmpty
                                ? "{USER NAME}"
                                : _userService.retrieveName(),
                            style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Text(
                            "STUDENT",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              /**
           * DETAILS SECTION
           */
              const SizedBox(
                height: 20,
              ),
              header("DETAILS"),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _userService.retrieveLinkedInUrl().isNotEmpty
                      ? "Email: ${_userService.retrieveEmail()}\nPhone Number: ${_userService.retrievePhone()}\nLinkedInUrl: ${_userService.retrieveLinkedInUrl()}"
                      : "Email: ${_userService.retrieveEmail()}\nPhone Number: ${_userService.retrievePhone()}",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _aiGeneratedDataController.retrieveProfile().isNotEmpty
                  ? header("PROFILE")
                  : Container(),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveProfile(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _aiGeneratedDataController.retrieveEducation().isNotEmpty
                  ? header("EDUCATION")
                  : Container(),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveEducation(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _aiGeneratedDataController.retrieveWorkExp() !=
                      "No Work Experience Added"
                  ? header("EXPERIENCE")
                  : Container(),
              _aiGeneratedDataController.retrieveWorkExp() !=
                      "No Work Experience Added"
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
                      child: Text(
                        _aiGeneratedDataController.retrieveWorkExp(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              header("SKILLS"),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveSkills(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              header("LANGUAGES"),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveLanguage(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              header("HOBBIES"),
              Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveHobbies(),
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save_alt),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              var myForm = GlobalKey<FormState>();
              var fileController = TextEditingController();
              return Form(
                key: myForm,
                child: AlertDialog(
                  title: const Text("SAVE CV"),
                  content: TextFormField(
                    controller: fileController,
                    decoration: const InputDecoration(
                      hintText: "Enter File Name",
                    ),
                    validator: (val) {
                      if (val!.isEmpty) return "File name required to save CV";
                      return null;
                    },
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        )),
                    TextButton(onPressed: () async {
                      if(myForm.currentState!.validate()){
                        _onSavedResp = await CVService().saveCV(fileController.text);
                        if(_onSavedResp["statusCode"] == 200)
                          {
                            ToastMsg().successToast("CV SAVED");
                            Navigator.of(context).pushReplacementNamed("/home");
                          }
                        else {
                          ToastMsg().errorToast("SOMETHING went wrong");
                        }
                      }
                    }, child: const Text("SAVE")),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    // if (pickedFile != null) {
    //   CroppedFile? _croppedImage = await ImageCropper().cropImage(
    //     sourcePath: pickedFile.path,
    //     compressFormat: ImageCompressFormat.jpg,
    //     compressQuality: 50,
    //     cropStyle: CropStyle.circle,
    //     uiSettings: [
    //       AndroidUiSettings(
    //         hideBottomControls: true,
    //         lockAspectRatio: true,
    //         initAspectRatio: CropAspectRatioPreset.ratio4x3,
    //       ),
    //       IOSUiSettings(
    //         hidesNavigationBar: true,
    //         aspectRatioLockEnabled: true,
    //       ),
    //     ],
    //   );
    //
    //   if (_croppedImage != null) {
    //     final path = _croppedImage.path;
    //       _imageFile = File(path);
    //     // print("Cropped File =========> ${_imageFile!.path}");
    //
    //     // widget.controller.updateProfileImage(_imageFile);
    //   }
    //   // BaseController.showReload.value = false;
    //   // widget.controller.updateProfileImage(File(pickedFile.path));
    // }else {
    //   _imageFile = File(pickedFile!.path);
    // }
    _imageFile = File(pickedFile!.path);
    setState(() {});
  }

// void loadData() async{
//   await FormsService().fetchEducation(_userService.retrieveId());
// }


}
