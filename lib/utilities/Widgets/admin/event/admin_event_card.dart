// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/clipboard/clipboard_cubit.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../data/services/providers/app_providers.dart';


class AdminOngoingEventCard extends StatelessWidget {
  AdminOngoingEventCard({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.about,
    required this.date,
    required this.time,
    required this.image,
    required this.function,
    required this.link,
    required this.venue,
    required this.organizers,
    required this.id,
    required this.completeFunction,
  });

  final String about;
  final String date;
  final double height;
  final String image;
  final String time;
  final String title;
  final double width;
  final String link;
  final String venue;
  final String organizers;
  final String id;
  final Function() function;
  final Function() completeFunction;

  void _showImageDialog(BuildContext context, String imageUrl, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Dialog(
            insetPadding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: height * 0.66,
                  ),
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Scaffold(
                    backgroundColor: Colors.grey[900],
                    bottomNavigationBar: Container(
                        height: height * 0.11,
                        width: width,
                        decoration: BoxDecoration(
                          border: const Border(
                              top: BorderSide(
                                  width: 0.4, color: Color(0xff666666))),
                          color: Colors.grey[900],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BlocProvider(
                              create: (context) => ClipboardCubit(),
                              child: Builder(builder: (context) {
                                return BlocBuilder<ClipboardCubit,
                                    ClipboardState>(
                                  builder: (context, state) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[800],
                                              shape: BoxShape.circle),
                                          child: IconButton(
                                            onPressed: () {
                                              BlocProvider.of<ClipboardCubit>(
                                                      context)
                                                  .copyToClipboard(text: link);
                                            },
                                            icon: Icon(
                                                state is Copied
                                                    ? Icons.check
                                                    : Icons.link,
                                                size: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                        AutoSizeText(
                                          state is Copied ? "Copied" : "Copy",
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              }),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Tooltip(
                              message: "Add event to calendar",
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    // padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      onPressed: () {
                                        AppProviders().openLink(link: link);
                                      },
                                      icon: const Icon(
                                          Icons.app_registration_rounded,
                                          size: 22,
                                          color: Colors.white),
                                    ),
                                  ),
                                  AutoSizeText(
                                    "Register",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Tooltip(
                              message: "Add event to calendar",
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    // padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      onPressed: () {
                                        // Providers().openLink(link: link);
                                      },
                                      icon: const Icon(Icons.calendar_month,
                                          size: 22, color: Colors.white),
                                    ),
                                  ),
                                  AutoSizeText(
                                    "Calendar",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  // padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      AppProviders().tweet(
                                          message:
                                              "Hello Devs👋 Iam happy to inform you that i will be joining todays sessions here is the link $link");
                                    },
                                    icon: const Icon(Icons.edit,
                                        size: 22, color: Colors.white),
                                  ),
                                ),
                                AutoSizeText(
                                  "Tweet",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  // padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      AppProviders().share(
                                          message:
                                              "The link to join $title is $link");
                                    },
                                    icon: const Icon(Icons.share,
                                        size: 22, color: Colors.white),
                                  ),
                                ),
                                AutoSizeText(
                                  "Share",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: AppBar(
                        backgroundColor: Colors.grey[900],
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        title: AutoSizeText(
                          title,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Semantics(
                          button: true,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, '/image_view',
                                  arguments: ImageArguments(
                                      title: title, image: image));
                            },
                            child: CachedNetworkImage(
                              height: height * 0.27,
                              width: width,
                              placeholder: (context, url) {
                                return Container(
                                    height: height * 0.27,
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
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) {
                                return AnimatedContainer(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.4,
                                        color: const Color(0xff666666)),
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
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Scaffold(
                            backgroundColor: Colors.grey[900],
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AutoSizeText(
                                    title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.location,
                                        height: height * 0.02,
                                        width: width * 0.02,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      AutoSizeText(
                                        venue,
                                        overflow: TextOverflow.clip,
                                        maxLines: 4,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(
                                    about,
                                    overflow: TextOverflow.clip,
                                    maxLines: 4,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ),
                            bottomNavigationBar: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                height: 40,
                                width: width * 0.7,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      organizers,
                                      overflow: TextOverflow.clip,
                                      maxLines: 4,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  AppImages.calendar,
                                                  height: height * 0.015,
                                                  width: width * 0.015,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                AutoSizeText(
                                                  date,
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xffffffff),
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              AppImages.clock,
                                              height: height * 0.015,
                                              width: width * 0.015,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            AutoSizeText(
                                              time,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () {
          _showImageDialog(context, image, title);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 106, 81, 81),
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Semantics(
                  button: true,
                  child: InkWell(
                    onTap: () {
                      _showImageDialog(context, image, title);
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
              ],
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
                  AutoSizeText(
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
                  AutoSizeText(
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
                  SizedBox(
                    height: 36,
                    width: width * 0.7,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 110,
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
                            onPressed:function,
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
                          width: 110,
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
                            onPressed: completeFunction,
                            child: AutoSizeText(
                              "Complete",
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
          ],
        ),
      ),
    );
  }
}
