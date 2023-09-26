// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/get_image/get_image_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_functionality/resource/resource_cubit.dart';
import '../../blocs/minimal_functonality/drop_down/drop_down_cubit.dart';

class ResourcePostPage extends StatelessWidget {
  ResourcePostPage({super.key});

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String image = "";
  final linkController = TextEditingController();
  String? selectedType;

  final List<String> items = [
    "mobile",
    "data",
    "design",
    "web",
    "cloud",
    "iot",
    "ai",
    "game",
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResourceCubit(),
        ),
        BlocProvider(
          create: (context) => GetImageCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          bottomNavigationBar: PostResourceContainer(
            titleController: titleController,
            descriptionController: descriptionController,
            linkController: linkController,
            selectedType: selectedType,
            image: image,
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
            title: Text(
              "Post a Resource",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your title";
                          }
                          return null;
                        },
                        controller: titleController,
                        hintText: "Enter the title of the resource"),
                    const SizedBox(
                      height: 20,
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
                        controller: descriptionController,
                        hintText: "Enter the description of the resource"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Resource Type",
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
                      create: (context) => DropDownCubit(),
                      child: Builder(builder: (context) {
                        return BlocConsumer<DropDownCubit, DropDownState>(
                          listener: (context, state) {
                            if (state is DropDownChanged) {
                              selectedType = state.value;
                            }
                          },
                          builder: (context, state) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Text(
                                  'Select a resource type',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: state is DropDownChanged
                                    ? state.value
                                    : selectedType,
                                onChanged: (value) {
                                  BlocProvider.of<DropDownCubit>(context)
                                      .dropDownClicked(value: value.toString());
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: width,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey[500]!,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                  elevation: 0,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: width * 0.9,
                                  padding: null,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  elevation: 0,
                                  offset: const Offset(0, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your link";
                        }
                        return null;
                      },                        controller: linkController,
                        hintText: "Enter the link to the resource"),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<GetImageCubit, GetImageState>(
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
                        return state is ImageUploading
                            ? const LoadingCircle()
                            : SizedBox(
                                height: 50,
                                width: width * 0.4,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<GetImageCubit>().getImage();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff000000),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Add Image",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class PostResourceContainer extends StatelessWidget {
  const PostResourceContainer({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.linkController,
    required this.selectedType,
    required this.image,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController linkController;
  final String? selectedType;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocConsumer<ResourceCubit, ResourceState>(
        listener: (context, state) {
          if (state is ResourceCreated) {
            Timer(
              const Duration(milliseconds: 300),
              () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color(0xFF0C7319),
                  content: Text("Resource Sent Successfully"),
                ),
              ),
            );
          }

          if (state is ResourceError) {
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
        builder: (context, state) {
          return state is ResourceLoading
              ? const LoadingCircle()
              : SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ResourceCubit>(context).createResource(
                        title: titleController.text,
                        link: linkController.text,
                        category: selectedType!,
                        imageUrl: image,
                      );
                      titleController.clear();
                      descriptionController.clear();
                      linkController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Post",
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
