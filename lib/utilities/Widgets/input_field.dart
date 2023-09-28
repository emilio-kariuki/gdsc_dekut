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
    this.fillColor = Colors.transparent,
    this.borderRadius = 10,
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
  final Color? fillColor;
  final double borderRadius;


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
      style: Theme.of(context).inputDecorationTheme.labelStyle,
      onTap: function,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide:  BorderSide(
              color: Colors.grey[400]!
              ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
              // color: Color(0xff000000),
              ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
              // color: Color(0xff666666),
              ),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          // color: Colors.grey[700],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
