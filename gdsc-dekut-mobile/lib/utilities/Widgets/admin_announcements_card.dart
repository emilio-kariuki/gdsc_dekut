import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnouncementAdminCard extends StatelessWidget {
  const AnnouncementAdminCard({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.name,
    required this.position,
    required this.editFunction,
    required this.deleteFunction,
    required this.id,
  });

  final double height;
  final double width;
  final String title;
  final String name;
  final String position;
  final String id;
  final Function() editFunction;
  final Function() deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
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
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  AutoSizeText(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              AutoSizeText(
                "$name - $position",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xff5B5561),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                              width: 0.55,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: editFunction,
                        child: AutoSizeText(
                          "Edit",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xff5B5561),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.black,
                              width: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: deleteFunction,
                        child: AutoSizeText(
                          "Delete",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
