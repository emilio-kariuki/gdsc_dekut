import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/pick_date/pick_date_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/event/event_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../blocs/minimal_functonality/pick_time/pick_time_cubit.dart';
import '../../../../data/services/providers/notification_providers.dart';

class PostEvent extends StatelessWidget {
  PostEvent({super.key, required this.tabController});

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PickTimeCubit(),
        ),
        BlocProvider(
          create: (context) => PickDateCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BlocConsumer<EventCubit, EventState>(
          listener: (context, state) {
            if (state is EventCreated) {
              Timer(
                const Duration(milliseconds: 100),
                () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Color(0xFF0C7319),
                    content: Text("Event created"),
                  ),
                ),
              );
              print(imageController.text);

              NotificationProviders().createPushNotification(
                  image: imageController.text,
                  title: "New Event Posted🤩🚚",
                  message: nameController.text,
                  topic: "test");
              NotificationProviders().createPushNotification(
                image: imageController.text,
                title: "New Event Posted🤩🚚",
                message: nameController.text,
                topic: kReleaseMode ? "prod" : "dev",
              );

              tabController.animateTo(0);
            }
          },
          builder: (context, state) {
            return state is EventLoading
                ? const LoadingCircle()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<EventCubit>(context).createEvent(
                            imageUrl: imageController.text,
                            title: nameController.text,
                            description: descriptionController.text,
                            venue: venueController.text,
                            organizers: organizersController.text,
                            link: linkController.text,
                            date: dateController.text,
                          );

                          // nameController.clear();
                          // descriptionController.clear();
                          // venueController.clear();
                          // organizersController.clear();
                          // linkController.clear();
                          // dateController.clear();
                          // startTimeController.clear();
                          // endTimeController.clear();
                          // imageController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF000000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Create Event",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                    ));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InputField(
                  title: "Name",
                  controller: nameController,
                  hintText: "Edit name of event",
                ),
                const SizedBox(
                  height: 6,
                ),
                InputField(
                  title: "Description",
                  controller: descriptionController,
                  hintText: "Edit description of event",
                ),
                const SizedBox(
                  height: 6,
                ),
                InputField(
                  title: "Venue",
                  controller: venueController,
                  hintText: "Edit venue of event",
                ),
                const SizedBox(
                  height: 6,
                ),
                InputField(
                  title: "Organizers",
                  controller: organizersController,
                  hintText: "Edit organizers of event",
                ),
                const SizedBox(
                  height: 6,
                ),
                InputField(
                  title: "Link",
                  controller: linkController,
                  hintText: "Edit link of event",
                ),
                const SizedBox(
                  height: 6,
                ),
                EventPickDateWidget(dateController: dateController),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  "Attach a File",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff000000),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                BlocProvider(
                  create: (context) => GetImageCubit(),
                  child: Builder(builder: (context) {
                    return BlocConsumer<GetImageCubit, GetImageState>(
                      listener: (context, state) {
                        if (state is ImagePicked) {
                          imageController.text = state.imageUrl;
                          Timer(
                            const Duration(milliseconds: 300),
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 400),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Color(0xFF0C7319),
                                content: Text("Image uploaded"),
                              ),
                            ),
                          );
                        }

                        if (state is ImageError) {
                          Timer(
                            const Duration(milliseconds: 100),
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xFFD5393B),
                                content: Text(state.message),
                              ),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final width = MediaQuery.of(context).size.width;
                        return SizedBox(
                          height: 50,
                          width: width * 0.4,
                          child: state is ImageUploading
                              ? const LoadingCircle()
                              : ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<GetImageCubit>(context)
                                        .getImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff000000),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Attach File",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                        );
                      },
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventPickDateWidget extends StatelessWidget {
  const EventPickDateWidget({
    super.key,
    required this.dateController,
  });

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickDateCubit, PickDateState>(
      listener: (context, state) {
        if (state is DatePicked) {
          dateController.text = state.date.toString();
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date of Event",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 12, right: 1),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey[500]!,
                    width: 1,
                  )),
              child: TextFormField(
                onTap: () async {
                  BlocProvider.of<PickDateCubit>(context)
                      .pickDate(context: context);
                },
                controller: dateController,
                keyboardType: TextInputType.none,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: const Color(0xff000000),
                ),
                decoration: InputDecoration(
                  hintText: "Pick date",
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
