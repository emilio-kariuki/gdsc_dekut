
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.9;
    return Scaffold(
      
      appBar: AppBar(
        
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(size: 20, color: Colors.white),
        title: Text(
          title,
          overflow: TextOverflow.clip,
          maxLines: 2,
          style: Theme.of(context).textTheme.titleMedium,
          
        ),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            icon: const Icon(
              Icons.more_vert,
              size: 20,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                value: 'Save',
                child: Text(
                  'Save',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
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
          width: width,
          placeholder: (context, url) {
            return Container(
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
              height: height * 0.9,
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
