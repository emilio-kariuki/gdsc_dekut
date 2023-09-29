import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';

showReportSheet({required BuildContext context}) {
  final reportController = TextEditingController();
  final height = MediaQuery.sizeOf(context).height;
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return IntrinsicHeight(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    InputField(
                      maxLines: 6,
                      minLines: 3,
                      controller: reportController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a report";
                        }
                        return null;
                      },
                      hintText: "Enter your bug report",
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: FlexColor.aquaBlueDarkSecondaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        shadowColor: Colors.white,
                        surfaceTintColor: Colors.white,
                      ),
                      onPressed: () {
                        if (reportController.text.isNotEmpty) {
                          Navigator.pop(context, reportController.text);
                        }
                      },
                      child: Text("Submit"),
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
}
