import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/group/group_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../utilities/Widgets/loading_circle.dart';

class EditGroupDialog extends StatelessWidget {
  const EditGroupDialog({
    super.key,
    required this.imageController,
    required this.idController,
    required this.nameController,
    required this.linkController,
    required this.descriptionController,
    required this.context,
    required this.tabController,
  });

  final TextEditingController imageController;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController linkController;
  final TextEditingController descriptionController;
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
                    child: BlocConsumer<GroupCubit, GroupState>(
                      listener: (context, state) {
                        if (state is GroupUpdated) {
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
                              BlocProvider.of<GroupCubit>(context).updateGroup(
                                id: idController.text,
                                title: nameController.text,
                                link: linkController.text,
                                description: descriptionController.text,
                                imageUrl: imageController.text,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF217604),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              "Update Twitter Group",
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
                          SizedBox(
                            height: 10,
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
                          SizedBox(
                            height: 10,
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
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Description",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000000),
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                                  final width =
                                      MediaQuery.of(context).size.width;
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
