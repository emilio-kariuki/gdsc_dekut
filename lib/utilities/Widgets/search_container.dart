import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.onFieldSubmitted,
    required this.hint, required this.close,
  });

  final TextEditingController searchController;
  final String? Function(String) onChanged;
  final String? Function(String) onFieldSubmitted;
  final Function() close;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        // color: const Color(0xff000000),
      ),
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xff666666),
          size: 18,
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: close,
          icon: const Icon(
            Icons.close,
            color: Color(0xff666666),
            size: 18,
          ),
        ),
        hintText: hint,
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1.3,
          ),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
