// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/drop_down/drop_down_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/pick_image_button.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../blocs/app_functionality/resource/resource_cubit.dart';
import '../../../../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';

class AdminResourcePostPage extends StatelessWidget {
  AdminResourcePostPage({super.key, required this.tabController});

  final titleController = TextEditingController();
  final imageController = TextEditingController();
  String image = "";
  final linkController = TextEditingController();
  String? selectedType;
  final TabController tabController;

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
    final height = MediaQuery.of(context).size.height;
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
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
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
                            return "Please enter your title";
                          }
                          return null;
                        },
                        controller: titleController,
                        hintText: "Enter the title of the resource"),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "Resource Type",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
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
                                                .titleSmall!
                                                .copyWith(
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
                                      color: Theme.of(context).primaryColor),
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
                        hintText: "Enter the link to the resource"),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    PickImageButton(imageController: imageController),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    BlocListener<ResourceCubit, ResourceState>(
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

                          tabController.animateTo(0);
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
                      child: BlocBuilder<ResourceCubit, ResourceState>(
                        builder: (context, state) {
                          return state is ResourceLoading
                              ? const LoadingCircle()
                              : SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<ResourceCubit>(context)
                                          .createAdminResource(
                                        title: titleController.text,
                                        link: linkController.text,
                                        category: selectedType!,
                                        imageUrl: imageController.text,
                                      );
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
                                      "Post",
                                    ),
                                  ),
                                );
                        },
                      ),
                    ),
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
