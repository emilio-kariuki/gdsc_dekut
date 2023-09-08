import 'dart:async';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/leads/leads_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';

class PostAdminLead extends StatelessWidget {
  PostAdminLead({super.key, required this.tabController});

  final imageController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();
  final githubController = TextEditingController();
  final twitterController = TextEditingController();
  final bioController = TextEditingController();

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadsCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar:
              BlocConsumer<LeadsCubit, LeadsState>(
            listener: (context, state) {
              if (state is LeadsCreated) {
                Timer(
                  const Duration(milliseconds: 100),
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color(0xFF0C7319),
                      content: Text("Lead created"),
                    ),
                  ),
                );

                tabController.animateTo(0);
              }
            },
            builder: (context, state) {
              return state is LeadsLoading
                  ? const LoadingCircle()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<LeadsCubit>(context)
                                .createLead(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              role: roleController.text,
                              github: githubController.text,
                              twitter: twitterController.text,
                              bio: bioController.text,
                              image: imageController.text,
                            );

                            nameController.clear();
                            emailController.clear();
                            phoneController.clear();
                            roleController.clear();
                            githubController.clear();
                            twitterController.clear();
                            bioController.clear();
                            imageController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            "Create Lead",
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
                    hintText: "Enter name of lead",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Email",
                    controller: emailController,
                    hintText: "Enter email of lead",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Phone",
                    controller: phoneController,
                    hintText: "Enter phone of lead",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Role",
                    controller: roleController,
                    hintText: "Enter role of lead",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Github",
                    controller: githubController,
                    hintText: "Enter github of lead",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Twitter",
                    controller: twitterController,
                    hintText: "Enter twitter of lead",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Bio",
                    controller: bioController,
                    hintText: "Enter bio of lead",
                  ),
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
                          return SizedBox(
                            height: 50,
                            width: 120,
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
