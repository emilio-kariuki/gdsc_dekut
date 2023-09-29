import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchResultButton extends StatelessWidget {
  const SearchResultButton({
    super.key,
    required this.function,
  });

  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Search Results",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: function,
            icon: Icon(
              Icons.close,
              size: 18,
              color: Theme.of(context).iconTheme.color,
            ))
      ],
    );
  }
}