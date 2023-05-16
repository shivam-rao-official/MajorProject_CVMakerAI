import 'dart:io';
import 'dart:ui' as UI;

import 'package:cvmaker_app_sarah_proj/UserDataStorage.dart';
import 'package:cvmaker_app_sarah_proj/services/api_services/forms_service.dart';
import 'package:cvmaker_app_sarah_proj/widgets/appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../widgets/header.dart';

class ViewCVScreen extends StatefulWidget {
  final int cvId;

  const ViewCVScreen({
    Key? key,
    required this.cvId,
  }) : super(key: key);

  @override
  State<ViewCVScreen> createState() => _ViewCVScreenState();
}

class _ViewCVScreenState extends State<ViewCVScreen> {
  final _userService = Get.put(UserDataStorage());
  final _picker = ImagePicker();
  File? _imageFile;
  var text;
  GlobalKey key = GlobalKey();

  String? education;
  String? profile;
  String? skills;
  String? languages;
  String? workExp;
  String? hobbies;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CustomAppbar(appBarLabel: "View CV", isActionBtnRequired: false),
      ),
      // body: Center(
      //   child: text == null ? Text("My CV"): Text(text.toString()),
      // ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RepaintBoundary(
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
                        /**
             * FOR DISPLAYING IMAGE
             */
                        // GestureDetector(
                        //   onTap: () => takePhoto(ImageSource.gallery),
                        //   child: Container(
                        //       color: Colors.green,
                        //       height: 100,
                        //       width: MediaQuery.of(context).size.width / 4,
                        //       child: _imageFile == null
                        //           ? const Placeholder(
                        //               child: Center(
                        //                 child: Text("IMAGE"),
                        //               ),
                        //             )
                        //           : Container(
                        //               decoration: BoxDecoration(
                        //                   image: DecorationImage(
                        //                       image: FileImage(_imageFile!),
                        //                       fit: BoxFit.fill)),
                        //             )),
                        // ),
                        Container(
                          color: Colors.yellow[200],
                          height: 100,
                          width: MediaQuery.of(context)
                              .size
                              .width, // width: (MediaQuery.of(context).size.width - 10) -
                          //     (MediaQuery.of(context).size.width / 4),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 30.0, bottom: 8.0),
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
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
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
                    header("PROFILE"),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
                      child: Text(
                        profile!,
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
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
                      child: Text(
                        education!,
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
                    workExp!.isNotEmpty ? header("EXPERIENCE") : Container(),
                    workExp!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 30.0, right: 30.0),
                            child: Text(
                              workExp!,
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
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
                      child: Text(
                        skills!,
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
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
                      child: Text(
                        languages!,
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
                      padding: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0),
                      child: Text(
                        hobbies!,
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
        onPressed: () async {
          saveAsPDF();
          print("CV SAVED");
        },
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    _imageFile = File(pickedFile!.path);
    setState(() {});
  }

  void loadData() async {
    isLoading = true;
    setState(() {});
    var resp = await FormsService().fetchCv(widget.cvId);
    text = resp["body"];
    profile = resp["body"]["profile"];
    education = resp["body"]["education"];
    skills = resp["body"]["skills"];
    languages = resp["body"]["languages"];
    workExp = resp["body"]["workExp"];
    hobbies = resp["body"]["hobbies"];
    isLoading = false;
    setState(() {});
  }

  Future<void> saveAsPDF() async {
    RenderRepaintBoundary boundary =
        key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    UI.Image image = await boundary.toImage();
    ByteData? byteData =
        await image.toByteData(format: UI.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Image(
         pw.MemoryImage(pngBytes)
        );
      },
    ));

    final directory = await getApplicationDocumentsDirectory();
    final file = File(
        '${directory.path}/${_userService.retrieveName()}${DateTime.now()}.pdf');
    print(file.toString());
    await file.writeAsBytes(await pdf.save());
  }


}
