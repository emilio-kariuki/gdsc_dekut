import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/group/group_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Groups/edit_group_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../utilities/Widgets/admin/groups/admin_groups_card.dart';

class AppGroupsTab extends StatelessWidget {
  AppGroupsTab({super.key, required this.tabController});

  final searchController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final imageController = TextEditingController();

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GroupCubit()..getAllGroups(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              context.read<GroupCubit>().getAllGroups();
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
                          context.read<GroupCubit>().searchGroup(query: value);
                        });
                      },
                      onFieldSubmitted: (value) {
                        context.read<GroupCubit>().searchGroup(query: value);
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
                            context.read<GroupCubit>()..getAllGroups();
                            searchController.clear();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xff666666),
                            size: 18,
                          ),
                        ),
                        hintText: "Search for group eg. Flutter",
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
                    BlocConsumer<GroupCubit, GroupState>(
                      listener: (context, state) {
                        if (state is GroupError) {
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
                        if (state is GroupLoading) {
                          return SizedBox(
                            height: height * 0.65,
                            child: const Center(
                              child: LoadingCircle(),
                            ),
                          );
                        } else if (state is GroupSuccess) {
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
                                            .read<GroupCubit>()
                                            .getAllGroups();

                                        searchController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 18,
                                      ))
                                ],
                              ),
                              state.groups.isEmpty
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
                                          BlocConsumer<GroupCubit, GroupState>(
                                        listener: (context, state) {
                                          if (state is GroupFetched) {
                                            idController.text = state.group.id!;
                                            imageController.text =
                                                state.group.imageUrl!;
                                            idController.text = state.group.id!;
                                            nameController.text =
                                                state.group.title!;
                                            descriptionController.text =
                                                state.group.description!;
                                            linkController.text =
                                                state.group.link!;
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return EditGroupDialog(
                                                  descriptionController:
                                                      descriptionController,
                                                  tabController: tabController,
                                                  imageController:
                                                      imageController,
                                                  idController: idController,
                                                  nameController:
                                                      nameController,
                                                  linkController:
                                                      linkController,
                                                  context: context,
                                                );
                                              },
                                            );
                                          }
                                        },
                                        builder: (context, appState) {
                                          return state.groups.isEmpty
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
                                                          height: height * 0.2),
                                                      Text(
                                                        "groups not found",
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
                                              : ListView.separated(
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      height: height * 0.01,
                                                    );
                                                  },
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      state.groups.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return AdminGroupsCard(
                                                      id: state.groups[index]
                                                              .id ??
                                                          "",
                                                      about: state.groups[index]
                                                              .description ??
                                                          "",
                                                      width: width,
                                                      height: height,
                                                      title: state.groups[index]
                                                              .title ??
                                                          "",
                                                      link: state.groups[index]
                                                              .link ??
                                                          "",
                                                      image: state.groups[index]
                                                              .imageUrl ??
                                                          AppImages.eventImage,
                                                      function: () async {
                                                        BlocProvider.of<
                                                                    GroupCubit>(
                                                                context)
                                                            .getGroupById(
                                                                id: state
                                                                        .groups[
                                                                            index]
                                                                        .id ??
                                                                    "");
                                                      },
                                                      completeFunction: () {
                                                        BlocProvider.of<
                                                                    GroupCubit>(
                                                                context)
                                                            .deleteGroup(
                                                                id: state
                                                                        .groups[
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
