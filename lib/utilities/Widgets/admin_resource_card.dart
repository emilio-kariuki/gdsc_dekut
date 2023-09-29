// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/pick_image_button.dart';
import 'package:gdsc_bloc/utilities/Widgets/resources_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_functionality/resource/resource_cubit.dart';
import '../../blocs/minimal_functonality/drop_down/drop_down_cubit.dart';
import '../../data/models/resource_model.dart';
import 'input_field.dart';

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

class AdminResourceCard extends StatelessWidget {
  AdminResourceCard({
    super.key,
    required this.resource,
    required this.isApproved,
  });

  final Resource resource;
  final bool isApproved;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => ResourceCubit(),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ElevatedButton(
            onPressed: () {
              showResourceDialog(context: context, resource: resource);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Color.fromARGB(255, 106, 81, 81),
                  width: 0.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Semantics(
                          button: true,
                          child: InkWell(
                            onTap: () {
                              showResourceDialog(
                                  context: context, resource: resource);
                            },
                            child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              placeholder: (context, url) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 243, 243, 243),
                                      borderRadius: BorderRadius.circular(10)),
                                );
                              },
                              errorWidget: ((context, url, error) {
                                return const Icon(
                                  Icons.error,
                                  size: 20,
                                  color: Colors.red,
                                );
                              }),
                              imageUrl: resource.imageUrl!,
                              fit: BoxFit.fitHeight,
                              imageBuilder: (context, imageProvider) {
                                return AnimatedContainer(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 0.4,
                                        color: const Color(0xff666666)),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 500),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          Text(
                            resource.title!,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: 36,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.black,
                                width: 0.55,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            showEditResourceDialog(
                              context: context,
                              resouce: resource,
                            );
                          },
                          child: Text(
                            "Edit",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xff5B5561),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: isApproved,
                        child: SizedBox(
                            width: 110,
                            child: BlocConsumer<ResourceCubit, ResourceState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF217604),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ResourceCubit>(context)
                                        .approveResource(id: resource.id!);
                                  },
                                  child: AutoSizeText(
                                    "Approve",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.black,
                                width: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<ResourceCubit>(context)
                                .deleteResource(
                              id: resource.id!,
                            );
                          },
                          child: Text(
                            "Delete",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

showEditResourceDialog(
    {required BuildContext context, required Resource resouce}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final nameController = TextEditingController(text: resouce.title);
  final linkController = TextEditingController(text: resouce.link);
  final imageController = TextEditingController(text: resouce.imageUrl);
  String selectedType = resouce.category!;
  showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => ResourceCubit(),
          child: Builder(builder: (context) {
            return StatefulBuilder(
              builder: ((context, setState) {
                return Dialog(
                  insetPadding: const EdgeInsets.all(5),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: IntrinsicHeight(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).scaffoldBackgroundColor),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              hintText: "Edit name of event",
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
                              borderRadius: 10,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter your link";
                                }
                                return null;
                              },
                              controller: linkController,
                              hintText: "Edit link of event",
                            ),
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
                                return BlocConsumer<DropDownCubit,
                                    DropDownState>(
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
                                                        .titleSmall,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                        value: state is DropDownChanged
                                            ? state.value
                                            : selectedType,
                                        onChanged: (value) {
                                          BlocProvider.of<DropDownCubit>(
                                                  context)
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
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          elevation: 0,
                                          offset: const Offset(0, 0),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness: MaterialStateProperty
                                                .all<double>(6),
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
                            PickImageButton(imageController: imageController),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            BlocConsumer<ResourceCubit, ResourceState>(
                              listener: (context, state) {
                                if (state is ResourceUpdated) {
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                return state is ResourceLoading
                                    ? LoadingCircle()
                                    : SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<ResourceCubit>(
                                                    context)
                                                .updateResource(
                                              category: selectedType,
                                              id: resouce.id!,
                                              title: nameController.text,
                                              link: linkController.text,
                                              imageUrl: imageController.text,
                                            );
                                          },
                                          style: Theme.of(context)
                                              .elevatedButtonTheme
                                              .style!
                                              .copyWith(
                                                shape:
                                                    MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        );
      });
}
