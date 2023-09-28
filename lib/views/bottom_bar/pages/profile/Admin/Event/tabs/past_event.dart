import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/event/event_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';

import '../../../../../../../utilities/Widgets/events_card.dart';
import '../../../../../../../utilities/Widgets/search_container.dart';
import '../../../../../../../utilities/Widgets/search_result_button.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EventCubit()..getPastEvents()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
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
                    SearchContainer(
                      searchController: searchController,
                      hint: "Search for event eg. flutter",
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<EventCubit>()
                              .searchPastEvent(query: value);
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<EventCubit>()
                              .searchPastEvent(query: value);
                        }
                        return null;
                      },
                      close: () {
                        context.read<EventCubit>()..getPastEvents();
                        searchController.clear();
                      },
                    ),
                    BlocConsumer<EventCubit, EventState>(
                      buildWhen: ((previous, current) =>
                          current is EventSuccess),
                      listener: (context, state) {
                        if (state is EventStarted) {
                          tabController.animateTo(0);
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
                              SizedBox(
                                height: height * 0.01,
                              ),
                              SearchResultButton(
                                function: () {
                                  context.read<EventCubit>().getPastEvents();
                                  searchController.clear();
                                },
                              ),
                              state.events.isEmpty
                                  ? SearchNotFound()
                                  : ListView.builder(
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
                                          isPast: true,
                                        );
                                      },
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
