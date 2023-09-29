import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.title,
      required this.function,
      required this.showTrailing,
      required this.icon});
  final String title;
  final IconData icon;
  final Function() function;
  final bool showTrailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
      child: InkWell(
        radius: 0,
        splashColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          function();
        },
        child: Row(
          children: [
            Icon(icon, size: 20, color: Theme.of(context).iconTheme.color,),
            const SizedBox(
              width: 18,
            ),
            AutoSizeText(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                // color: Colors.grey[800],
              ),
            ),
            const Spacer(),
            showTrailing
                ? Icon(
                    Icons.arrow_forward_ios,
                    // color: Colors.black,
                    size: 15,
                  )
                : const SizedBox.shrink(),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
