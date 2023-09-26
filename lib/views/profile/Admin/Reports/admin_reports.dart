import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../blocs/minimal_functonality/report/report_cubit.dart';
import '../../../../utilities/Widgets/admin/feedback/admin_reports_card.dart';

class AppReports extends StatelessWidget {
  const AppReports({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ReportCubit()..getAllReports(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
            title: Text(
              "Admin Reports",
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: const Color(0xff666666),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
               context.read<ReportCubit>().getAllReports();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<ReportCubit, ReportState>(
                  builder: (context, state) {
                    if (state is ReportLoading) {
                      return SizedBox(
                        height: height * 0.75,
                        child: const Center(
                          child: LoadingCircle(),
                        ),
                      );
                    } else if (state is ReportSuccess) {
                      return state.reports.isEmpty
                          ? SizedBox(
                              height: height * 0.5,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(AppImages.oops,
                                      height: height * 0.2),
                                  Text(
                                    "reports not found",
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
                              child: BlocConsumer<ReportCubit,
                                  ReportState>(
                                listener: (context, appState) {},
                                builder: (context, appState) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.reports.length,
                                    itemBuilder: (context, index) {
                                      return AdminReportCard(
                                        width: width,
                                        height: height,
                                        title: state.reports[index].email!,
                                        about: state.reports[index].description!,
                                        image: state.reports[index].image!,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                    } else if (state is ReportError) {
                      return SizedBox(
                        height: height * 0.9,
                        child: Center(
                            child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(AppImages.oops, height: height * 0.2),
                            Text(
                              "reports not found",
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
