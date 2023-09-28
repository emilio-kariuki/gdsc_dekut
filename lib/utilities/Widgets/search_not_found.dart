import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../image_urls.dart';

class SearchNotFound extends StatelessWidget {
  const SearchNotFound({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height * 0.5,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppImages.oops, height: height * 0.2),
            Text(
              "Search not found",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: const Color(0xff666666),
              ),
            ),
          ],
        )),
      );
  }
}
