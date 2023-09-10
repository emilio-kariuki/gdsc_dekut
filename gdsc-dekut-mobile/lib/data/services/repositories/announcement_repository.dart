import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../../models/announcement_model.dart';

class AnnouncementRepository {
  Future<bool> createAnnouncement(
      {required String name,
      required String position,
      required String title}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final id = const uuid.Uuid().v1(options: {
        'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
        'clockSeq': 0x1234,
        'mSecs': DateTime.now().millisecondsSinceEpoch,
        'nSecs': 5678
      }); //

      await firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .doc(id)
          .set({
        "id": id,
        "name": name,
        "position": position,
        "title": title,
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<AnnouncementModel> getParticularAnnouncement(
      {required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final group = await firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .doc(id)
          .get()
          .then((value) => AnnouncementModel.fromJson(value.data()!));
      return group;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<AnnouncementModel>> getAllAnnouncements() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final announcements = await firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .get()
          .then((value) => value.docs
              .map((e) => AnnouncementModel.fromJson(e.data()))
              .toList());

      return announcements;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Stream<List<AnnouncementModel>> getAnnoucements() async* {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final announcement = firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .snapshots()
          .map((event) => event.docs
              .map((e) => AnnouncementModel.fromJson(e.data()))
              .toList());

      yield* announcement;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<AnnouncementModel>> searchAnnouncement(
      {required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final announcement = await firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .get()
          .then((value) => value.docs
              .map((e) => AnnouncementModel.fromJson(e.data()))
              .toList());

      return announcement
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> updateAnnouncement({
    required String id,
    required String title,
    required String position,
    required String name,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .doc(id)
          .update(
        {
          "id": id,
          "name": name,
          "position": position,
          "title": title,
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteAnnoucement({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "announcement" : "announcement_test")
          .doc(id)
          .get()
          .then((value) => value.reference.delete());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
