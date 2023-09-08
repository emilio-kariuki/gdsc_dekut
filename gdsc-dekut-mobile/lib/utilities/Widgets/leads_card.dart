import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadsCard extends StatelessWidget {
  const LeadsCard({
    super.key,
    required this.width,
    required this.height,
    required this.image,
    required this.title,
    required this.role,
  });

  final double width;
  final double height;
  final String image;
  final String title;
  final String role;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: height * 0.12,
            width: width * 0.33,
            placeholder: (context, url) {
              return Container(
                height: height * 0.12,
                width: width * 0.33,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 243, 243),
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
                  border:
                      Border.all(width: 0.4, color: const Color(0xff666666)),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.28,
                      child: Text(
                        title,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      role,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
