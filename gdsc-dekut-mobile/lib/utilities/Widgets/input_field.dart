// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
   InputField(
      {super.key,
       this.title,
      required this.controller,
      this.obScureText = false,
      this.suffixIcon,
      required this.hintText});
  String? title;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obScureText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox.shrink()
            : Text(
                title!,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff000000),
                ),
              ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.only(left: 12, right: 1),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1,
              )),
          child: TextFormField(
            controller: controller,
            obscureText: obScureText,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: const Color(0xff000000),
            ),
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: hintText,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      ],
    );
  }
}
