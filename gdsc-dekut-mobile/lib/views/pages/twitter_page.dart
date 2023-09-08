import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/twitter_card.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TwitterPage extends StatelessWidget {
  TwitterPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => TwitterSpaceCubit()..getAllTwitterSpaces(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Twitter Spaces",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      context.read<TwitterSpaceCubit>().getAllTwitterSpaces();
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //           height: 20,
                    //         ),
                    Container(
                      height: 49,
                      padding: const EdgeInsets.only(left: 15, right: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.grey[500]!,
                            width: 0.8,
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            color: Color(0xff666666),
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: const Color(0xff000000),
                              ),
                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  context
                                      .read<TwitterSpaceCubit>()
                                      .searchTwitterSpace(queyr: value);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Search for space eg. Flutter",
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: const Color(0xff666666),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    BlocConsumer<TwitterSpaceCubit, TwitterSpaceState>(
                      listener: (context, state) {
                        if (state is TwitterSpaceError) {
                          Timer(
                            const Duration(milliseconds: 300),
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xffEB5757),
                                content: Text(state.message),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is TwitterSpaceLoading) {
                          return SizedBox(
                            height: height * 0.65,
                            child: const Center(
                              child: LoadingCircle(),
                            ),
                          );
                        } else if (state is TwitterSpaceSuccess) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Search Results",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                    ),
                                  ),
                                  IconButton(
                                      style: IconButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<TwitterSpaceCubit>()
                                            .getAllTwitterSpaces();
                                        searchController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              state.spaces.isEmpty
                                  ? SizedBox(
                                      height: height * 0.5,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Lottie.asset(AppImages.oops,
                                              height: height * 0.2),
                                          Text(
                                            "Search not found",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: const Color(0xff666666),
                                            ),
                                          ),
                                        ],
                                      )),
                                    )
                                  : GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 4,
                                              childAspectRatio: 0.65),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.spaces.length,
                                      itemBuilder: (context, index) {
                                        final Timestamp startTime =
                                            state.spaces[index].startTime;
                                        final Timestamp endTime =
                                            state.spaces[index].endTime;
                                        final DateTime startDateTime =
                                            startTime.toDate();
                                        final DateTime endDateTime =
                                            endTime.toDate();

                                        final String startTimeString =
                                            DateFormat.jm()
                                                .format(startDateTime);
                                        final String endTimeString =
                                            DateFormat.jm().format(endDateTime);

                                        final Timestamp timestamp =
                                            state.spaces[index].startTime;

                                        final DateTime dateTime =
                                            timestamp.toDate();

                                        // final String dateString =
                                        //     DateFormat.yMMMMd().format(dateTime);

                                        final String dateString =
                                            DateFormat.MMMEd().format(dateTime);
                                        return TwitterCard(
                                          time: dateTime,
                                          width: width,
                                          height: height,
                                          title:
                                              state.spaces[index].title ?? "",
                                          image: state.spaces[index].image ??
                                              AppImages.eventImage,
                                          startTime: startTimeString,
                                          endTime: endTimeString,
                                          date: dateString,
                                          link: state.spaces[index].link ?? "",
                                        );
                                      },
                                    ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
