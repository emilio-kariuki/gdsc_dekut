import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/event/event_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/profile/Admin/Event/edit_event_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/models/event_model.dart';
import '../../../../utilities/Widgets/admin/event/admin_past_event.dart';

class PastEvents extends StatelessWidget {
  PastEvents({super.key, required this.tabController});

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventCubit()..getPastEvents()
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      context.read<EventCubit>().getAllEvents();
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
                    EventSearchContainerWidget(
                        searchController: searchController),

                    BlocConsumer<EventCubit, EventState>(
                      listener: (context, state) {
                        if (state is EventStarted) {
                          tabController.animateTo(0);
                        }
                        if (state is EventDeleted) {
                          tabController.animateTo(0);
                        }
                        if (state is EventFetched) {
                          idController.text = state.event.id!;
                          imageController.text = state.event.imageUrl!;
                          nameController.text = state.event.title!;
                          descriptionController.text = state.event.description!;
                          venueController.text = state.event.venue!;
                          organizersController.text = state.event.organizers!;
                          linkController.text = state.event.link!;
                          dateController.text = state.event.date!;
                        }
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
                                        context
                                            .read<EventCubit>()
                                            .getPastEvents();
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
                                            "Events not found",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: const Color(0xff666666),
                                            ),
                                          ),
                                        ],
                                      )),
                                    )
                                  : EventResultListView(
                                      width: width,
                                      height: height,
                                      events: state.events,
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
                      context.read<EventCubit>().searchEvent(query: value);
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
              context.read<EventCubit>().getPastEvents();
              searchController.clear();
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

class EventResultListView extends StatelessWidget {
  const EventResultListView({
    super.key,
    required this.width,
    required this.height,
    required this.events,
  });

  final double width;
  final double height;
  final List<EventModel> events;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final data = events[index];
        DateTime date = DateTime.parse(data.date!);
        String formattedDate = DateFormat.MMMEd().format(date);
        final duration = data.duration ?? 120;
        final time = date.add(Duration(minutes: duration));
        final startTime = DateFormat.jm().format(date);
        final endTime = DateFormat.jm().format(time);
        return AdminPastEventCard(
          id: events[index].id ?? "",
          width: width,
          height: height,
          title: events[index].title ?? "",
          about: events[index].description ?? "",
          date: formattedDate,
          organizers: events[index].organizers ?? "",
          venue: events[index].venue ?? "",
          link: events[index].link ?? "",
          time: "//${startTime} - ${endTime}",
          image: events[index].imageUrl ?? AppImages.eventImage,
          function: () async {
            showDialog(
                context: context,
                builder: (_) {
                  return BlocProvider(
                    create: (context) =>
                        EventCubit()..getEventById(id: events[index].id!),
                    child: EditEventDialog(
                      context: context,
                      id: events[index].id!,
                    ),
                  );
                });
            // BlocProvider.of<EventCubit>(context)
            //     .getEventById(id: events[index].id!);
          },
          completeFunction: () {
            BlocProvider.of<EventCubit>(context)
                .startEventById(id: events[index].id!);
          },
          deleteFunction: () {
            BlocProvider.of<EventCubit>(context)
                .deleteEvent(id: events[index].id!);
          },
        );
      },
    );
  }
}
