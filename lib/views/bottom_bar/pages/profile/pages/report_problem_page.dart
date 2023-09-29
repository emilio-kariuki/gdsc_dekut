// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/pick_image_button.dart';
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
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        BlocProvider.of<ReportCubit>(context).reportProblem(
                          title: problemController.text,
                          description: descriptionController.text,
                          appVersion: appVersionController.text,
                          contact: contactController.text,
                          image: imageController.text,
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
                        "Report Problem",
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
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Problem",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
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
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InputField(
                    maxLines: 8,
                    minLines: 3,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your description";
                      }
                      return null;
                    },
                    controller: descriptionController,
                    hintText: "Enter your description",
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "App Version",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
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
              Text(
                "Contact",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
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
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PickImageButton(imageController: imageController)
            ],
          ),
        ),
      ),
    );
  }
}
