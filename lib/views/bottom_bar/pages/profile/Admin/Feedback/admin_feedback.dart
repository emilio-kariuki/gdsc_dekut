import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../blocs/minimal_functonality/feedback/feedback_cubit.dart';
import '../../../../../../utilities/Widgets/admin/feedback/admin_feedback_card.dart';

class AppFeedback extends StatelessWidget {
  const AppFeedback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => FeedbackCubit()..getAllFeedbacks(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
            title: Text(
              "Admin Feedback",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<FeedbackCubit>(context).getAllFeedbacks();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<FeedbackCubit, FeedbackState>(
                  builder: (context, state) {
                    if (state is FeedbackLoading) {
                      return SizedBox(
                        height: height * 0.75,
                        child: const Center(
                          child: LoadingCircle(),
                        ),
                      );
                    } else if (state is FeedbackSuccess) {
                      return state.feedbacks.isEmpty
                          ? SizedBox(
                              height: height * 0.5,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(AppImages.oops,
                                      height: height * 0.2),
                                  Text(
                                    "feedbacks not found",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: const Color(0xff666666),
                                    ),
                                  ),
                                ],
                              )),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: BlocConsumer<FeedbackCubit, FeedbackState>(
                                listener: (context, appState) {},
                                builder: (context, appState) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.feedbacks.length,
                                    itemBuilder: (context, index) {
                                      return AdminFeedbackCard(
                                        width: width,
                                        height: height,
                                        title: state.feedbacks[index].email!,
                                        about: state.feedbacks[index].feedback!,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                    } else if (state is FeedbackError) {
                      return SizedBox(
                        height: height * 0.9,
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(AppImages.oops, height: height * 0.2),
                            Text(
                              "feedbacks not found",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: const Color(0xff666666),
                              ),
                            ),
                          ],
                        )),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
