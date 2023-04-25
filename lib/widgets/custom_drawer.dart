import 'package:cvmaker_app_sarah_proj/widgets/text_btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 2 + 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xff525ECA)),
            accountName: Text(
              "accountName",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            accountEmail: Text(
              "accountEmail",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w100,
                fontSize: 15,
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtnWithIcon(
                  btnLabel: "Add/Update Personal Details",
                  onPressed: () {
                    Navigator.of(context).pushNamed("/form-personalDetail",
                        arguments: {"masterScreen": "GenerateCV"});
                  },
                  icon: Icons.person_outline_outlined)),
          Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtnWithIcon(
                btnLabel: "Generate Profile",
                onPressed: () {
                  Navigator.of(context).pushNamed("/form-generateObjective");
                },
                icon: Icons.summarize_outlined,
              )),
          Align(
            alignment: Alignment.centerRight,
            child: CustomTextBtnWithIcon(
                btnLabel: "Add/Update Education",
                onPressed: () {
                  Navigator.of(context).pushNamed("/form-educationSummary");
                },
                icon: Icons.book_outlined),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CustomTextBtnWithIcon(
              btnLabel: "Add/Update skills",
              onPressed: () {
                Navigator.of(context).pushNamed("/form-skillsForm");
              },
              icon: Icons.add,
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtnWithIcon(
                btnLabel: "Add/Update Work Ex.",
                onPressed: () {
                  Navigator.of(context).pushNamed("/form-workExperienceForm");
                },
                icon: Icons.work_outline,
              )),
          Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtnWithIcon(
                btnLabel: "Add/Update Hobbies",
                onPressed: () {
                  Navigator.of(context).pushNamed("/form-hobbiesForm");
                },
                icon: Icons.games_outlined,
              )),
          Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtnWithIcon(
                btnLabel: "Add/Update Language",
                onPressed: () {
                  Navigator.of(context).pushNamed("/form-languageForm");
                },
                icon: Icons.language_outlined,
              )),

          Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtnWithIcon(
                btnLabel: "Generate new CV",
                onPressed: () {
                  Navigator.of(context).pushNamed("/generateCvScreen");
                },
                icon: Icons.create,
              )),
        ],
      ),
    );
  }
}
