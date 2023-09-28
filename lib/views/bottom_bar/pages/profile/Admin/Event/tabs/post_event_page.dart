import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/pick_date/pick_date_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../blocs/app_functionality/event/event_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/pick_time/pick_time_cubit.dart';

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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Name",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                  controller: nameController,
                  hintText: "Edit name of event",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Description",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your description";
                    }
                    return null;
                  },
                  maxLines: 3,
                  minLines: 1,
                  textInputType: TextInputType.multiline,
                  controller: descriptionController,
                  hintText: "Edit description of event",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Venue",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your venue";
                    }
                    return null;
                  },
                  controller: venueController,
                  hintText: "Edit venue of event",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Organizers",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your organizers";
                    }
                    return null;
                  },
                  controller: organizersController,
                  hintText: "Edit organizers of event",
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Link",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your link";
                    }
                    return null;
                  },
                  controller: linkController,
                  hintText: "Edit link of event",
                ),
                const SizedBox(
                  height: 10,
                ),
                EventPickDateWidget(dateController: dateController),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Attach a File",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                EventImageButton(
                  imageController: imageController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                PostEventButton(
                  imageController: imageController,
                  tabController: tabController,
                  nameController: nameController,
                  descriptionController: descriptionController,
                  venueController: venueController,
                  organizersController: organizersController,
                  linkController: linkController,
                  dateController: dateController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventImageButton extends StatelessWidget {
  const EventImageButton({
    super.key,
    required this.imageController,
  });

  final TextEditingController imageController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
                        BlocProvider.of<GetImageCubit>(context).getImage();
                      },
                      style:
                          Theme.of(context).elevatedButtonTheme.style!.copyWith(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                      child: Text(
                        "Attach File",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            );
          },
        );
      }),
    );
  }
}

class PostEventButton extends StatelessWidget {
  const PostEventButton({
    super.key,
    required this.imageController,
    required this.tabController,
    required this.nameController,
    required this.descriptionController,
    required this.venueController,
    required this.organizersController,
    required this.linkController,
    required this.dateController,
  });

  final TextEditingController imageController;
  final TabController tabController;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController venueController;
  final TextEditingController organizersController;
  final TextEditingController linkController;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventCubit, EventState>(
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
                    },
                    style:
                        Theme.of(context).elevatedButtonTheme.style!.copyWith(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                    child: Text(
                      "Create Event",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ));
      },
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
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
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
          ],
        );
      },
    );
  }
}
