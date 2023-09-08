import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/announcement/announcement_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/admin_announcements_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/profile/Admin/Announcements/edit_announcement_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AdminAnnouncementsTab extends StatelessWidget {
  AdminAnnouncementsTab({
    super.key,
  });
  final searchController = TextEditingController();
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final positionController = TextEditingController();
  final nameController = TextEditingController();

  _editEventDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return EditAnnouncementDialog(
          idController: idController,
          nameController: nameController,
          titleController: titleController,
          positionController: positionController,
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
          create: (context) => AnnouncementCubit()..getAllAnnoucements(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<AnnouncementCubit>(context).getAllAnnoucements();
              return Future.value();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                                      context
                                          .read<AnnouncementCubit>()
                                          .searchAnnouncement(query: value);
                                    },
                                    decoration: InputDecoration(
                                      hintText:
                                          "Search for announcement eg. Flutter",
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
                        SizedBox(
                          height: 49,
                          // width: 49,
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AnnouncementCubit>()
                                  .getAllAnnoucements();
                              searchController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Icon(
                              Icons.refresh,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnnouncementResultContainer(height: height, searchController: searchController, idController: idController, nameController: nameController, titleController: titleController, positionController: positionController, width: width)
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

class AnnouncementResultContainer extends StatelessWidget {
  const AnnouncementResultContainer({
    super.key,
    required this.height,
    required this.searchController,
    required this.idController,
    required this.nameController,
    required this.titleController,
    required this.positionController,
    required this.width,
  });

  final double height;
  final TextEditingController searchController;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController positionController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnnouncementCubit,AnnouncementState>(
       listener: (context, state) {
        if (state is AnnouncementFailure) {
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
        if (state is AnnouncementLoading) {
          return SizedBox(
            height: height * 0.65,
            child: const Center(
              child: LoadingCircle(),
            ),
          );
        } else if (state is AnnouncementSuccess) {
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
                        context.read<AnnouncementCubit>()
                            .getAllAnnoucements();
                        searchController.clear();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.black,
                      ))
                ],
              ),
              state.announcements.isEmpty
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
                      child: BlocConsumer<AnnouncementCubit,
                          AnnouncementState>(
                        listener: (context, appState) {
                          if (appState
                              is AnnouncementFetched) {
                            idController.text =
                                appState.announcement.id!;
                            nameController.text =
                                appState.announcement.name!;
                            titleController.text =
                                appState.announcement.title!;
                            positionController.text = appState
                                .announcement.position!;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return EditAnnouncementDialog(
                                  idController: idController,
                                  nameController:
                                      nameController,
                                  titleController:
                                      titleController,
                                  positionController:
                                      positionController,
                                  context: context,
                                );
                              },
                            );
                          }
                        },
                        builder: (context, appState) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                state.announcements.length,
                            itemBuilder: (context, index) {
                              return AnnouncementAdminCard(
                                name: state
                                        .announcements[index]
                                        .name ??
                                    "",
                                id: state.announcements[index]
                                        .id ??
                                    "",
                                width: width,
                                height: height,
                                title: state
                                        .announcements[index]
                                        .title ??
                                    "",
                                position: state
                                        .announcements[index]
                                        .position ??
                                    "",
                                editFunction: () async {
                                  BlocProvider.of<
                                              AnnouncementCubit>(
                                          context)
                                      .getAnnouncementById(
                                          id: state
                                                  .announcements[
                                                      index]
                                                  .id ??
                                              "");
                                },
                                deleteFunction: () {
                                  BlocProvider.of<
                                             AnnouncementCubit>(
                                          context)
                                      .deleteAnnouncement(
                                          id: state
                                                  .announcements[
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
    );
  }
}
