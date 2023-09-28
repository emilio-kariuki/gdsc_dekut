import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBottomButton extends StatelessWidget {
  const DialogBottomButton({
    super.key,
    required this.title,
    required this.function,
    required this.tooltipMessage,
    required this.icon,
  });

  final String title;
  final Function() function;
  final String tooltipMessage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            // padding: const EdgeInsets.all(5),
            decoration:
                BoxDecoration(color: Colors.grey[800], shape: BoxShape.circle),
            child: IconButton(
              onPressed: function,
              icon:  Icon(icon,
                  size: 22, color: Colors.white),
            ),
          ),
          AutoSizeText(
            title,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}