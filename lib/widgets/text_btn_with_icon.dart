import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextBtnWithIcon extends StatefulWidget {
  final String btnLabel;
  final Function() onPressed;
  final IconData? icon;
  const CustomTextBtnWithIcon({
    Key? key,
    required this.btnLabel,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  _CustomTextBtnWithIconState createState() => _CustomTextBtnWithIconState();
}

class _CustomTextBtnWithIconState extends State<CustomTextBtnWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Row(
          children: [
            Icon(widget.icon, color: Colors.black54),
            const SizedBox(width: 10),
            Text(
              widget.btnLabel,
              style: GoogleFonts.poppins(
                // fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
