// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.controller,
    this.obScureText = false,
    this.suffixIcon,
    this.isEnabled = true,
    required this.validator,
    this.function,
    this.textInputType,
    this.minLines = 1,
    this.maxLines = 5,
    required this.hintText,
  });
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obScureText;
  final String hintText;
  final bool? isEnabled;
  final Function()? function;
  final String? Function(String?)? validator;
  final int minLines;
  final int maxLines;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obScureText,
      enabled: isEnabled ?? true,
      keyboardType: textInputType ?? TextInputType.text,
      textInputAction: TextInputAction.next,
      minLines: minLines,
      maxLines: maxLines,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: const Color(0xff000000),
      ),
      onTap: function,
      decoration: InputDecoration(
        hintText: hintText,
        // label: Text(
        //   title,
        //   style: GoogleFonts.inter(
        //     fontSize: 14,
        //     fontWeight: FontWeight.w500,
        //     color: const Color(0xff000000),
        //   ),
        // ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xff000000),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xff666666),
          ),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
