import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourceWidget extends StatelessWidget {
  const ResourceWidget({
    super.key,
    required this.title,
    required this.location,
    this.arguments
  });
  final String title;
  final String location;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 18,
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
            Navigator.pushNamed(context, location,arguments: arguments);
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