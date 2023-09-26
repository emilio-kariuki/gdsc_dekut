import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/models/report_model.dart';

import '../../../data/services/providers/help_providers.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());

  void reportProblem({
    required String title,
    required String description,
    required String appVersion,
    required String contact,
    required String image,
  }) async {
    try {
      emit(ReportLoading());
      final isSent = await HelpProviders().reportProblem(
        title: title,
        description: description,
        appVersion: appVersion,
        contact: contact,
        image: image,
      );

      if (isSent) {
        emit(ReportCreated());
      } else {
        emit(const ReportError(message: 'Failed to report problem'));
      }
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }

  void getAllReports() async {
    try {
      emit(ReportLoading());
      final reports = await HelpProviders().getReports();
      emit(ReportSuccess(reports: reports));
    } catch (e) {
      emit(ReportError(message: e.toString()));
    }
  }
}
