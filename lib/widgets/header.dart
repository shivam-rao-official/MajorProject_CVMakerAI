import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget header(String headerLabel) {
  return Padding(
    padding: const EdgeInsets.only(left: 30.0),
    child: Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: Text(headerLabel, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),),
      ),
    ),
  );
}