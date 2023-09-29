import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:uuid/uuid.dart" as uuid;

import '../../models/groups_model.dart';

class GroupRepository {
  Future<bool> createGroup({
    required String title,
    required String description,
    required String imageUrl,
    required String link,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final id = const uuid.Uuid().v1(options: {
        'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
        'clockSeq': 0x1234,
        'mSecs': DateTime.now().millisecondsSinceEpoch,
        'nSecs': 5678
      }); //

      await firebaseFirestore.collection("announcements").doc(id).set({
        "id": id,
        "title": title,
        "link": link,
        "imageUrl": imageUrl,
        "description": description,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<GroupsModel>> getGroups() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final groups = await firebaseFirestore.collection("announcements").get().then(
          (value) =>
              value.docs.map((e) => GroupsModel.fromJson(e.data())).toList());

      debugPrint("The number of groups are : ${groups.length}");
      return groups;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<GroupsModel>> searchGroup({required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final group = await firebaseFirestore.collection("announcements").get().then(
          (value) =>
              value.docs.map((e) => GroupsModel.fromJson(e.data())).toList());

      return group
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<GroupsModel> getParticularGroup({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final group = await firebaseFirestore
          .collection("announcements")
          .doc(id)
          .get()
          .then((value) => GroupsModel.fromJson(value.data()!));
      return group;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> updateGroup({
    required String id,
    required String title,
    required String description,
    required String imageUrl,
    required String link,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("announcements").doc(id).update(
        {
          "id": id,
          "title": title,
          "link": link,
          "imageUrl": imageUrl,
          "description": description,
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteParticularGroup({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("announcements")
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
