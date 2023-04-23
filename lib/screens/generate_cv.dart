import 'package:cvmaker_app_sarah_proj/FormDataStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateCVScreen extends StatefulWidget {
  const GenerateCVScreen({Key? key}) : super(key: key);

  @override
  State<GenerateCVScreen> createState() => _GenerateCVScreenState();
}

class _GenerateCVScreenState extends State<GenerateCVScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _aiGeneratedDataController = Get.put(FormDataLocalStorage());
  double skillsPositiondx = 0.0;
  double skillsPositiondy = 0.0;
  double educationPositiondx = 10.0;
  double educationPositiondy = 10.0;
  double hobbiesPositiondx = 20.0;
  double hobbiesPositiondy = 20.0;
  double workExpPositiondx = 30.0;
  double workExpPositiondy = 30.0;
  double personalPositiondx = 40.0;
  double personalPositiondy = 40.0;

  late final QuillController _quillHeaderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final headerDelta = Delta();
    headerDelta.insert("${_aiGeneratedDataController.retrieveHeader()}\n");
    _quillHeaderController = QuillController(
      document: Document.fromDelta(headerDelta),
      selection: TextSelection.collapsed(offset: 0),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       body: Padding(
  //         padding: const EdgeInsets.only(left: 18.0, right: 18.0),
  //         child: Container(
  //           child: Stack(
  //             // fit: StackFit.expand,
  //             children: [
  //               /**
  //          * HEADER
  //          */
  //               Positioned(
  //                 top: 10,
  //                 left: 10,
  //                 child: GestureDetector(
  //                   child: Container(
  //                     child: QuillEditor.basic(
  //                         controller: _quillHeaderController, readOnly: false),
  //                   ),
  //                 ),
  //               ),
  //               /**
  //          * HEADER
  //          */
  //               GestureDetector(
  //                 child: Container(
  //                   child: QuillEditor.basic(
  //                       controller: _quillHeaderController, readOnly: false),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       floatingActionButton: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: QuillToolbar.basic(
  //           controller: _quillHeaderController,
  //           multiRowsDisplay: false,
  //           toolbarIconSize: 25,
  //           showSearchButton: false,
  //           showStrikeThrough: false,
  //           showBackgroundColorButton: false,
  //           showHeaderStyle: false,
  //           showClearFormat: false,
  //           showCodeBlock: false,
  //           showListCheck: false,
  //         ),
  //       ),
  //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //HEADER SECTION
              Container(
                color: Colors.grey,
                width: MediaQuery.of(context).size.width - 20,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: GestureDetector(
                        child: Container(
                          child: QuillEditor.basic(
                              controller: _quillHeaderController,
                              readOnly: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.blue,
                      height: MediaQuery.of(context).size.height - 20,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                    ),
                    VerticalDivider(
                      thickness: 2,
                    ),
                    Container(
                      color: Colors.green,
                      height: MediaQuery.of(context).size.height - 20,
                      width: MediaQuery.of(context).size.width / 2 - 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/* @override
  Widget build(BuildContext context) {
    double textFieldSize = MediaQuery.of(context).size.width - 20;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              child: Image.asset("asset/cv-templates/CV_Template1.png",
                  fit: BoxFit.fitHeight),
            ),
            /**
             *  PERSONAL DETAILS SECTION
             */
            Positioned(
              top: personalPositiondx,
              left: personalPositiondy,
              child: GestureDetector(
                onPanUpdate: (delta) => setState(() {
                  personalPositiondy += delta.delta.dx;
                  personalPositiondx += delta.delta.dy;
                }),
                child: SizedBox(
                  width: textFieldSize,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    enabled: false,
                    initialValue: _aiGeneratedDataController.retrieveHeader(),
                    maxLines: 10,
                    // maxLines: 20,
                  ),
                ),
              ),
            ),
            /**
             *  PERSONAL DETAILS SECTION ENDS HERE
             */
            /**
             *  HOBBIES SECTION
             */
            Positioned(
              top: hobbiesPositiondx,
              left: hobbiesPositiondy,
              child: GestureDetector(
                onPanUpdate: (delta) => setState(() {
                  hobbiesPositiondx += delta.delta.dy;
                  hobbiesPositiondy += delta.delta.dx;
                }),
                child: SizedBox(
                  width: textFieldSize,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    enabled: false,
                    initialValue: _aiGeneratedDataController.retrieveHobbies(),
                    maxLines: 10,
                    // maxLines: 20,
                  ),
                ),
              ),
            ),
            /**
             *  HOBBIES SECTION ENDS HERE
             */
            /**
             *  EDUCATION SECTION
             */
            Positioned(
              top: educationPositiondx,
              left: educationPositiondy,
              child: GestureDetector(
                onPanUpdate: (delta) => setState(() {
                  educationPositiondx += delta.delta.dy;
                  educationPositiondy += delta.delta.dx;
                }),
                child: SizedBox(
                  width: textFieldSize,
                  child: TextFormField(
                    enabled: false,
                    initialValue: _aiGeneratedDataController.retrieveEducation(),
                    maxLines: 10,
                    // maxLines: 20,
                  ),
                ),
              ),
            ),
            /**
             *  EDUCATION SECTION ENDS HERE
             */
            /**
             *  WORKS SECTION
             */
            Positioned(
              top: workExpPositiondx,
              left: workExpPositiondy,
              child: GestureDetector(
                onPanUpdate: (delta) => setState(() {
                  workExpPositiondx += delta.delta.dy;
                  workExpPositiondy += delta.delta.dx;
                }),
                child: SizedBox(
                  width: textFieldSize,
                  child: TextFormField(
                    enabled: false,
                    initialValue: _aiGeneratedDataController.retrieveWorkExp(),
                    maxLines: 10,
                    // maxLines: 20,
                  ),
                ),
              ),
            ),
            /**
             *  WORKS SECTION ENDS HERE
             */
            /**
         *  SKILLS SECTION
         */
            Positioned(
              top: skillsPositiondx,
              left: skillsPositiondy,
              child: GestureDetector(
                onPanUpdate: (delta) => setState(() {
                  skillsPositiondx += delta.delta.dy;
                  skillsPositiondy += delta.delta.dx;
                }),
                child: SizedBox(
                  width: textFieldSize,
                  child: TextFormField(
                    enabled: false,
                    initialValue: _aiGeneratedDataController.retrieveSkills(),
                    maxLines: 10,
                    // maxLines: 20,
                  ),
                ),
              ),
            ),
            /**
             *  SKILLS SECTION ENDS HERE
             */
          ],
        ),
      ),
    );
  }
*/
}

// class GenerateCVScreen extends StatefulWidget {
//   const GenerateCVScreen({Key? key}) : super(key: key);
//
//   @override
//   State<GenerateCVScreen> createState() => _GenerateCVScreenState();
// }
//
// class _GenerateCVScreenState extends State<GenerateCVScreen> {
//   final _cvForms = const [
//     PersonalDetailsForm(masterScreen: ""),
//     EducationForm(),
//     WorkExperienceForm(),
//   ];
//
//   int screenCounter = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height - 100,
//             child: _cvForms[screenCounter],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               screenCounter == 0
//                   ? Container()
//                   : CustomTextBtnWithIcon(
//                       btnLabel: "Prev",
//                       onPressed: () {
//                         screenCounter != 0
//                             ? screenCounter--
//                             : screenCounter = 0;
//                         setState(() {});
//                       },
//                       icon: Icons.navigate_before,
//                     ),
//               screenCounter == _cvForms.length-1
//                   ? Padding(
//                     padding: const EdgeInsets.only(right:8.0),
//                     child: Align(
//                         alignment: Alignment.center,
//                         child: CustomButton(
//                           btnLabel: "Submit",
//                           onPressed: () {},
//                         ),
//                       ),
//                   )
//                   : Align(
//                       alignment: Alignment.centerRight,
//                       child: CustomTextBtnWithIcon(
//                         btnLabel: "Next",
//                         onPressed: () {
//                           screenCounter != _cvForms.length -1
//                               ? screenCounter++
//                               : screenCounter = _cvForms.length;
//                           setState(() {});
//                         },
//                         icon: Icons.navigate_next,
//                       ),
//                     ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
