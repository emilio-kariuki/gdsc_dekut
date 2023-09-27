import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/event/event_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Event/edit_event_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../utilities/Widgets/admin/event/admin_event_card.dart';

class UpComingEvents extends StatelessWidget {
  UpComingEvents({super.key, required this.tabController});

  final searchController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final venueController = TextEditingController();
  final dateController = TextEditingController();
  final linkController = TextEditingController();
  final organizersController = TextEditingController();
  final imageController = TextEditingController();
  final TabController tabController;

  // _editEventDialog(
  //   BuildContext context,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return EditEventDialog(
  //         tabController: tabController,
  //         imageController: imageController,
  //         idController: idController,
  //         nameController: nameController,
  //         descriptionController: descriptionController,
  //         venueController: venueController,
  //         organizersController: organizersController,
  //         linkController: linkController,
  //         dateController: dateController,
  //         context: context,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventCubit()..getAllEvents(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () {
              context.read<EventCubit>().getAllEvents();
              return Future.value();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventSearchContainerWidget(
                        searchController: searchController),
                    BlocConsumer<EventCubit, EventState>(
                      listener: (context, state) {
                        if (state is EventError) {
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
                        if (state is EventLoading) {
                          return SizedBox(
                            height: height * 0.65,
                            child: const Center(
                              child: LoadingCircle(),
                            ),
                          );
                        } else if (state is EventSuccess) {
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
                                        BlocProvider.of<EventCubit>(context)
                                            .getAllEvents();
                                        searchController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              state.events.isEmpty
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
                                      child:
                                          BlocConsumer<EventCubit, EventState>(
                                        listener: (context, appState) {
                                          if (appState is EventCompleted) {
                                            tabController.animateTo(1);
                                          }
                                          if (appState is EventStarted) {
                                            tabController.animateTo(0);
                                          }
                                          if (appState is EventFetched) {
                                            idController.text =
                                                appState.event.id!;
                                            imageController.text =
                                                appState.event.imageUrl!;
                                            nameController.text =
                                                appState.event.title!;
                                            descriptionController.text =
                                                appState.event.description!;
                                            venueController.text =
                                                appState.event.venue!;
                                            organizersController.text =
                                                appState.event.organizers!;
                                            linkController.text =
                                                appState.event.link!;
                                            dateController.text =
                                                appState.event.date!;

                                            // BlocProvider.value(
                                            //   value:
                                            //       BlocProvider.of<EventCubit>(
                                            //           context),
                                            //   child: _editEventDialog(context),
                                            // );
                                          }
                                          if (appState is EventCompleted) {
                                            context
                                                .read<EventCubit>()
                                                .getAllEvents();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    const Color(0xFF085D06),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Center(
                                                  child: Text(
                                                    "Event Completed",
                                                    style: GoogleFonts.inter(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        builder: (context, appState) {
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state.events.length,
                                            itemBuilder: (context, index) {
                                              final data = state.events[index];
                                              DateTime date =
                                                  DateTime.parse(data.date!);
                                              String formattedDate =
                                                  DateFormat.MMMEd()
                                                      .format(date);
                                              final duration =
                                                  data.duration ?? 120;
                                              final time = date.add(
                                                  Duration(minutes: duration));
                                              final startTime =
                                                  DateFormat.jm().format(date);
                                              final endTime =
                                                  DateFormat.jm().format(time);
                                              return AdminOngoingEventCard(
                                                id: state.events[index].id ??
                                                    "",
                                                width: width,
                                                height: height,
                                                title:
                                                    state.events[index].title ??
                                                        "",
                                                about: state.events[index]
                                                        .description ??
                                                    "",
                                                date: formattedDate,
                                                organizers: state.events[index]
                                                        .organizers ??
                                                    "",
                                                venue:
                                                    state.events[index].venue ??
                                                        "",
                                                link:
                                                    state.events[index].link ??
                                                        "",
                                                time:
                                                    "${startTime} - ${endTime}",
                                                image: state.events[index]
                                                        .imageUrl ??
                                                    AppImages.eventImage,
                                                function: () async {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return BlocProvider(
                                                          create: (context) =>
                                                              EventCubit()
                                                                ..getEventById(
                                                                    id: state
                                                                        .events[
                                                                            index]
                                                                        .id!),
                                                          child:
                                                              EditEventDialog(
                                                            context: context,
                                                            id: state
                                                                .events[index]
                                                                .id!,
                                                          ),
                                                        );
                                                      });
                                                },
                                                completeFunction: () {
                                                  BlocProvider.of<EventCubit>(
                                                          context)
                                                      .completeEventById(
                                                          id: state
                                                              .events[index]
                                                              .id!);
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

class EventSearchContainerWidget extends StatelessWidget {
  const EventSearchContainerWidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                      context.read<EventCubit>().searchEvent(
                            query: value,
                          );
                    },
                    decoration: InputDecoration(
                      hintText: "Search for event eg. Flutter",
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
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          height: 49,
          width: 49,
          child: ElevatedButton(
            onPressed: () {
              context.read<EventCubit>().getAllEvents();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                  side: const BorderSide(width: 0.4, color: Colors.black)),
            ),
            child: const Icon(
              Icons.refresh,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
