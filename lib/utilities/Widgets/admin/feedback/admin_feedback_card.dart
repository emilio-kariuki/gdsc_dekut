// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminFeedbackCard extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AdminFeedbackCard({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.about,
  });

  final String about;
  final double height;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF282828),
            width: 0.15,
          )
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              about,
              maxLines: 2,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                color: const Color(0xff5B5561),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
