import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/event_model.dart';
import '../repositories/event_repository.dart';

class EventProviders {
  Future<bool> createEvent({
    required String title,
    required String venue,
    required String organizers,
    required String link,
    required String imageUrl,
    required String description,
    required String date,
  }) async {
    final response = await EventRepository().createEvent(
      title: title,
      venue: venue,
      organizers: organizers,
      link: link,
      imageUrl: imageUrl,
      description: description,
      date: date,
    );
    return response;
  }

  Stream<List<EventModel>> getEvents() {
    return EventRepository().getEvents();
  }

  Future<List<EventModel>> getEvent() {
    return EventRepository().getEvent();
  }

  Future<List<EventModel>> searchEvent({required String query}) async {
    final response = await EventRepository().searchEvent(query: query);
    return response;
  }

  Future<List<EventModel>> getPastEvent() async {
    final response = await EventRepository().getPastEvent();
    return response;
  }

  Future<List<EventModel>> searchPastEvent({required String query}) async {
    final response = await EventRepository().searchPastEvent(query: query);
    return response;
  }

  Future<EventModel> getParticularEvent({required String id}) async {
    final response = await EventRepository().getParticularEvent(id: id);
    return response;
  }

  Future<bool> startEvent({required String id}) async {
    final response = await EventRepository().startEvent(id: id);
    return response;
  }

  Future<bool> completeEvent({required String id}) async {
    final response = await EventRepository().completeEvent(id: id);
    return response;
  }

  Future<bool> updateEvent({
    required String id,
   required String title,
    required String venue,
    required String organizers,
    required String link,
    required String imageUrl,
    required String description,
    required String date,
  }) async {
    final response = await EventRepository().updateEvent(
      id: id,
      title: title,
      venue: venue,
      organizers: organizers,
      link: link,
      imageUrl: imageUrl,
      description: description,
      date: date,
    );
    return response;
  }

  Future<bool> deleteEvent({required String id}) async {
    final response = await EventRepository().deleteEvent(id: id);
    return response;
  }

  Future shareEvent({required String image, required String title}) async {
    final response =
        await EventRepository().shareEvent(image: image, title: title);
    return response;
  }

  // Future<bool> addEventToCalendar(
  //     {required String summary,
  //     required Timestamp start,
  //     required Timestamp end}) async {
  //   final response = await Repository()
  //       .addEventToCalendar(summary: summary, startTime: start, endTime: end);

  //   return response;
  // }
}
