// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/pick_image_button.dart';
import 'package:gdsc_bloc/utilities/Widgets/twitter_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import '../../../../blocs/minimal_functonality/pick_date/pick_date_cubit.dart';
import '../../../../blocs/minimal_functonality/pick_twitter_time/pick_twitter_time_cubit.dart';
import '../../../../data/models/twitter_model.dart';
import '../../input_field.dart';

class AdminTwitterCard extends StatelessWidget {
  AdminTwitterCard({
    super.key,
    required this.twitter,
  });

  final TwitterModel twitter;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final Timestamp startTime = twitter.startTime;
    final Timestamp endTime = twitter.endTime;
    final DateTime startDateTime = startTime.toDate();
    final DateTime endDateTime = endTime.toDate();

    final String startTimeString = DateFormat.jm().format(startDateTime);
    final String endTimeString = DateFormat.jm().format(endDateTime);

    final Timestamp timestamp = twitter.startTime;

    final DateTime dateTime = timestamp.toDate();

    final String dateString = DateFormat.MMMEd().format(dateTime);
    return BlocProvider(
      create: (context) => TwitterSpaceCubit(),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ElevatedButton(
            onPressed: () {
              showSpaceDialog(context: context, twitter: twitter);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(255, 106, 81, 81),
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Semantics(
                      button: true,
                      child: InkWell(
                        onTap: () {
                          showSpaceDialog(context: context, twitter: twitter);
                        },
                        child: CachedNetworkImage(
                          height: 50,
                          width: 50,
                          placeholder: (context, url) {
                            return Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 243, 243, 243),
                                  // border: Border.all(width: 0.4, color: Color(0xff666666)),
                                  borderRadius: BorderRadius.circular(10)),
                            );
                          },
                          errorWidget: ((context, url, error) {
                            return const Icon(
                              Icons.error,
                              size: 20,
                              color: Colors.red,
                            );
                          }),
                          imageUrl: twitter.image!,
                          fit: BoxFit.fitHeight,
                          imageBuilder: (context, imageProvider) {
                            return AnimatedContainer(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.4, color: const Color(0xff666666)),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        twitter.title!,
                        maxLines: 2,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        dateString,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: const Color(0xff666666),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "$startTimeString - $endTimeString",
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          // color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: 36,
                        width: width * 0.7,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 110,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 0.55,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  showEditSpaceDialog(
                                      context: context, twitter: twitter);
                                },
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: const Color(0xff5B5561),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 110,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  BlocProvider.of<TwitterSpaceCubit>(context)
                                      .deleteTwitterSpace(id: twitter.id!);
                                },
                                child: Text(
                                  "Delete",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

showEditSpaceDialog({
  required BuildContext context,
  required TwitterModel twitter,
}) {
  final Timestamp timestamp = twitter.startTime;

  final DateTime dateTime = timestamp.toDate();
  final height = MediaQuery.of(context).size.height;
  final nameController = TextEditingController(text: twitter.title);
  final linkController = TextEditingController(text: twitter.link);
  final dateController = TextEditingController(text: dateTime.toString());
  final startTimeController =
      TextEditingController(text: DateFormat.jm().format(dateTime));
  final endTimeController =
      TextEditingController(text: DateFormat.jm().format(dateTime));
  final imageController = TextEditingController(text: twitter.image);

  showDialog(
      context: context,
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PickTwitterTimeCubit(),
            ),
            BlocProvider(
              create: (context) => PickDateCubit(),
            ),
            BlocProvider(
              create: (context) => TwitterSpaceCubit(),
            ),
          ],
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Dialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                insetPadding: const EdgeInsets.symmetric(horizontal: 5),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            controller: nameController,
                            hintText: "Edit name of twitter space",
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Link",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your link";
                              }
                              return null;
                            },
                            controller: linkController,
                            hintText: "Edit link of twitter space",
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          BlocProvider(
                            create: (context) => PickDateCubit(),
                            child: Builder(builder: (context) {
                              return BlocConsumer<PickDateCubit, PickDateState>(
                                listener: (context, state) {
                                  if (state is DatePicked) {
                                    dateController.text = state.date.toString();
                                  }
                                },
                                builder: (context, state) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date of Event",
                                        style: GoogleFonts.inter(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      TextFormField(
                                        onTap: () async {
                                          BlocProvider.of<PickDateCubit>(
                                                  context)
                                              .pickDate(context: context);
                                        },
                                        controller: dateController,
                                        keyboardType: TextInputType.none,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
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
                            }),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
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
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    PickTwitterSpaceTime(
                                        startTimeController:
                                            startTimeController),
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
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    BlocConsumer<PickTwitterTimeCubit,
                                        PickTwitterTimeState>(
                                      listener: (context, state) {
                                        if (state is TwitterTimePicked) {
                                          endTimeController.text = DateTime
                                                  .fromMillisecondsSinceEpoch(
                                                      state.timestamp
                                                          .millisecondsSinceEpoch)
                                              .toString();
                                        }
                                      },
                                      builder: (context, state) {
                                        return TextFormField(
                                          onTap: () async {
                                            BlocProvider.of<
                                                        PickTwitterTimeCubit>(
                                                    context)
                                                .pickSpaceTime(
                                                    context: context);
                                          },
                                          controller: endTimeController,
                                          keyboardType: TextInputType.none,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Attach a File",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          PickImageButton(imageController: imageController),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          BlocProvider(
                            create: (context) => TwitterSpaceCubit(),
                            child: Builder(
                              builder: (context) {
                                return BlocConsumer<TwitterSpaceCubit,
                                    TwitterSpaceState>(
                                  listener: (context, state) {
                                    if (state is TwitterSpaceUpdated) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  builder: (context, state) {
                                    return state is TwitterSpaceLoading
                                        ? LoadingCircle()
                                        : SizedBox(
                                            height: 50,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                BlocProvider.of<TwitterSpaceCubit>(
                                                        context)
                                                    .updateSpace(
                                                  id: twitter.id!,
                                                  title: nameController.text,
                                                  link: linkController.text,
                                                  date: Timestamp.fromDate(
                                                    DateTime.parse(
                                                        dateController.text),
                                                  ),
                                                  startTime: Timestamp.fromDate(
                                                    DateTime.parse(
                                                        startTimeController.text),
                                                  ),
                                                  endTime: Timestamp.fromDate(
                                                    DateTime.parse(
                                                        endTimeController.text),
                                                  ),
                                                  image: imageController.text,
                                                );
                                              },
                                              style: Theme.of(context)
                                                  .elevatedButtonTheme
                                                  .style!
                                                  .copyWith(
                                                    shape:
                                                        MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                25),
                                                      ),
                                                    ),
                                                  ),
                                              child: Text(
                                                "Update Twitter Space",
                                                style: GoogleFonts.inter(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                );
                              }
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
}

class PickTwitterSpaceTime extends StatelessWidget {
  const PickTwitterSpaceTime({
    super.key,
    required this.startTimeController,
  });

  final TextEditingController startTimeController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickTwitterTimeCubit(),
      child: Builder(builder: (context) {
        return BlocListener<PickTwitterTimeCubit, PickTwitterTimeState>(
          listener: (context, state) {
            if (state is TwitterTimePicked) {
              startTimeController.text = DateTime.fromMillisecondsSinceEpoch(
                      state.timestamp.millisecondsSinceEpoch)
                  .toString();
            }
          },
          child: TextFormField(
            onTap: () async {
              BlocProvider.of<PickTwitterTimeCubit>(context)
                  .pickSpaceTime(context: context);
            },
            controller: startTimeController,
            keyboardType: TextInputType.none,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
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
        );
      }),
    );
  }
}
