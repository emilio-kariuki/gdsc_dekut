import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/announcement_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';

import '../../../../../blocs/app_functionality/announcement/announcement_cubit.dart';

class AnnouncementPage extends StatelessWidget {
  AnnouncementPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AnnouncementCubit()..getAllAnnoucements(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: AutoSizeText(
              "Annoucement Page",
              style: Theme.of(context).textTheme.titleMedium,
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
                              final data = state.announcements[index];
                              return AnnouncementCard(
                                announcement: data,
                                isAdmin: false,
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
