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
            
          ),
        ),
        TextButton(
          style: Theme.of(context).textButtonTheme.style,
          onPressed: () {
            Navigator.pushNamed(context, location);
          },
          child: Text(
            "See all",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    );
  }
}