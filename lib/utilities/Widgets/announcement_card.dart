import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_functionality/announcement/announcement_cubit.dart';
import '../../data/models/announcement_model.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({
    super.key,
    required this.announcement,
    required this.isAdmin,
  });

  final AnnouncementModel announcement;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => AnnouncementCubit(),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: SizedBox(
            width: width,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Color.fromARGB(255, 106, 81, 81),
                    width: 0.15,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  AutoSizeText(
                    announcement.title!,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 15),
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  AutoSizeText(
                      "${announcement.name} - ${announcement.position}",
                      style: Theme.of(context).textTheme.titleSmall!),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  Visibility(
                    visible: isAdmin,
                    child: SizedBox(
                      height: 40,
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
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
                                showEditAnnouncementDialog(
                                  context: context,
                                  name: announcement.name!,
                                  title: announcement.title!,
                                  position: announcement.position!,
                                  id: announcement.id!,
                                );
                              },
                              child: AutoSizeText(
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
                          SizedBox(
                            width: 120,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
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
                                BlocProvider.of<AnnouncementCubit>(context)
                                    .deleteAnnouncement(id: announcement.id!);
                              },
                              child: AutoSizeText(
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
                    ),
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

showEditAnnouncementDialog(
    {required BuildContext context,
    required String name,
    required String title,
    required String position,
    required String id}) {
  final nameController = TextEditingController(text: name);
  final titleController = TextEditingController(text: title);
  final positionController = TextEditingController(text: position);
  final height = MediaQuery.sizeOf(context).height;

  showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              insetPadding: const EdgeInsets.all(5),
              child: IntrinsicHeight(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: Theme.of(context).textTheme.titleMedium!),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InputField(
                        controller: nameController,
                        hintText: "Edit name of Sender",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your name of sender";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text("Title",
                          style: Theme.of(context).textTheme.titleMedium!),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InputField(
                        controller: titleController,
                        hintText: "Edit title of announcement",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your announcement";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text("Position",
                          style: Theme.of(context).textTheme.titleMedium!),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InputField(
                        controller: positionController,
                        hintText: "Edit position of the sender",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter the  position";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BlocProvider(
                        create: (context) => AnnouncementCubit(),
                        child: Builder(
                          builder: (context) {
                            return BlocConsumer<AnnouncementCubit, AnnouncementState>(
                              listener: (context, state) {
                                if (state is AnnouncementUpdated) {
                                  Navigator.pop(context);
                                }
                              },
                              builder: (context, state) {
                                return state is AnnouncementLoading ? Center(child: LoadingCircle()) : SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<AnnouncementCubit>(context)
                                          .updateAnnouncement(
                                        id: id,
                                        title: titleController.text,
                                        name: nameController.text,
                                        position: positionController.text,
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
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
