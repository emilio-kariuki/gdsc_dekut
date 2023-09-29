import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/announcement/announcement_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../utilities/Widgets/announcement_card.dart';
import '../../../../../../../utilities/Widgets/search_not_found.dart';

class AdminAnnouncementsTab extends StatelessWidget {
  AdminAnnouncementsTab({
    super.key,
  });
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AnnouncementCubit()..getAllAnnoucements(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
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
                    TextFormField(
                      controller: searchController,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        // color: const Color(0xff000000),
                      ),
                      onChanged: (value) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          context
                              .read<AnnouncementCubit>()
                              .searchAnnouncement(query: value);
                        });
                      },
                      onFieldSubmitted: (value) {
                        context
                            .read<AnnouncementCubit>()
                            .searchAnnouncement(query: value);
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
                            context.read<AnnouncementCubit>()
                              ..getAllAnnoucements();
                            searchController.clear();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xff666666),
                            size: 18,
                          ),
                        ),
                        hintText: "Search for announcement eg. Flutter",
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
                    BlocConsumer<AnnouncementCubit, AnnouncementState>(
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
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Search Results",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      // color: const Color(0xff000000),
                                    ),
                                  ),
                                  IconButton(
                                      style: IconButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<AnnouncementCubit>()
                                            .getAllAnnoucements();
                                        searchController.clear();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 18,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ))
                                ],
                              ),
                              state.announcements.isEmpty
                                  ? SearchNotFound()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: BlocConsumer<AnnouncementCubit,
                                          AnnouncementState>(
                                        listener: (context, appState) {},
                                        builder: (context, appState) {
                                          return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                state.announcements.length,
                                            itemBuilder: (context, index) {
                                              return AnnouncementCard(
                                                announcement:
                                                    state.announcements[index],
                                                isAdmin: true,
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
