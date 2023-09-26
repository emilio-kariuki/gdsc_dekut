import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:gdsc_bloc/data/models/twitter_model.dart';
import '../../../data/services/providers/twitter_space_providers.dart';

part 'twitter_space_state.dart';

class TwitterSpaceCubit extends Cubit<TwitterSpaceState> {
  TwitterSpaceCubit() : super(TwitterSpaceInitial());

  void createSpace({
    required String title,
    required String link,
    required Timestamp startTime,
    required Timestamp endTime,
    required String image,
    required Timestamp date,
  }) async {
    try {
      emit(TwitterSpaceLoading());
      final isCreated = await TwitterSpaceProviders().createSpace(
        title: title,
        link: link,
        startTime: startTime,
        endTime: endTime,
        image: image,
        date: date,
      );
      if (isCreated) {
        emit(TwitterSpaceCreated());
      }
    } catch (e) {
      emit(TwitterSpaceError(message: e.toString()));
    }
  }

  void getAllTwitterSpaces() async {
    try {
      emit(TwitterSpaceLoading());
      final twitter = await TwitterSpaceProviders().getSpaces();
      emit(TwitterSpaceSuccess(spaces: twitter));
    } catch (e) {
      emit(const TwitterSpaceError(message: "Failed to load spaces"));
    }
  }

  void getTwitterSpaceById({required String id}) async {
    try {
      emit(TwitterSpaceLoading());
      final space = await TwitterSpaceProviders().getParticularSpaces(id: id);
      emit(TwitterSpaceFetched(space: space));
    } catch (e) {
      emit(TwitterSpaceError(message: e.toString()));
    }
  }

  void searchTwitterSpace({required String queyr}) async {
    try {
      emit(TwitterSpaceLoading());
      final spaces = await TwitterSpaceProviders().searchSpace(query: queyr);
      emit(TwitterSpaceSuccess(spaces: spaces));
    } catch (e) {
      emit(TwitterSpaceError(message: e.toString()));
    }
  }

  void updateSpace({
    required String id,
    required String title,
    required String link,
    required Timestamp startTime,
    required Timestamp endTime,
    required String image,
    required Timestamp date,
  }) async {
    try {
      emit(TwitterSpaceLoading());
      final isUpdated = await TwitterSpaceProviders().updateSpace(
        id: id,
        title: title,
        link: link,
        startTime: startTime,
        endTime: endTime,
        image: image,
        date: date,
      );
      if (isUpdated) {
        emit(TwitterSpaceUpdated());
      }
    } catch (e) {
      emit(TwitterSpaceError(message: e.toString()));
    }
  }

  void deleteTwitterSpace({required String id}) async {
    try {
      emit(TwitterSpaceLoading());
      final isDeleted =
          await TwitterSpaceProviders().deleteParticularSpace(id: id);
      if (isDeleted) {
        emit(TwitterSpaceDeleted());
      }
    } catch (e) {
      emit(TwitterSpaceError(message: e.toString()));
    }
  }
}
