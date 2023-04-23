import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget {
  final String appBarLabel;
  final bool isActionBtnRequired;
  const CustomAppbar({super.key, required this.appBarLabel, required this.isActionBtnRequired,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        appBarLabel,
        style: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: const Color(0xff525ECA),
      actions:  isActionBtnRequired ? [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/login");
          },
          icon: const Icon(Icons.power_settings_new_rounded),
        ),
      ]: [],
    );
  }
}
