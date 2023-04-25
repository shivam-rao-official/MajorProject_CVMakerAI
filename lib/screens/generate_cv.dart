import 'dart:io';

import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:cvmaker_app_sarah_proj/widgets/header.dart';
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
  final _picker = ImagePicker();
  File? _imageFile;
  GlobalKey key = GlobalKey();


  late final QuillController _quillEducationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final headerDelta = Delta();
    headerDelta.insert("${_aiGeneratedDataController.retrieveEducation()}\n");
    _quillEducationController = QuillController(
      document: Document.fromDelta(headerDelta),
      selection: const TextSelection.collapsed(offset: 0),
    );
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
                      child: _imageFile == null ? const Placeholder(
                        child: Center(
                          child: Text("IMAGE"),
                        ),
                      ): Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.fill
                          )
                        ),
                      )
                    ),
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
                            _aiGeneratedDataController.userName.value.isEmpty ? "{USER NAME}": _aiGeneratedDataController.userName.value,
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
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveHeader(),
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
              header("PROFILE"),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
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
              header("EDUCATION"),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
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
              header("EMPLOYMENT HISTORY"),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(
                  _aiGeneratedDataController.retrieveWorkExp(),
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
              header("SKILLS"),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(_aiGeneratedDataController.retrieveSkills(),
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
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Text(_aiGeneratedDataController.retrieveLanguage(),
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
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
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
        child: const Icon(Icons.download),
        onPressed: () {},
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

  // Future<void> saveAsPDF() async {
  //   RenderRepaintBoundary boundary =
  //   key.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   ui.Image image = await boundary.toImage(pixelRatio: 3.0);
  //   ByteData? byteData =
  //   await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  //
  //   final pdf = pw.Document();
  //   pdf.addPage(pw.Page(
  //     pageFormat: PdfPageFormat.a4,
  //     build: (pw.Context context) {
  //       return pw.Image(
  //         PdfImage.file(
  //           pdf.document,
  //           bytes: byteData!.buffer.asUint8List(),
  //         ) as pw.ImageProvider ,
  //         width: image.width as double,
  //         height: image.height as double,
  //       );
  //     },
  //   ));
  //
  //   final bytes = await pdf.save();
  //   final directory = await getApplicationDocumentsDirectory();
  //   final file = File('${directory.path}/${_aiGeneratedDataController.userName}+${DateTime.now()}.pdf');
  //   await file.writeAsBytes(bytes);
  // }

}
