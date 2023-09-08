import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/blocs/app_functionality/event/event_cubit.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/bottom_navigation/bottom_navigation_cubit.dart';

import 'package:gdsc_bloc/data/models/announcement_model.dart';
import 'package:gdsc_bloc/data/services/providers/notification_providers.dart';
import 'package:gdsc_bloc/utilities/Widgets/announcement_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/category_widget.dart';
import 'package:gdsc_bloc/utilities/Widgets/events_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/group_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/twitter_card.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../blocs/app_functionality/announcement/announcement_cubit.dart';
import '../../blocs/app_functionality/group/group_cubit.dart';
import '../../blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import '../../blocs/app_functionality/user/user_cubit.dart';
import '../../data/models/event_model.dart';
import '../../data/services/providers/app_providers.dart';
import '../../data/services/repositories/announcement_repository.dart';
import '../../data/services/repositories/event_repository.dart';

class EventPage extends StatelessWidget {
  EventPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventCubit>(
            create: (context) => EventCubit()..getAllEvents()),
        BlocProvider<GroupCubit>(
            create: (context) => GroupCubit()..getAllGroups()),
        BlocProvider<AnnouncementCubit>(
          create: (context) => AnnouncementCubit()..getAllAnnoucements(),
        ),
        BlocProvider<TwitterSpaceCubit>(
            create: (context) => TwitterSpaceCubit()..getAllTwitterSpaces()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark.copyWith(
              statusBarColor: Colors.white,
            ),
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<EventCubit>().getAllEvents();
                  context.read<UserCubit>().getUser();
                  context.read<AnnouncementCubit>().getAllAnnoucements();
                  return Future.value();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserProfileContainer(height: height, width: width),
                        const SizedBox(
                          height: 20,
                        ),
                        EventSearchContainer(),
                        const SizedBox(height: 10),
                        AnnouncementsContainerWidget(
                            height: height, width: width),
                        EventContainer(height: height, width: width),
                        TwitterSpaceContainer(height: height, width: width),
                        const CategoryWidget(
                          title: "Tech Groups",
                          location: '/tech_groups_page',
                        ),
                        GroupsContainerWidget(height: height, width: width)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class EventSearchContainer extends StatelessWidget {
  const EventSearchContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: InkWell(
        onTap: () {
          context.read<BottomNavigationCubit>().changeTab(2);
        },
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
                child: AutoSizeText(
                  "Search for event eg. flutter",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xff666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserProfileContainer extends StatelessWidget {
  const UserProfileContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<UserCubit, UserState>(
          buildWhen: (previous, current) => current is UserSuccess,
          builder: (context, state) {
            if (state is UserSuccess) {
              return Semantics(
                button: true,
                child: InkWell(
                  onTap: () {
                    context.read<BottomNavigationCubit>().changeTab(3);
                  },
                  child: CachedNetworkImage(
                    imageUrl: state.user.imageUrl! == "imageUrl"
                        ? AppImages.defaultImage
                        : state.user.imageUrl!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: height * 0.06,
                      width: height * 0.06,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 250, 100, 14),
                          width: 1,
                        ),
                        color: Colors.black12,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Semantics(
                button: true,
                child: InkWell(
                  onTap: () {
                    context.read<BottomNavigationCubit>().changeTab(3);
                  },
                  child: Container(
                    height: height * 0.06,
                    width: height * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 250, 100, 14),
                        width: 1,
                      ),
                      color: Colors.black12,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: SvgPicture.asset(
                      AppImages.person_white,
                      height: height * 0.03,
                      width: width * 0.03,
                    )),
                  ),
                ),
              );
            }
          },
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, current) => current is UserSuccess,
              builder: (context, state) {
                return AutoSizeText(
                  "Hello ${state is UserSuccess ? state.user.name : ""} 👋",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: const Color(0xff000000),
                  ),
                );
              },
            ),
            AutoSizeText(
              "Welcome to GDSC",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: const Color(0xff000000),
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            // Navigator.pushNamed(context, '/announcement_page');
            await NotificationProviders().showNormalNotification(
                message: "the test notification", title: "Test notification");
          },
          icon: const Icon(
            Icons.notifications_active_outlined,
            size: 24,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class AnnouncementsContainerWidget extends StatelessWidget {
  const AnnouncementsContainerWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AnnouncementModel>>(
      stream: AnnouncementRepository().getAnnoucements(),
      builder: (context, snapshot) {
        Widget output = const SizedBox.shrink();
        final data = snapshot.data;

        if (snapshot.hasData) {
          output = data!.isEmpty
              ? SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CategoryWidget(
                      title: "Announcements",
                      location: '/announcement_page',
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length > 2 ? 2 : data.length,
                      itemBuilder: (context, index) {
                        return AnnouncementCard(
                          id: data[index].id ?? "",
                          height: height,
                          width: width,
                          title: data[index].title ?? "",
                          name: data[index].name ?? "",
                          position: data[index].position ?? "",
                        );
                      },
                    ),
                  ],
                );
        }
        return output;
      },
    );
  }
}

class GroupsContainerWidget extends StatelessWidget {
  const GroupsContainerWidget({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupSuccess) {
          return SizedBox(
              height: height * 0.2,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 5,
                  );
                },
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: state.groups.length,
                itemBuilder: ((context, index) {
                  return Semantics(
                    button: true,
                    child: InkWell(
                      onTap: () async {
                        await AppProviders()
                            .openLink(link: state.groups[index].link!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: GroupContainer(
                          height: height,
                          width: width,
                          image: state.groups[index].imageUrl ??
                              AppImages.eventImage,
                          title: state.groups[index].title ?? "Group Name",
                          link: state.groups[index].link ??
                              "https://www.google.com",
                        ),
                      ),
                    ),
                  );
                }),
              ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class TwitterSpaceContainer extends StatelessWidget {
  const TwitterSpaceContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<TwitterSpaceCubit, TwitterSpaceState>(
        buildWhen: (previous, current) => current is TwitterSpaceSuccess,
        builder: (context, state) {
          if (state is TwitterSpaceLoading) {
            return SizedBox(
                height: height * 0.65,
                child: const Center(child: LoadingCircle()));
          } else if (state is TwitterSpaceSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CategoryWidget(
                  title: "Twitter Spaces",
                  location: '/twitter_page',
                ),
                state.spaces.isEmpty
                    ? Center(
                        child: NotFoundCard(
                          height: height,
                          width: width,
                          title: "No spaces found",
                          body:
                              "Incase of any twitter spaces\n they will displayed here",
                        ),
                      )
                    : SizedBox(
                        height: height * 0.23,
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.spaces.length,
                          itemBuilder: (context, index) {
                            final Timestamp startTime =
                                state.spaces[index].startTime;
                            final Timestamp endTime =
                                state.spaces[index].endTime;
                            final DateTime startDateTime = startTime.toDate();
                            final DateTime endDateTime = endTime.toDate();

                            final String startTimeString =
                                DateFormat.jm().format(startDateTime);
                            final String endTimeString =
                                DateFormat.jm().format(endDateTime);

                            final Timestamp timestamp =
                                state.spaces[index].startTime;

                            final DateTime dateTime = timestamp.toDate();

                            // final String dateString =
                            //     DateFormat.yMMMMd().format(dateTime);

                            final String dateString =
                                DateFormat.MMMEd().format(dateTime);
                            return TwitterCard(
                              time: dateTime,
                              width: width,
                              height: height,
                              title: state.spaces[index].title ?? "",
                              link: state.spaces[index].link ?? "",
                              image: state.spaces[index].image ??
                                  AppImages.eventImage,
                              startTime: startTimeString,
                              endTime: endTimeString,
                              date: dateString,
                            );
                          },
                        ),
                      ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
    });
  }
}

class EventContainer extends StatelessWidget {
  const EventContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel>>(
      stream: EventRepository().getEventStream(),
      builder: (context, snapshot) {
        Widget output = const SizedBox.shrink();
        final dataz = snapshot.data;

        if (snapshot.hasData) {
          output = dataz!.isEmpty
              ? SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CategoryWidget(
                      title: "Upcoming Events",
                      location: '/events_page',
                    ),
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: dataz.length > 2 ? 2 : dataz.length,
                      itemBuilder: (context, index) {
                        final data = dataz[index];
                        DateTime date = DateTime.parse(data.date!);
                        String formattedDate = DateFormat.MMMEd().format(date);
                        final duration = data.duration ?? 120;
                        final time = date.add(Duration(minutes: duration));
                        final startTime = DateFormat.jm().format(date);
                        final endTime = DateFormat.jm().format(time);
                        return EventCard(
                          width: width,
                          height: height,
                          title: data.title ?? "",
                          organizers: data.organizers ?? "",
                          venue: data.venue ?? "",
                          about: data.description ?? "",
                          date: formattedDate,
                          time: "${startTime} - ${endTime}",
                          image: data.imageUrl ?? AppImages.eventImage,
                          link: data.link ?? "",
                          function: () async {},
                        );
                      },
                    ),
                  ],
                );
        }
        return output;
      },
    );
  }
}
