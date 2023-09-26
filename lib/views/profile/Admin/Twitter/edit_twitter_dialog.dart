import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/pick_date/pick_date_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../blocs/minimal_functonality/pick_twitter_time/pick_twitter_time_cubit.dart';
import '../../../../utilities/Widgets/loading_circle.dart';

class EditTwitterDialog extends StatelessWidget {
  const EditTwitterDialog({
    super.key,
    required this.imageController,
    required this.idController,
    required this.nameController,
    required this.startTimeController,
    required this.endTimeController,
    required this.linkController,
    required this.context,
    required this.tabController,
    required this.dateController,
  });

  final TextEditingController imageController;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
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
                  maxHeight: MediaQuery.of(context).size.height * 0.65,
                ),
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Scaffold(
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocConsumer<TwitterSpaceCubit, TwitterSpaceState>(
                      listener: (context, state) {
                        if (state is TwitterSpaceUpdated) {
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
                              BlocProvider.of<TwitterSpaceCubit>(context)
                                  .updateSpace(
                                id: idController.text,
                                title: nameController.text,
                                link: linkController.text,
                                date: Timestamp.fromDate(
                                  DateTime.parse(dateController.text),
                                ),
                                startTime: Timestamp.fromDate(
                                  DateTime.parse(startTimeController.text),
                                ),
                                endTime: Timestamp.fromDate(
                                  DateTime.parse(endTimeController.text),
                                ),
                                image: imageController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF217604),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              "Update Twitter Space",
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
                  ),
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: AppBar(
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      title: Text(
                        "Edit Twitter Space",
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
                          Text(
              "Name",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
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
                            hintText: "Edit name of twitter space",
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
              "Link",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: const Color(0xff000000),
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
                            hintText: "Edit link of twitter space",
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          BlocConsumer<PickDateCubit, PickDateState>(
                            listener: (context, state) {
                              if (state is DatePicked) {
                                // dateController.text =
                                //     DateTime.fromMillisecondsSinceEpoch(
                                //             state.date.millisecondsSinceEpoch)
                                //         .toString();
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
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 1),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey[500]!,
                                          width: 1,
                                        )),
                                    child: TextFormField(
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
                          ),
                          const SizedBox(
                            height: 6,
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
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    PickTwitterSpaceTime(startTimeController: startTimeController),
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
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 1),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.grey[500]!,
                                            width: 1,
                                          )),
                                      child: BlocConsumer<PickTwitterTimeCubit,
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
                          BlocProvider(
                            create: (context) => GetImageCubit(),
                            child: Builder(builder: (context) {
                              return BlocConsumer<GetImageCubit,
                                  GetImageState>(
                                listener: (context, state) {
                                  if (state is ImagePicked) {
                                    imageController.text = state.imageUrl;
                                    Timer(
                                      const Duration(milliseconds: 300),
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                      () => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor:
                                              const Color(0xFFD5393B),
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
                                              BlocProvider.of<
                                                          GetImageCubit>(
                                                      context)
                                                  .getImage();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff000000),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                )),
          ),
        ));
  }
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
        return Container(
          height: 50,
          padding: const EdgeInsets.only(
              left: 12, right: 1),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(5),
              border: Border.all(
                color: Colors.grey[500]!,
                width: 1,
              )),
          child: BlocListener<PickTwitterTimeCubit,
              PickTwitterTimeState>(
            listener: (context, state) {
              if (state is TwitterTimePicked) {
                startTimeController
                    .text = DateTime
                        .fromMillisecondsSinceEpoch(
                            state.timestamp
                                .millisecondsSinceEpoch)
                    .toString();
              }
            },
            child: TextFormField(
              onTap: () async {
                BlocProvider.of<
                            PickTwitterTimeCubit>(
                        context)
                    .pickSpaceTime(
                        context: context);
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
    );
  }
}
