import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerOr extends StatelessWidget {
  const DividerOr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Divider(
            height: 20,
            thickness: 0.2,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "OR",
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            // color: cons /t Color(0xff000000),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Divider(
            height: 20,
            thickness: 0.2,
          ),
        ),
      ],
    );
  }
}
