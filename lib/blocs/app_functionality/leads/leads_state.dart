part of 'leads_cubit.dart';

sealed class LeadsState extends Equatable {
  const LeadsState();

  @override
  List<Object> get props => [];
}

final class LeadsInitial extends LeadsState {}

final class LeadsLoading extends LeadsState {}

final class LeadsSuccess extends LeadsState {
  final List<LeadsModel> leads;

  const LeadsSuccess({required this.leads});

  @override
  List<Object> get props => [leads];
}

final class LeadsFetched extends LeadsState {
  final LeadsModel lead;

  const LeadsFetched({required this.lead});

  @override
  List<Object> get props => [lead];
}

final class LeadsCreated extends LeadsState {}

final class LeadsUpdated extends LeadsState {}

final class LeadsDeleted extends LeadsState {}

final class LeadsError extends LeadsState {
  final String message;

  const LeadsError({required this.message});

  @override
  List<Object> get props => [message];
}
