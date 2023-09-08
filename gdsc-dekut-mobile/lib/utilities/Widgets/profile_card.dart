import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.title,
      required this.function,
      required this.showTrailing,
      required this.leadingLogo});
  final String title;
  final String leadingLogo;
  final Function() function;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
         SystemChannels.textInput.invokeMethod('TextInput.hide');
        function();
      },
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.white,
        foregroundColor: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            leadingLogo,
            height: 15,
            width: 15,
          ),
          const SizedBox(
            width: 12,
          ),
          AutoSizeText(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          const Spacer(),
          showTrailing
              ? Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[800],
                  size: 12,
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
