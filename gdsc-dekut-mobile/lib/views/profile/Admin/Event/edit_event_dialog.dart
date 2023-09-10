import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/pick_time/pick_time_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/event/event_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../blocs/minimal_functonality/pick_date/pick_date_cubit.dart';
import '../../../../utilities/Widgets/loading_circle.dart';

class EditEventDialog extends StatelessWidget {
  const EditEventDialog({
    super.key,
    required this.imageController,
    required this.idController,
    required this.nameController,
    required this.descriptionController,
    required this.venueController,
    required this.organizersController,
    required this.linkController,
    required this.dateController,
    required this.context,
    required this.tabController,
  });

  final TextEditingController imageController;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController venueController;
  final TextEditingController organizersController;
  final TextEditingController linkController;
  final TextEditingController dateController;

  final TabController tabController;

  final BuildContext context;

  @override
  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Dialog(
          insetPadding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                height: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Scaffold(
                  bottomNavigationBar: UpdateEventContainer(
                    tabController: tabController,
                    imageController: imageController,
                    idController: idController,
                    nameController: nameController,
                    descriptionController: descriptionController,
                    venueController: venueController,
                    organizersController: organizersController,
                    linkController: linkController,
                    dateController: dateController,
                  ),
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: AppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      title: Text(
                        "Edit Event",
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[900],
                        ),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.grey[900]!,
                            ))
                      ],
                    ),
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
                          PickDateContainer(dateController: dateController),
                          const SizedBox(
                            height: 6,
                          ),
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
                          GetImageButtons(imageController: imageController)
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }
}

class PickDateContainer extends StatelessWidget {
  const PickDateContainer({
    super.key,
    required this.dateController,
  });

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickDateCubit, PickDateState>(
      listener: (context, state) {
        if (state is DatePicked) {
          dateController.text = state.date.toString().substring(0, 10);
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

class EventTimesContainer extends StatelessWidget {
  const EventTimesContainer({
    super.key,
    required this.startTimeController,
    required this.endTimeController,
  });

  final TextEditingController startTimeController;
  final TextEditingController endTimeController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Start Time",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocProvider(
                create: (context) => PickTimeCubit(),
                child: Builder(builder: (context) {
                  return Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 12, right: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey[500]!,
                          width: 1,
                        )),
                    child: BlocListener<PickTimeCubit, PickTimeState>(
                      listener: (context, state) {
                        if (state is TimePicked) {
                          startTimeController.text = state.time;
                        }
                      },
                      child: TextFormField(
                        onTap: () async {
                          BlocProvider.of<PickTimeCubit>(context)
                              .pickTime(context: context);
                        },
                        controller: startTimeController,
                        keyboardType: TextInputType.none,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          hintText: "Start time",
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "End Time",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 8,
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
                child: BlocConsumer<PickTimeCubit, PickTimeState>(
                  listener: (context, state) {
                    if (state is TimePicked) {
                      endTimeController.text = state.time;
                    }
                  },
                  builder: (context, state) {
                    return TextFormField(
                      onTap: () async {
                        BlocProvider.of<PickTimeCubit>(context)
                            .pickTime(context: context);
                      },
                      controller: endTimeController,
                      keyboardType: TextInputType.none,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        hintText: "End time",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GetImageButtons extends StatelessWidget {
  const GetImageButtons({
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
    );
  }
}

class UpdateEventContainer extends StatelessWidget {
  const UpdateEventContainer({
    super.key,
    required this.tabController,
    required this.imageController,
    required this.idController,
    required this.nameController,
    required this.descriptionController,
    required this.venueController,
    required this.organizersController,
    required this.linkController,
    required this.dateController,
  });

  final TabController tabController;
  final TextEditingController imageController;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController venueController;
  final TextEditingController organizersController;
  final TextEditingController linkController;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          if (state is EventUpdated) {
            Navigator.pop(context);

            tabController.animateTo(0);
          }
        },
        builder: (context, state) {
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<EventCubit>(context).updateEvent(
                    imageUrl: imageController.text,
                    id: idController.text,
                    title: nameController.text,
                    description: descriptionController.text,
                    venue: venueController.text,
                    organizers: organizersController.text,
                    link: linkController.text,
                    date: dateController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF217604),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Update Event",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
