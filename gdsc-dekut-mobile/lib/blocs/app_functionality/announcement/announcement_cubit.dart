// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/models/announcement_model.dart';

import '../../../data/services/providers/announcement_providers.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(AnnouncementInitial());

  void createAnnouncement({
    required String title,
    required String name,
    required String position,
  }) async {
    try {
      emit(AnnouncementLoading());
      final isCreated = await AnnouncementProviders().createAnnouncement(
        title: title,
        name: name,
        position: position,
      );

      if (isCreated) {
        emit(AnnoucementCreated());
      } else {
        emit(AnnouncementFailure(message: "Error creating announcement"));
      }
    } catch (e) {
      emit(AnnouncementFailure(message: "Error creating announcement"));
    }
  }

  void getAllAnnoucements() async {
    try {
      emit(AnnouncementLoading());
      final announcements = await AnnouncementProviders().getAllAnnouncements();
      emit(AnnouncementSuccess(announcements: announcements));
    } catch (e) {
      emit(AnnouncementFailure(message: e.toString()));
    }
  }

  void getAnnouncementById({required String id}) async {
    try {
      final announcement =
          await AnnouncementProviders().getParticularAnnouncement(id: id);

      if (announcement != null) {
        emit(AnnouncementFetched(announcement: announcement));
      } else {
        emit(
            const AnnouncementFailure(message: 'Failed to fetch Announcement'));
      }
    } catch (e) {
      emit(AnnouncementFailure(message: e.toString()));
    }
  }

  void searchAnnouncement({required String query}) async {
    try {
      emit(AnnouncementLoading());
      final announcements =
          await AnnouncementProviders().searchAnnouncement(query: query);
      emit(AnnouncementSuccess(announcements: announcements));
    } catch (e) {
      emit(AnnouncementFailure(message: e.toString()));
    }
  }

  void updateAnnouncement(
      {required String id,
      required String name,
      required String position,
      required String title}) async {
    try {
      emit(AnnouncementLoading());
      final user = await AnnouncementProviders().updateParticularAnnouncement(
        id: id,
        name: name,
        position: position,
        title: title,
      );

      if (user) {
        emit(AnnouncementUpdated());
      } else {
        emit(const AnnouncementFailure(message: 'Failed to update user'));
      }
    } catch (e) {
      emit(AnnouncementFailure(message: e.toString()));
    }
  }

  void deleteAnnouncement({required String id}) async {
    try {
      emit(AnnouncementLoading());
      final isDeleted =
          await AnnouncementProviders().deleteParticularAnnouncement(id: id);

      if (isDeleted) {
        emit(AnnouncementDeleted());
      } else {
        emit(const AnnouncementFailure(
            message: 'Failed to delete announcement'));
      }
    } catch (e) {
      emit(AnnouncementFailure(message: e.toString()));
    }
  }
}
