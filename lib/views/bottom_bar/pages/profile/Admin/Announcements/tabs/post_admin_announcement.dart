// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../blocs/app_functionality/announcement/announcement_cubit.dart';
import '../../../../../../../data/services/providers/notification_providers.dart';

class AdminAnnouncementPostPage extends StatelessWidget {
  AdminAnnouncementPostPage({super.key, required this.tabController});

  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnouncementCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocConsumer<AnnouncementCubit, AnnouncementState>(
              listener: (context, state) {
                if (state is AnnoucementCreated) {
                  Timer(
                    const Duration(milliseconds: 300),
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color(0xFF0C7319),
                        content: Text("Announcement Sent Successfully"),
                      ),
                    ),
                  );

                  NotificationProviders().createPushNotification(
                      image: "https://i.imgur.com/2nCt3Sbl.jpg",
                      title: titleController.text,
                      message:
                          "${nameController.text}-${positionController.text}",
                      topic: "test");
                  NotificationProviders().createPushNotification(
                      image: "https://i.imgur.com/2nCt3Sbl.jpg",
                      title: titleController.text,
                      message:
                          "${nameController.text}-${positionController.text}",
                      topic: kReleaseMode ? "prod" : "dev");

                  tabController.animateTo(0);
                }

                if (state is AnnouncementFailure) {
                  Timer(
                    const Duration(milliseconds: 300),
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color(0xFFD5393B),
                        content: Text("Failed to create announcement"),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return state is AnnouncementLoading
                    ? const LoadingCircle()
                    : SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AnnouncementCubit>(context)
                                .createAnnouncement(
                              title: titleController.text,
                              name: nameController.text,
                              position: positionController.text,
                            );
                          },
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                          child: Text(
                            "Post",
                          ),
                        ),
                      );
              },
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: titleController,
                      hintText: "Enter the title of the announcement",
                      maxLines: 3,
                      textInputType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your annoucement";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: nameController,
                      hintText: "Enter the name of the sender",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your sender";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Position",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputField(
                      controller: positionController,
                      hintText: "Enter the Position of the sender",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your position of sender";
                        }
                        return null;
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
