import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../blocs/app_functionality/group/group_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';

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
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => GroupCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          bottomNavigationBar: BlocConsumer<GroupCubit, GroupState>(
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
                            BlocProvider.of<GroupCubit>(context).createGroup(
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
                            "Create Group",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
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
                        return "Please enter the  name";
                      }
                      return null;
                    },
                    controller: nameController,
                    hintText: "Edit name of group",
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
                    hintText: "Edit link of group",
                  ),
                   SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    "Description",
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
                        return "Please enter your description";
                      }
                      return null;
                    },
                    maxLines: 3,
                    textInputType: TextInputType.multiline,
                    minLines: 1,
                    controller: descriptionController,
                    hintText: "Edit description of group",
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
