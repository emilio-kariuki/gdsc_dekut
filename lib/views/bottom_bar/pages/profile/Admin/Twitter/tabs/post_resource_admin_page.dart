import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/pick_date/pick_date_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/pick_twitter_time/pick_twitter_time_cubit.dart';

class PostAdminSpace extends StatelessWidget {
  PostAdminSpace({super.key, required this.tabController});

  final imageController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final linkController = TextEditingController();
  final dateController = TextEditingController();

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PickDateCubit(),
        ),
        BlocProvider(
          create: (context) => TwitterSpaceCubit(),
        ),
        BlocProvider(create: (context) => PickTwitterTimeCubit()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          bottomNavigationBar:
              BlocConsumer<TwitterSpaceCubit, TwitterSpaceState>(
            listener: (context, state) {
              if (state is TwitterSpaceCreated) {
                Timer(
                  const Duration(milliseconds: 100),
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      // behavior: SnackBarBehavior.floating,
                      backgroundColor: Color(0xFF0C7319),
                      content: Text("Space created"),
                    ),
                  ),
                );

                tabController.animateTo(0);
              }
            },
            builder: (context, state) {
              return state is TwitterSpaceLoading
                  ? const LoadingCircle()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<TwitterSpaceCubit>(context)
                                .createSpace(
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

                            nameController.clear();
                            startTimeController.clear();
                            endTimeController.clear();
                            linkController.clear();
                            dateController.clear();
                            startTimeController.clear();
                            endTimeController.clear();
                            imageController.clear();
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
                            "Create Space",
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
                  BlocConsumer<PickDateCubit, PickDateState>(
                    listener: (context, state) {
                      if (state is DatePicked) {
                        dateController.text = state.date;
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
                            BlocProvider(
                              create: (context) => PickTwitterTimeCubit(),
                              child: Builder(builder: (context) {
                                return BlocListener<PickTwitterTimeCubit,
                                    PickTwitterTimeState>(
                                  listener: (context, state) {
                                    if (state is TwitterTimePicked) {
                                      startTimeController.text =
                                          DateTime.fromMillisecondsSinceEpoch(
                                                  state.timestamp
                                                      .millisecondsSinceEpoch)
                                              .toString();
                                    }
                                  },
                                  child: TextFormField(
                                    onTap: () async {
                                      BlocProvider.of<PickTwitterTimeCubit>(
                                              context)
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
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            BlocConsumer<PickTwitterTimeCubit,
                                PickTwitterTimeState>(
                              listener: (context, state) {
                                if (state is TwitterTimePicked) {
                                  endTimeController.text =
                                      DateTime.fromMillisecondsSinceEpoch(state
                                              .timestamp.millisecondsSinceEpoch)
                                          .toString();
                                }
                              },
                              builder: (context, state) {
                                return TextFormField(
                                  onTap: () async {
                                    BlocProvider.of<PickTwitterTimeCubit>(
                                            context)
                                        .pickSpaceTime(context: context);
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
                    height: height * 0.01,
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
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
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
        );
      }),
    );
  }
}
