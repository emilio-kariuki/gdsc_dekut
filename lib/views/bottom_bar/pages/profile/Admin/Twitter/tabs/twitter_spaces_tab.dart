import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/twitter_space/twitter_space_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../utilities/Widgets/admin/twitter/admin_twitter_card.dart';
import '../edit_twitter_dialog.dart';

class AppSpaces extends StatelessWidget {
  AppSpaces({super.key, required this.tabController});

  final searchController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final linkController = TextEditingController();
  final imageController = TextEditingController();
  final dateController = TextEditingController();

  final TabController tabController;

  _editEventDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return EditTwitterDialog(
          tabController: tabController,
          imageController: imageController,
          idController: idController,
          nameController: nameController,
          startTimeController: startTimeController,
          endTimeController: endTimeController,
          linkController: linkController,
          dateController: dateController,
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TwitterSpaceCubit()..getAllTwitterSpaces(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              context.read<TwitterSpaceCubit>().getAllTwitterSpaces();
              return Future.value();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
      controller: searchController,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        // color: const Color(0xff000000),
      ),
      onChanged: (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          context.read<TwitterSpaceCubit>().searchTwitterSpace(queyr: value);
        });
      },
      onFieldSubmitted: (value) {
        context.read<TwitterSpaceCubit>().searchTwitterSpace(queyr: value);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xff666666),
          size: 18,
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.read<TwitterSpaceCubit>()..getAllTwitterSpaces();
            searchController.clear();
          },
          icon: const Icon(
            Icons.close,
            color: Color(0xff666666),
            size: 18,
          ),
        ),
        hintText: "Search for twitter space eg. Flutter",
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1.3,
          ),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          // color: const Color(0xff666666),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
                    BlocListener<TwitterSpaceCubit, TwitterSpaceState>(
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
                      child: BlocBuilder<TwitterSpaceCubit, TwitterSpaceState>(
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
                                        icon:  Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Theme.of(context).iconTheme.color,
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
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: BlocConsumer<TwitterSpaceCubit,
                                            TwitterSpaceState>(
                                          listener: (context, appState) {
                                            if (appState
                                                is TwitterSpaceFetched) {
                                              idController.text =
                                                  appState.space.id!;
                                              imageController.text =
                                                  appState.space.image!;
                                              idController.text =
                                                  appState.space.id!;
                                              nameController.text =
                                                  appState.space.title!;
                                              dateController.text = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          appState.space.date!
                                                              .millisecondsSinceEpoch)
                                                  .toString();
                                              startTimeController
                                                  .text = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          appState
                                                              .space
                                                              .startTime
                                                              .millisecondsSinceEpoch)
                                                  .toString();
                                              endTimeController.text = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          appState.space.endTime
                                                              .millisecondsSinceEpoch)
                                                  .toString();
                                              dateController.text = DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          appState.space.date!
                                                              .millisecondsSinceEpoch)
                                                  .toString();
                                              linkController.text =
                                                  appState.space.link!;
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return EditTwitterDialog(
                                                    dateController:
                                                        dateController,
                                                    tabController:
                                                        tabController,
                                                    imageController:
                                                        imageController,
                                                    idController: idController,
                                                    nameController:
                                                        nameController,
                                                    startTimeController:
                                                        startTimeController,
                                                    linkController:
                                                        linkController,
                                                    context: context,
                                                    endTimeController:
                                                        endTimeController,
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          builder: (context, appState) {
                                            return state.spaces.isEmpty
                                                ? SizedBox(
                                                    height: height * 0.5,
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Lottie.asset(
                                                            AppImages.oops,
                                                            height:
                                                                height * 0.2),
                                                        Text(
                                                          "spaces not found",
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xff666666),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  )
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        state.spaces.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final Timestamp
                                                          startTime = state
                                                              .spaces[index]
                                                              .startTime;
                                                      final Timestamp endTime =
                                                          state.spaces[index]
                                                              .endTime;
                                                      final DateTime
                                                          startDateTime =
                                                          startTime.toDate();
                                                      final DateTime
                                                          endDateTime =
                                                          endTime.toDate();

                                                      final String
                                                          startTimeString =
                                                          DateFormat.jm().format(
                                                              startDateTime);
                                                      final String
                                                          endTimeString =
                                                          DateFormat.jm()
                                                              .format(
                                                                  endDateTime);

                                                      final Timestamp
                                                          timestamp = state
                                                              .spaces[index]
                                                              .startTime;

                                                      final DateTime dateTime =
                                                          timestamp.toDate();
                                                      final String dateString =
                                                          DateFormat.MMMEd()
                                                              .format(dateTime);
                                                      return AdminTwitterCard(
                                                        date: dateString,
                                                        startTime:
                                                            startTimeString,
                                                        id: state.spaces[index]
                                                                .id ??
                                                            "",
                                                        endTime: endTimeString,
                                                        width: width,
                                                        height: height,
                                                        title: state
                                                                .spaces[index]
                                                                .title ??
                                                            "",
                                                        link: state
                                                                .spaces[index]
                                                                .link ??
                                                            "",
                                                        image: state
                                                                .spaces[index]
                                                                .image ??
                                                            AppImages
                                                                .eventImage,
                                                        function: () async {
                                                          BlocProvider.of<
                                                                      TwitterSpaceCubit>(
                                                                  context)
                                                              .getTwitterSpaceById(
                                                                  id: state
                                                                          .spaces[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                        },
                                                        completeFunction: () {
                                                          BlocProvider.of<
                                                                      TwitterSpaceCubit>(
                                                                  context)
                                                              .deleteTwitterSpace(
                                                                  id: state
                                                                          .spaces[
                                                                              index]
                                                                          .id ??
                                                                      "");
                                                        },
                                                      );
                                                    },
                                                  );
                                          },
                                        ),
                                      )
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
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
