
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/services/providers/app_providers.dart';

class ImageView extends StatelessWidget {
  const ImageView({required this.title, required this.image});

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(size: 20, color: Colors.white),
        title: Text(
          title,
          overflow: TextOverflow.clip,
          maxLines: 2,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            icon: const Icon(
              Icons.more_vert,
              size: 20,
              color: Colors.white,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 'Save',
                child: Text(
                  'Save',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'Save') {
                AppProviders().downloadAndSaveImage(url: image, fileName: title);
              }
            },
          )
        ],
      ),
      body: Center(
        child: CachedNetworkImage(
          height: height * 0.35,
          width: width,
          placeholder: (context, url) {
            return Container(
                height: height * 0.35,
                width: width,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                )
                // border: Border.all(width: 0.4, color: Color(0xff666666)),

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
      ),
    );
  }
}
