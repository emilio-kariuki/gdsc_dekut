import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/models/announcement_model.dart';

class AnnouncementAdminCard extends StatelessWidget {
  const AnnouncementAdminCard({
    super.key,
    required this.announcement,
    required this.editFunction,
    required this.deleteFunction,
    required this.id,
  });

  final AnnouncementModel announcement;
  final String id;
  final Function() editFunction;
  final Function() deleteFunction;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            shadowColor: Theme.of(context).primaryColor,
            surfaceTintColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Color.fromARGB(255, 106, 81, 81),
                width: 0.15,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                announcement.title!,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  // color: const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              AutoSizeText(
                "$announcement.name - $announcement.position",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
