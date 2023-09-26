import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/minimal_functonality/clipboard/clipboard_cubit.dart';
import '../../data/services/providers/app_providers.dart';

class EventCard extends StatelessWidget {
  const EventCard({
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
    required this.numberOfDays,
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
  final int numberOfDays;
  final Function() function;

  void _showImageDialog(BuildContext context, String imageUrl, String title) {
    final height = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: height,
          constraints: BoxConstraints.loose(
            Size(
              width,
              height * 0.68,
            ),
          
          ),
          child: Scaffold(
            backgroundColor: Colors.grey[900],
            bottomNavigationBar: Container(
                height: height * 0.11,
                width: width,
                decoration: BoxDecoration(
                  border: const Border(
                      top: BorderSide(
                          width: 0.4,
                          color: Color.fromARGB(255, 101, 101, 101))),
                ),
                child: DialogButtonContainer(
                  link: link,
                  title: title,
                )),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey[900],
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
                          arguments:
                              ImageArguments(title: title, image: image));
                    },
                    child: CachedNetworkImage(
                      height: height * 0.27,
                      width: width,
                      placeholder: (context, url) {
                        return Container(
                            height: height * 0.27,
                            width: width,
                            decoration: const BoxDecoration());
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
                          height: height * 0.27,
                          width: width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.4,
                            ),
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
                  height: height * 0.011,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Scaffold(
                    backgroundColor: Colors.grey[900],
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.011,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.location,
                                      height: height * 0.013,
                                      width: width * 0.013,
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
                              ),
                              AutoSizeText(
                                organizers,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 45,
                        width: width * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.calendar,
                                          height: height * 0.017,
                                          width: width * 0.017,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        AutoSizeText(
                                          date,
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
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
                                      height: height * 0.017,
                                      width: width * 0.017,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    AutoSizeText(
                                      time,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.15,
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
                SizedBox(
                  height: height * 0.02,
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
                              width: 0.4,
                            ),
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
                  SizedBox(
                    height: height * 0.01,
                  ),
                  AutoSizeText(title,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                  // SizedBox(
                  //   height: height * 0.006,
                  // ),
                  // numberOfDays == 0 || numberOfDays == 1
                  //     ? Row(
                  //         children: [
                  //           Container(
                  //             height: 10,
                  //             width: 10,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               color: numberOfDays == 1
                  //                   ? Colors.red
                  //                   : Colors.green,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: width * 0.01,
                  //           ),
                  //           AutoSizeText(
                  //             numberOfDays == 1
                  //                 ? "Tomorrow"
                  //                 : numberOfDays == 0
                  //                     ? "Today"
                  //                     : "",
                  //             overflow: TextOverflow.clip,
                  //             maxLines: 4,
                  //             style: GoogleFonts.inter(
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.bold,
                  //               color: numberOfDays == 1
                  //                   ? Colors.red
                  //                   : Colors.green,
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //     : const SizedBox.shrink(),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  Text(
                    about,
                    maxLines: 2,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 122, 121, 121)),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  SizedBox(
                    height: 30,
                    width: width * 0.7,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppImages.calendar,
                                  height: height * 0.02,
                                  width: width * 0.02,
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                AutoSizeText(
                                  date,
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff666666)),
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
                              height: height * 0.02,
                              width: width * 0.02,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            AutoSizeText(
                              time,
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff666666)),
                            ),
                          ],
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

class DialogButtonContainer extends StatelessWidget {
  const DialogButtonContainer({
    super.key,
    required this.link,
    required this.title,
  });

  final String link;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocProvider(
          create: (context) => ClipboardCubit(),
          child: Builder(builder: (context) {
            return BlocBuilder<ClipboardCubit, ClipboardState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 78, 78, 78),
                          shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<ClipboardCubit>(context)
                              .copyToClipboard(text: link);
                        },
                        icon: Icon(state is Copied ? Icons.check : Icons.link,
                            size: 22, color: Colors.white),
                      ),
                    ),
                    AutoSizeText(
                      state is Copied ? "Copied" : "Copy",
                      style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
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
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 78, 78, 78),
                ),
                child: IconButton(
                  onPressed: () {
                    AppProviders().openLink(link: link);
                  },
                  icon: const Icon(Icons.app_registration_rounded,
                      size: 22, color: Colors.white),
                ),
              ),
              AutoSizeText(
                "Register",
                style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
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
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 78, 78, 78),
              ),
              child: IconButton(
                onPressed: () {
                  AppProviders().tweet(
                      message:
                          "Hello Devs👋 Iam happy to inform you that i will be joining todays sessions here is the link $link");
                },
                icon: const Icon(Icons.edit, size: 22, color: Colors.white),
              ),
            ),
            AutoSizeText(
              "Tweet",
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 78, 78, 78),
              ),
              child: IconButton(
                onPressed: () {
                  AppProviders()
                      .share(message: "$title and the link is : $link");
                },
                icon: const Icon(Icons.share, size: 22, color: Colors.white),
              ),
            ),
            AutoSizeText(
              "Share",
              style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            )
          ],
        )
      ],
    );
  }
}
