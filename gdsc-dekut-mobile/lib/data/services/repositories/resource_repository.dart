import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import "package:uuid/uuid.dart" as uuid;

import '../../../utilities/shared_preference_manager.dart';
import '../../models/resource_model.dart';

class ResourceRepository {
  Future<bool> createResource({
    required String title,
    required String link,
    required String imageUrl,
    required String description,
    required String category,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final id = const uuid.Uuid().v1(options: {
        'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
        'clockSeq': 0x1234,
        'mSecs': DateTime.now().millisecondsSinceEpoch,
        'nSecs': 5678
      }); //

      final userId = await FirebaseAuth.instance.currentUser!.uid;

      await firebaseFirestore
          .collection(kReleaseMode
              ? kReleaseMode
                  ? "resource"
                  : "resource_test"
              : "resource_test")
          .doc(id)
          .set({
        "id": id,
        "title": title,
        "link": link,
        "imageUrl": imageUrl,
        "description": description,
        "category": category,
        "isApproved": false,
        "userId": userId,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> updateResource({
    required String id,
    required String title,
    required String link,
    required String imageUrl,
    required String description,
    required String category,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .doc(id)
          .update({
        "id": id,
        "title": title,
        "link": link,
        "imageUrl": imageUrl,
        "description": description,
        "category": category,
        "isApproved": true,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> createAdminResource({
    required String title,
    required String link,
    required String imageUrl,
    required String description,
    required String category,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final id = const uuid.Uuid().v1(options: {
        'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
        'clockSeq': 0x1234,
        'mSecs': DateTime.now().millisecondsSinceEpoch,
        'nSecs': 5678
      }); //

      final userId = await FirebaseAuth.instance.currentUser!.uid;

      await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .doc(id)
          .set({
        "id": id,
        "title": title,
        "link": link,
        "imageUrl": imageUrl,
        "description": description,
        "category": category,
        "isApproved": true,
        "userId": userId,
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> getAllResources() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("isApproved", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());
      return resources;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> getUserResources() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final userId = await SharedPreferencesManager().getId();

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("userId", isEqualTo: userId)
          .where("isApproved", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());
      return resources;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<Resource> getParticularResource({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final event = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .doc(id.trim())
          .get();

      return Resource.fromJson(event.data()!);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> approveResource({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .doc(id)
          .update({"isApproved": true});

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> getResources({required String category}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where(
            "category",
            isEqualTo: category,
          )
          .where("isApproved", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());
      return resources;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> getResource() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection("resources")
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());
      return resources;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> searchResources({required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("isApproved", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());

      return resources
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> getUnApprovedResources() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("isApproved", isEqualTo: false)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());
      return resources;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> searchUnApprovedResources(
      {required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("isApproved", isEqualTo: false)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());

      return resources
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> searchCategoryResources(
      {required String query, required String category}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("isApproved", isEqualTo: true)
          .where("category", isEqualTo: category)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());

      return resources
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<Resource>> searchUserResources({required String query}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final userId = await SharedPreferencesManager().getId();
      final resources = await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
          .where("userId", isEqualTo: userId)
          .where("isApproved", isEqualTo: true)
          .get()
          .then((value) =>
              value.docs.map((e) => Resource.fromJson(e.data())).toList());

      return resources
          .where((element) =>
              element.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteResource({required String id}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection(kReleaseMode ? "resource" : "resource_test")
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
