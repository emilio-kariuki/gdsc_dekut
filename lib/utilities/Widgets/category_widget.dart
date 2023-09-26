import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.title,
    required this.location,
  });
  final String title;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: const Color(0xff000000),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shadowColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, location);
          },
          child: Text(
            "See all",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: const Color(0xff000000),
            ),
          ),
        )
      ],
    );
  }
}