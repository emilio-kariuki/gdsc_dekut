// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:dio/dio.dart';

class DialogImage extends StatelessWidget {
  const DialogImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
    required this.title,
  });

  final String image;
  final double height;
  final double width;
  final String title;

  Future<void> downloadAndSaveImage(
      BuildContext context, String url, String fileName) async {
    Directory directory = Directory('/storage/emulated/0/Download');

    final filePath = '${directory.path}/$fileName.png';
    final dio = Dio();

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      final file = File(filePath);
      await file.writeAsBytes(response.data);
      print('Image saved');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Could not save image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.32,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Scaffold(
            bottomNavigationBar: Container(
              height: height * 0.045,
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text(
                title,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: GoogleFonts.inter(
                  fontSize: 13,
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
                      downloadAndSaveImage(context, image, title);
                    }
                  },
                )
              ],
            ),
            body: Semantics(
              button: true,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/image_view',
                      arguments: ImageArguments(title: title, image: image));
                },
                child: CachedNetworkImage(
                  height: height * 0.3,
                  width: width,
                  placeholder: (context, url) {
                    return Container(
                        height: height * 0.3,
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
          )),
    );
  }
}
