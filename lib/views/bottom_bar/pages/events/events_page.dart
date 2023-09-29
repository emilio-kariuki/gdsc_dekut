import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/event/event_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/events_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';

class EventsPage extends StatelessWidget {
  EventsPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => EventCubit()..getAllEvents(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text("Events Page",
                style: Theme.of(context).textTheme.titleMedium),
          ),
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
                        onChanged: (value) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            context
                                .read<EventCubit>()
                                .searchEvent(query: value);
                          });
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          context.read<EventCubit>().searchEvent(query: value);
                          return null;
                        },
                        hint: "Search for event eg. Flutter",
                        close: () {
                          searchController.clear();
                          context.read<EventCubit>().getAllEvents();
                        }),
                    BlocBuilder<EventCubit, EventState>(
                      buildWhen: (previous, current) => current is EventSuccess,
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
                                  context.read<EventCubit>().getAllEvents();
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
                                          isAdmin: false,
                                          isPast: false,
                                        );
                                      },
                                    ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
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
