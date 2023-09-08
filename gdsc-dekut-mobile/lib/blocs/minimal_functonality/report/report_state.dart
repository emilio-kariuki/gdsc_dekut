part of 'report_cubit.dart';

sealed class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}


final class ReportSuccess extends ReportState {
  final List<ReportModel> reports;

  const ReportSuccess({required this.reports});

  @override
  List<Object> get props => [reports];
}

final class ReportFetched extends ReportState {
  final ReportModel report;

  const ReportFetched({required this.report});

  @override
  List<Object> get props => [report];
}

final class ReportCreated extends ReportState {}


final class ReportDeleted extends ReportState {}

final class ReportError extends ReportState {
  final String message;

  const ReportError({required this.message});

  @override
  List<Object> get props => [message];
}
