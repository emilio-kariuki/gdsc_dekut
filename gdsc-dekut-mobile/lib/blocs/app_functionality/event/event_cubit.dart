// ignore_for_file: unnecessary_null_comparison

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gdsc_bloc/data/models/event_model.dart';

import '../../../data/services/providers/event_providers.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  void createEvent({
    required String title,
    required String venue,
    required String organizers,
    required String link,
    required String imageUrl,
    required String description,
    required String date,
  }) async {
    try {
      emit(EventLoading());
      final isCreated = await EventProviders().createEvent(
        title: title,
        venue: venue,
        organizers: organizers,
        link: link,
        imageUrl: imageUrl,
        description: description,
        date: date,
      );

      if (isCreated) {
        emit(EventCreated());
      } else {
        emit(EventError(message: 'Failed to create event'));
      }
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }

  void getAllEvents() async {
    try {
      emit(EventLoading());
      final events = await EventProviders().getEvent();
      emit(EventSuccess(events: events));
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }

  void searchEvent({required String query}) async {
    emit(EventLoading());
    try {
      final events = await EventProviders().searchEvent(query: query);
      emit(EventSuccess(events: events));
    } catch (e) {
      emit(EventError(message: "Failed to load events"));
    }
  }

  void getPastEvents() async {
    emit(EventLoading());
    try {
      final events = await EventProviders().getPastEvent();
      emit(EventSuccess(events: events));
    } catch (e) {
      emit(EventError(message: "Failed to load events"));
    }
  }

  void searchPastEvent({required String query}) async {
    emit(EventLoading());
    try {
      final events = await EventProviders().searchPastEvent(query: query);
      emit(EventSuccess(events: events));
    } catch (e) {
      emit(EventError(message: "Failed to load events"));
    }
  }

  void getEventById({required String id}) async {
    try {
      final event = await EventProviders().getParticularEvent(id: id);

      if (event != null) {
        emit(EventFetched(event: event));
      } else {
        emit(const EventError(message: 'Failed to fetch event'));
      }
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }

  void startEventById({required String id}) async {
    try {
      final isCompleted = await EventProviders().startEvent(id: id);

      if (isCompleted) {
        emit(EventStarted());
      } else {
        emit(EventError(
          message: 'Failed to start event',
        ));
      }
    } catch (e) {
      emit(EventError(
        message: e.toString(),
      ));
    }
  }

  void completeEventById({required String id}) async {
    try {
      final isCompleted = await EventProviders().completeEvent(id: id);

      if (isCompleted) {
        emit(EventCompleted());
      } else {
        emit(EventError(message: 'Failed to complete event'));
      }
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }

  void updateEvent({
    required String id,
    required String title,
    required String venue,
    required String organizers,
    required String link,
    required String imageUrl,
    required String description,
    required String date,
  }) async {
    try {
      emit(EventLoading());
      final isUpdated = await EventProviders().updateEvent(
        id: id,
        title: title,
        venue: venue,
        organizers: organizers,
        link: link,
        imageUrl: imageUrl,
        description: description,
        date: date,
      );

      if (isUpdated) {
        emit(EventUpdated());
      } else {
        emit(const EventError(message: 'Failed to update event'));
      }
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }

  void deleteEvent({required String id}) async {
    try {
      emit(EventLoading());
      final isDeleted = await EventProviders().deleteEvent(id: id);

      if (isDeleted) {
        emit(EventDeleted());
      } else {
        emit(const EventError(message: 'Failed to delete Event'));
      }
    } catch (e) {
      emit(EventError(message: e.toString()));
    }
  }
}
