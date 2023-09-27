// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../../blocs/minimal_functonality/report/report_cubit.dart';
import '../../../../../utilities/Widgets/loading_circle.dart';

class ReportProblemPage extends StatelessWidget {
  ReportProblemPage({super.key});

  final descriptionController = TextEditingController();
  final problemController = TextEditingController();
  final appVersionController = TextEditingController();
  final contactController = TextEditingController();
  String image = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (context) => ReportCubit(),
          child: Builder(builder: (context) {
            return BlocListener<ReportCubit, ReportState>(
              listener: (context, state) {
                if (state is ReportCreated) {
                  Timer(
                    const Duration(milliseconds: 300),
                    () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Color(0xFF0C7319),
                        content: Text("report Sent Successfully"),
                      ),
                    ),
                  );
                }

                if (state is ReportError) {
                  Timer(
                    const Duration(milliseconds: 300),
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
              child: BlocBuilder<ReportCubit, ReportState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ReportCubit>(context)
                            .reportProblem(
                          title: problemController.text,
                          description: descriptionController.text,
                          appVersion: appVersionController.text,
                          contact: contactController.text,
                          image: image,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Report Problem",
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
          }),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
        title: Text(
          "Report a Problem",
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: const Color(0xff666666),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Please describe the problem you are facing in detail. \nThis will help us to solve the problem faster.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your problem";
                        }
                        return null;
                      },
                controller: problemController,
                hintText: "Enter your problem",
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff000000),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(left: 12, right: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey[500]!,
                          width: 1,
                        )),
                    child: TextFormField(
                      maxLines: 3,
                      controller: descriptionController,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter your description",
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your app version";
                        }
                        return null;
                      },
                controller: appVersionController,
                hintText: "Enter your app version",
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your contact";
                        }
                        return null;
                      },
                controller: contactController,
                hintText: "Enter your contact",
              ),
              const SizedBox(
                height: 20,
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
                        image = state.imageUrl;
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
                                  BlocProvider.of<GetImageCubit>(
                                          context)
                                      .getImage();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff000000),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: AutoSizeText(
                                  "Attach File",
                                  minFontSize: 10,
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
  }
}
