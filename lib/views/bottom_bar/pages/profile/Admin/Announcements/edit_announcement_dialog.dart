// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../blocs/app_functionality/announcement/announcement_cubit.dart';



class EditAnnouncementDialog extends StatelessWidget {
  const EditAnnouncementDialog({
    super.key,
    required this.idController,
    required this.nameController,
    required this.titleController,
    required this.positionController,
    required this.context,
  });

  final TextEditingController idController;
  final TextEditingController titleController;
  final TextEditingController positionController;
  final TextEditingController nameController;

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
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Scaffold(
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocConsumer<AnnouncementCubit, AnnouncementState>(
                      listener: (context, state) {
                        if (state is AnnouncementUpdated) {
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AnnouncementCubit>(context)
                                  .updateAnnouncement(
                                id: idController.text,
                                title: titleController.text,
                                name: nameController.text,
                                position: positionController.text,
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
                            controller: nameController,
                            hintText: "Edit name of Sender",
                            validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name of sender";
                        }
                        return null;
                      },
                          ),
                          const SizedBox(
                            height: 6,
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
                          const SizedBox(
                            height: 6,
                          ),
                          InputField(
                            controller: positionController,
                            hintText: "Edit link of event",
                            validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your link";
                        }
                        return null;
                      },
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }
}
