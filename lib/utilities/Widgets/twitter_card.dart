import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../blocs/minimal_functonality/clipboard/clipboard_cubit.dart';
import '../../data/models/twitter_model.dart';
import '../../data/services/providers/app_providers.dart';

class TwitterCard extends StatelessWidget {
  const TwitterCard({
    super.key,
    required this.twitter,
  });

  final TwitterModel twitter;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final Timestamp startTime = twitter.startTime;
    final Timestamp endTime = twitter.endTime;
    // final DateTime startDateTime = startTime.toDate();
    // final DateTime endDateTime = endTime.toDate();

    // final String startTimeString = DateFormat.jm().format(startDateTime);
    // final String endTimeString = DateFormat.jm().format(endDateTime);

    final Timestamp timestamp = twitter.startTime;

    final DateTime dateTime = timestamp.toDate();

    final String dateString = DateFormat.MMMEd().format(dateTime);
    return SizedBox(
      width: width * 0.34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                showSpaceDialog(context: context, twitter: twitter);
              },
              child: CachedNetworkImage(
                height: height * 0.125,
                width: width * 0.33,
                placeholder: (context, url) {
                  return Container(
                    height: height * 0.12,
                    width: width * 0.33,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 243, 243, 243),
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                errorWidget: ((context, url, error) {
                  return const Icon(
                    Icons.error,
                    size: 20,
                    color: Colors.red,
                  );
                }),
                imageUrl: twitter.image!,
                fit: BoxFit.fitHeight,
                imageBuilder: (context, imageProvider) {
                  return AnimatedContainer(
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Scaffold(
              bottomNavigationBar: Text(
                "${startTime} - ${endTime}",
                overflow: TextOverflow.clip,
                maxLines: 1,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                  color: Colors.black,

                  // decoration: TextDecoration.lineThrough
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.28,
                    child: Text(
                      twitter.title!,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 13.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    dateString,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: DateTime.now().isAfter(dateTime)
                          ? Colors.red
                          : Color.fromARGB(255, 42, 192, 8),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void showSpaceDialog(
    {required BuildContext context, required TwitterModel twitter}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Scaffold(
                backgroundColor: Colors.black,
                bottomNavigationBar: Container(
                    height: height * 0.11,
                    width: width,
                    decoration: BoxDecoration(
                      border: const Border(
                          top:
                              BorderSide(width: 0.4, color: Color(0xff666666))),
                    ),
                    child: Row(
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
                                      margin: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[800],
                                          shape: BoxShape.circle),
                                      child: IconButton(
                                        onPressed: () {
                                          BlocProvider.of<ClipboardCubit>(
                                                  context)
                                              .copyToClipboard(
                                                  text: twitter.link!);
                                        },
                                        icon: Icon(
                                            state is Copied
                                                ? Icons.check
                                                : Icons.link,
                                            size: 22,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      state is Copied ? "Copied" : "Copy",
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
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
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  AppProviders().openLink(link: twitter.link!);
                                },
                                icon: const Icon(Icons.join_full,
                                    size: 22, color: Colors.white),
                              ),
                            ),
                            Text(
                              "Join",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  AppProviders().tweet(
                                      message:
                                          "Hello Devs👋 Iam happy to inform you that i will be joining todays sessions here is the link ${twitter.link}");
                                },
                                icon: const Icon(Icons.edit,
                                    size: 22, color: Colors.white),
                              ),
                            ),
                            Text(
                              "Tweet",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
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
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  AppProviders().share(
                                      message:
                                          "The link to join ${twitter.title} is ${twitter.link}");
                                },
                                icon: const Icon(Icons.share,
                                    size: 22, color: Colors.white),
                              ),
                            ),
                            Text(
                              "Share",
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: AppBar(
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      twitter.title!,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                          ))
                    ],
                  ),
                ),
                body: Semantics(
                  button: true,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/image_view',
                          arguments: ImageArguments(
                              title: twitter.title!, image: twitter.image!));
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
                      imageUrl: twitter.image!,
                      fit: BoxFit.cover,
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
        ),
      );
    },
  );
}
