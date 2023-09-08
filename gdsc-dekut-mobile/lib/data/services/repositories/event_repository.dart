import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:uuid/uuid.dart' as uuid;

import 'package:http/http.dart' as http;

import '../../models/event_model.dart';

class EventRepository {
  Future<bool> createEvent({
    required String title,
    required String venue,
    required String organizers,
    required String link,
    required String imageUrl,
    required String description,
    required String date,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final id = const uuid.Uuid().v1(options: {
        'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
        'clockSeq': 0x1234,
        'mSecs': DateTime.now().millisecondsSinceEpoch,
        'nSecs': 5678
      }); //

      await firebaseFirestore.collection("event_test").doc(id).set({
        "id": id,
        "title": title,
        "venue": venue,
        "organizers": organizers,
        "link": link,
        "imageUrl": imageUrl,
        "isCompleted": false,
        "description": description,
        "date": date,
        "duration": 120,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Stream<List<EventModel>> getEvents() async* {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final events = firebaseFirestore.collection("event_test").snapshots().map(
          (event) =>
              event.docs.map((e) => EventModel.fromJson(e.data())).toList());

      yield* events;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Stream<List<EventModel>> getEventStream() async* {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final announcement = firebaseFirestore
          .collection("event_test")
          .where("isCompleted", isEqualTo: false)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => EventModel.fromJson(e.data())).toList());

      yield* announcement;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<EventModel>> getEvent() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final event = await firebaseFirestore
          .collection("event_test")
          .where("isCompleted", isEqualTo: false)
          .get()
          .then((value) =>
              value.docs.map((e) => EventModel.fromJson(e.data())).toList());
      debugPrint(event.toString());
      return event;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<EventModel> getParticularEvent({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final event =
          await firebaseFirestore.collection("event_test").doc(id).get();

      return EventModel.fromJson(event.data()!);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<EventModel>> searchEvent({required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final events = await firebaseFirestore
          .collection("event_test")
          .where("isCompleted", isEqualTo: false)
          .get()
          .then((value) =>
              value.docs.map((e) => EventModel.fromJson(e.data())).toList());

      return events
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<EventModel>> getPastEvent() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final event = await firebaseFirestore
          .collection("event_test")
          .where("isCompleted", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => EventModel.fromJson(e.data())).toList());
      return event;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<EventModel>> searchPastEvent({required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final events = await firebaseFirestore
          .collection("event_test")
          .where("isCompleted", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => EventModel.fromJson(e.data())).toList());

      return events
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> completeEvent({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("event_test")
          .doc(id)
          .update({"isCompleted": true});

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> startEvent({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("event_test")
          .doc(id)
          .update({"isCompleted": false});

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
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
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("event_test").doc(id).update({
        "id": id,
        "title": title,
        "venue": venue,
        "organizers": organizers,
        "link": link,
        "imageUrl": imageUrl,
        "isCompleted": false,
        "description": description,
        "date": date,
        "duration": 120,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteEvent({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("event_test")
          .doc(id)
          .get()
          .then((value) => value.reference.delete());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future shareEvent({required String image, required String title}) async {
    try {
      await Share.share(
          "Hey there, check out this event on GDSC App\n\n$title\n\n$image");
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> addEventToCalendar({
    required String title,
    required String summary,
    required Timestamp startTime,
    required Timestamp endTime,
  }) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>[
      'email',
      // 'https://www.googleapis.com/auth/calendar',
      // 'https://www.googleapis.com/auth/calendar.events'
    ]);

    await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleSignIn.currentUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthClient authClient = authenticatedClient(
      http.Client(),
      AccessCredentials(
        AccessToken(
          'Bearer',
          credential.accessToken!,
          DateTime.now().toUtc().add(
                const Duration(seconds: 10),
              ),
        ),
        credential.idToken,
        ['https://www.googleapis.com/auth/calendar'],
      ),
    );
    final calendar.CalendarApi calendarApi = calendar.CalendarApi(authClient);

    calendar.Event event = calendar.Event();

    event.summary = title;
    event.description = summary;

    calendar.EventDateTime start = calendar.EventDateTime();
    start.dateTime = startTime.toDate();
    start.timeZone = "GMT+03:00";
    event.start = start;

    calendar.EventDateTime end = calendar.EventDateTime();
    end.dateTime = endTime.toDate().add(const Duration(hours: 1));
    end.timeZone = "GMT+03:00";
    event.end = end;

    try {
      await calendarApi.events.insert(event, 'primary');
      print('Event added to the calendar');
      return true;
    } catch (e) {
      print('Error creating calendar event: $e');
      return false;
    }

    // try {

    //   ////////////////////////////////////
    //   print("Called");
    //   final scopes = [
    //     calendar.CalendarApi.calendarScope,
    //     calendar.CalendarApi.calendarEventsScope,
    //     calendar.CalendarApi.calendarEventsReadonlyScope,
    //   ];

    //   var credentials = ServiceAccountCredentials.fromJson({
    //     'private_key':
    //         '-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCuJFvmMykM1KT9\nHC4lWFgkk4AGdNb87jeel/tCubJe7sN7MasYXYbgMAcrRBDUomX5NCaI4ZWIm3xX\nLgmje8gchTyK6/cfWHhdwYM1I39H6+Ykg2IaDhrIM8NW/yITPh0Oz/6V5EUsl6ic\n4oLOsoTxrHVmaHLul2QNRLPkXlMVD1DKJT/SnVEgWzcsOkEKRqPXIsaHwWaujTqy\nneqHDevzCs5aTJxZkSN6gMZC7Us2H6AMR343HKWPzI/5SmmTAzfCPyxyrtH2JqQB\nyEfvJ706y1QOcLV1c/BzpoqYRY80pkaMu4EfZSQT7Uic8Ms/ah7inl5g/YzGhZCc\nQ3XzyYp3AgMBAAECggEAB687DvF7AkHv9etkbel0GkkYATDuu8KXWbxDLjKbmGzY\n23rZnf2ikgoMhvA9/eQcs96FRM0PmDOkTQSPEFPKBNgsT8UR5qQ0y45ah+HFIBtc\n0IersJKmw+bk29XuXwMCrUCob1zfYJRgsGuechiWnUOK+rXpPHYZyCwb9Bvldqxf\nfZXGiTMwbwdPrDKGbcACJbanR2RkdsSzhu/mGNnySJ1XlbwEfekzMaqfJb452Ep6\njhXr+BDYU9jZM0+eGTr0/Nno8OkkARI5g59yXpAZS3kRH31+YOOnlI1i+NqJXMo3\nrrunGRVKQcJZC8AZIslB8VsPsuFwo2bnGZVhRFw5gQKBgQD2JrEBGa5ptJTgRizG\nY/DpmHz4Eiz/c6PUMaX85Ozd3FGpiqhNiEdmTcue0bxFJ3NtautvJJ/x/biTKT1V\nvGXaMxvNSY3zlAs994ewgv/fQuEHmu0ASrFGSv6aEEg+n36HNPGnwtEOXpoYtigx\n97UFUmtkL3q1Xt4kgzkUmZ93sQKBgQC1HBVXPp9yBi0jPxYZQNopoKgye6DPDMc0\nnEiRJufFRo6i8gXWQnGm98n5Bn3lQlb3cu7R/pYpEGFwOo6Ly+YcEj7U0dcjllBI\nIj6lDcB8/QRypIAAYAvq7+rnIHbsFV6WiiBvx9SV+DFNGrtrWTMWf9KS+/G2C/zj\nYTr9s51WpwKBgGLrX5yilm3SbTXH3byIc0tcxXPn0f+CmGbw4NTFps7t+D9bApHN\n32ukfdzASpm75e4l1qFepYxZOzCglQ58XK4YdebE1W/6oZ3weK4dpvgw5z/oKbBB\nVAZ8ot6FBpNsAywQwcB6UQsmR2UA5xxVgIC4A4JKdlSm4DzqIyk9J1GxAoGABBWc\nDZml8uZcwjy7/NnPkbzDzk+ncsPxAii8IjnkZDiRIu+eXhSlh4RzE6Cn2jHC0FXR\nOP8q18Y8zFElwdVZXSy0KgyJc44CRX4wN3y16Ju0K/m1wUxpOGUswQWkaPKabX6z\n+JFjI/ay9fAyZdtfIZTEZPg1nUtr6pzYvbv9QmUCgYAF243whL/waoHGl3NpqQ1X\nrNL3xpAs9+WcnwkTCUtqvclnZMEoKypUooDLzluN2G5bxwPYyllOI3g08GnqtW1Y\nPN4QEqRA5hx1WOxajjNXY8i8m1yO7S0tvCcicSdoiGwl8Tk6Ae+q6FjUSB0CGhYH\n1lCe5Avx/qBvfJ4pG3dNyw==\n-----END PRIVATE KEY-----\n',
    //     'client_email': 'exemplary-oven-364223@appspot.gserviceaccount.com',
    //     'client_id':
    //         '377119171510-p8tcasg9ldjo5lrofb2kkc0aiprgn9oc.apps.googleusercontent.com',
    //     'type': 'service_account'
    //   });

    //   print("Step 1");

    //   var client = await clientViaServiceAccount(credentials, scopes);
    //   var calendarApi = calendar.CalendarApi(client);
    //   var event = calendar.Event();
    //   event.summary = "Flutter Event";
    //   print("Step 2");
    //   event.start = calendar.EventDateTime(dateTime: DateTime.now());
    //   event.end = calendar.EventDateTime(
    //       dateTime: DateTime.now().add(const Duration(hours: 1)));

    //   await calendarApi.events.insert(event, 'primary');

    //   print("Event created");

    //   return true;
    // } catch (e) {
    //   debugPrint(e.toString());

    //   return false;
    // }
  }
}
