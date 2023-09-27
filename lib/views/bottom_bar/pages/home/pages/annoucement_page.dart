import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/announcement_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../blocs/app_functionality/announcement/announcement_cubit.dart';

class AnnouncementPage extends StatelessWidget {
  AnnouncementPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AnnouncementCubit()..getAllAnnoucements(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: AutoSizeText(
              "Annoucement Page",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      context.read<AnnouncementCubit>().getAllAnnoucements();
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BlocConsumer<AnnouncementCubit, AnnouncementState>(
                    buildWhen: (previous, current) =>
                        current is AnnouncementSuccess,
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
                            child: const Center(child: LoadingCircle()));
                      } else if (state is AnnouncementSuccess) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.announcements.length,
                            itemBuilder: (context, index) {
                              return AnnouncementCard(
                                id: state.announcements[index].id ?? "",
                                height: height,
                                width: width,
                                title: state.announcements[index].title ?? "",
                                name: state.announcements[index].name ?? "",
                                position:
                                    state.announcements[index].position ?? "",
                              );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
