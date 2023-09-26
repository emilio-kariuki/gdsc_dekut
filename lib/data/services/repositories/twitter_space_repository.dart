import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart' as uuid;

import '../../models/twitter_model.dart';

class TwitterSpaceRepository {
  Future<bool> createSpace({
    required String title,
    required String link,
    required Timestamp startTime,
    required Timestamp endTime,
    required String image,
    required Timestamp date,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final id = const uuid.Uuid().v1(options: {
        'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
        'clockSeq': 0x1234,
        'mSecs': DateTime.now().millisecondsSinceEpoch,
        'nSecs': 5678
      }); //

      await firebaseFirestore
          .collection(kReleaseMode ? "twitter" : "twitter_test")
          .doc(id)
          .set({
        "id": id,
        "title": title,
        "link": link,
        "image": image,
        "startTime": startTime,
        "endTime": endTime,
        "date": date,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<TwitterModel>> getSpaces() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final spaces = await firebaseFirestore
          .collection(kReleaseMode ? "twitter" : "twitter_test")
          .get()
          .then((value) =>
              value.docs.map((e) => TwitterModel.fromJson(e.data())).toList());
      return spaces;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<TwitterModel> getParticularSpaces({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final space = await firebaseFirestore
          .collection(kReleaseMode ? "twitter" : "twitter_test")
          .doc(id)
          .get()
          .then((value) => TwitterModel.fromJson(value.data()!));
      return space;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<TwitterModel>> searchSpace({required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final spaces = await firebaseFirestore
          .collection(kReleaseMode ? "twitter" : "twitter_test")
          .get()
          .then((value) =>
              value.docs.map((e) => TwitterModel.fromJson(e.data())).toList());

      return spaces
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> updateSpace({
    required String id,
    required String title,
    required String link,
    required Timestamp startTime,
    required Timestamp endTime,
    required String image,
    required Timestamp date,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "twitter" : "twitter_test")
          .doc(id)
          .update(
        {
          "id": id,
          "title": title,
          "link": link,
          "image": image,
          "startTime": startTime,
          "endTime": endTime,
          "date": date,
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteParticularSpace({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "twitter" : "twitter_test")
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
