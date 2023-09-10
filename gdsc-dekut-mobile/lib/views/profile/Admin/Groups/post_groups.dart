import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/group/group_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';

class PostGroups extends StatelessWidget {
  PostGroups({super.key, required this.tabController});

  final imageController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final linkController = TextEditingController();
  final descriptionController = TextEditingController();
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar:
              BlocConsumer<GroupCubit, GroupState>(
            listener: (context, state) {
              if (state is GroupCreated) {
                Timer(
                  const Duration(milliseconds: 100),
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color(0xFF0C7319),
                      content: Text("Group created"),
                    ),
                  ),
                );

                tabController.animateTo(0);
              }
            },
            builder: (context, state) {
              return state is GroupLoading
                  ? const LoadingCircle()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<GroupCubit>(context)
                                .createGroup(
                              title: nameController.text,
                              description: descriptionController.text,
                              link: linkController.text,
                              imageUrl: imageController.text,
                            );

                            nameController.clear();
                            descriptionController.clear();
                            linkController.clear();
                            imageController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF000000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            "Create Group",
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
                    hintText: "Edit name of group",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Description",
                    controller: descriptionController,
                    hintText: "Edit description of group",
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  InputField(
                    title: "Link",
                    controller: linkController,
                    hintText: "Edit link of group",
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
