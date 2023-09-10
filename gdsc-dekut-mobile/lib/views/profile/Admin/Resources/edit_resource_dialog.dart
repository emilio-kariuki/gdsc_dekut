// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/drop_down/drop_down_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/resource/resource_cubit.dart';
import '../../../../blocs/minimal_functonality/get_image/get_image_cubit.dart';
import '../../../../utilities/Widgets/loading_circle.dart';

class EditResourceDialog extends StatelessWidget {
  EditResourceDialog({
    super.key,
    required this.imageController,
    required this.idController,
    required this.nameController,
    required this.descriptionController,
    required this.linkController,
    required this.context,
    required this.tabController,
    required this.categoryController,
    required this.selectedType,
  });

  final TextEditingController imageController;
  final TextEditingController idController;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TabController tabController;
  final TextEditingController linkController;
  final TextEditingController categoryController;
  String? selectedType;

  final BuildContext context;

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
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Dialog(
          insetPadding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                height: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Scaffold(
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocConsumer<ResourceCubit, ResourceState>(
                      listener: (context, state) {
                        if (state is ResourceUpdated) {
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<ResourceCubit>(context)
                                  .updateResource(
                                category: selectedType!,
                                id: idController.text,
                                title: nameController.text,
                                description: descriptionController.text,
                                link: linkController.text,
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
                              "Update Event",
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
                        "Edit Event",
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
                          InputField(
                            title: "Name",
                            controller: nameController,
                            hintText: "Edit name of event",
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          InputField(
                            title: "Description",
                            controller: descriptionController,
                            hintText: "Edit description of event",
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          InputField(
                            title: "Link",
                            controller: linkController,
                            hintText: "Edit link of event",
                          ),
                          const SizedBox(
                            height: 6,
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
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ))
                                          .toList(),
                                      value: state is DropDownChanged
                                          ? state.value
                                          : selectedType,
                                      onChanged: (value) {
                                        BlocProvider.of<DropDownCubit>(context)
                                            .dropDownClicked(
                                                value: value.toString());
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: width,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white),
                                        elevation: 0,
                                        offset: const Offset(0, 0),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 14, right: 14),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
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
