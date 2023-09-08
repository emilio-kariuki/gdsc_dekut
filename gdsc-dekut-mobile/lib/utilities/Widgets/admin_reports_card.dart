// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminReportCard extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  AdminReportCard({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.about,
    required this.image,
  });

  final String about;
  final double height;
  final String title;
  final double width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFF282828),
              width: 0.15,
            )),
        child: Row(
          children: [
            Semantics(
                  button: true,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/image_view',
                                  arguments: ImageArguments(
                                      title: title, image: image));
                    },
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      placeholder: (context, url) {
                        return Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              // border: Border.all(width: 0.4, color: Color(0xff666666)),
                              borderRadius: BorderRadius.circular(10)),
                        );
                      },
                      errorWidget: ((context, url, error) {
                        return const Icon(
                          Icons.error,
                          size: 20,
                          color: Colors.red,
                        );
                      }),
                      imageUrl: image,
                      fit: BoxFit.fitHeight,
                      imageBuilder: (context, imageProvider) {
                        return AnimatedContainer(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 0.4, color: const Color(0xff666666)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                    ),
                  ),
                ),
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    title,
                    maxLines: 2,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    about,
                    maxLines: 2,
                    style: GoogleFonts.inter(
                      fontSize: 13.5,
                      color: const Color(0xff5B5561),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
