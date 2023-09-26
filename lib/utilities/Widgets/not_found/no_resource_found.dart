import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';

class NoResourceCard extends StatelessWidget {
  const NoResourceCard({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.error,
            height: height * 0.04,
            width: width * 0.04,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "No resources found",
            style: GoogleFonts.inter(
              fontSize: 18,
              color: const Color(0xff333333),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            "You can add a resource by clicking\n the add button below",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: const Color(0xff828282),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}