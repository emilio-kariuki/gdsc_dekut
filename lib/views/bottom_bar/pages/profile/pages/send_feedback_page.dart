import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/feedback/feedback_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:google_fonts/google_fonts.dart';

class SendFeedbackPage extends StatelessWidget {
  SendFeedbackPage({super.key});

  final feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
        title: Text(
          "Feedback",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xff666666),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your feedback";
                }
                return null;
              },
              controller: feedbackController,
              hintText: "Enter your feed",
            ),
            const SizedBox(
              height: 30,
            ),
            BlocProvider(
              create: (context) => FeedbackCubit(),
              child: Builder(builder: (context) {
                return BlocListener<FeedbackCubit, FeedbackState>(
                  listener: (context, state) {
                    if (state is FeedbackCreated) {
                      Timer(
                        const Duration(milliseconds: 300),
                        () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color(0xFF0C7319),
                            content: Text("Feedback Sent Successfully"),
                          ),
                        ),
                      );
                    }

                    if (state is FeedbackError) {
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
                  child: BlocBuilder<FeedbackCubit, FeedbackState>(
                    builder: (context, state) {
                      return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<FeedbackCubit>(context)
                                .sendFeedBack(
                                    feedback: feedbackController.text);
                          },
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                          child: Text(
                            "Send Feedback",
                            
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
