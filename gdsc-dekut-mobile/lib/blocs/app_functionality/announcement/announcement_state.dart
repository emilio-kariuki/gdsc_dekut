part of 'announcement_cubit.dart';

sealed class AnnouncementState extends Equatable {
  const AnnouncementState();

  @override
  List<Object> get props => [];
}

final class AnnouncementInitial extends AnnouncementState {}

final class AnnouncementLoading extends AnnouncementState {}

final class AnnouncementSuccess extends AnnouncementState {
  final List<AnnouncementModel> announcements;

  const AnnouncementSuccess({required this.announcements});

  @override
  List<Object> get props => [announcements];
}

final class AnnouncementFetched extends AnnouncementState {
  final AnnouncementModel announcement;

  const AnnouncementFetched({required this.announcement});

  @override
  List<Object> get props => [announcement];
}

final class AnnoucementCreated extends AnnouncementState {}

final class AnnouncementUpdated extends AnnouncementState {}

final class AnnouncementDeleted extends AnnouncementState {}

final class AnnouncementFailure extends AnnouncementState {
  final String message;

  const AnnouncementFailure({required this.message});

  @override
  List<Object> get props => [message];
}
