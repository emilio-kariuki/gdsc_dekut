// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/event/event_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/events_card.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../utilities/Widgets/search_container.dart';

class UpComingEvents extends StatelessWidget {
  UpComingEvents({super.key, required this.tabController});

  final TabController tabController;

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EventCubit()..getAllEvents(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
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
                    SearchContainer(
                      searchController: searchController,
                      hint: "Search for event eg. flutter",
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context.read<EventCubit>().searchEvent(query: value);
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<EventCubit>().searchEvent(query: value);
                        }
                        return null;
                      },
                      close: () {
                        context.read<EventCubit>()..getAllEvents();
                        searchController.clear();
                      },
                    ),
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
                              SearchResultButton(
                                function: () {
                                  BlocProvider.of<EventCubit>(context)
                                      .getAllEvents();
                                  searchController.clear();
                                },
                              ),
                              state.events.isEmpty
                                  ? SearchNotFound()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child:
                                          BlocConsumer<EventCubit, EventState>(
                                        listener: (context, appState) {
                                          if (appState is EventCompleted) {
                                            context
                                                .read<EventCubit>()
                                                .getAllEvents();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    const Color(0xFF085D06),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                content: Center(
                                                  child: Text(
                                                    "Event Completed",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
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
                                              return EventCard(
                                                event: data,
                                                isAdmin: true,
                                                isPast: false,
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
    return TextFormField(
      controller: searchController,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        // color: const Color(0xff000000),
      ),
      onChanged: (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          context.read<EventCubit>().searchEvent(query: value);
        });
      },
      onFieldSubmitted: (value) {
        context.read<EventCubit>().searchEvent(query: value);
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
            context.read<EventCubit>()..getAllEvents();
            searchController.clear();
          },
          icon: const Icon(
            Icons.close,
            color: Color(0xff666666),
            size: 18,
          ),
        ),
        hintText: "Search for event eg. Flutter",
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
    );
  }
}
