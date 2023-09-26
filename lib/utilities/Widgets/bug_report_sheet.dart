import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

void showBugSheet({required BuildContext context}) {
  showModalBottomSheet(
      context: context,
      builder: ((context) {
        return ReportPage();
      }));
}


class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  final feedbackController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: globalKey,
      child: StatefulBuilder(builder: (context, setState) {
        return IntrinsicHeight(
          child: Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                InputField(
                  controller: feedbackController,
                  textInputType: TextInputType.multiline,
                  minLines: 4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your problem';
                    }
                    return null;
                  },
                  hintText: 'Enter your problem',
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: AutoSizeText(
                        "Send Problem",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
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