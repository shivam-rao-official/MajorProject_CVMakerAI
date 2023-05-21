import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

dynamic pwHeader(String headerLabel) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(left: 30.0),
    child: pw.Container(
      color: PdfColor.fromHex('#ffffff'),
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        child: pw.Text(headerLabel, style:
        pw.TextStyle(color:PdfColor.fromHex('#000000'), fontSize: 18),),
      ),
    ),
  );
}