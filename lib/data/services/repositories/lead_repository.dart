import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/leads_model.dart';

class LeadRepository {
  Future<bool> createLead({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String github,
    required String twitter,
    required String bio,
    required String image,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("lead").doc().set({
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "github": github,
        "twitter": twitter,
        "bio": bio,
        "image": image,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

    Future<List<LeadsModel>> getLeads() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final leads = await firebaseFirestore.collection("lead").get().then(
          (value) =>
              value.docs.map((e) => LeadsModel.fromJson(e.data())).toList());

      return leads;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<LeadsModel> getLead({required String email}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final lead = await firebaseFirestore
          .collection("lead")
          .where("email", isEqualTo: email)
          .get()
          .then((value) => value.docs.first.data());

      return LeadsModel.fromJson(lead);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> updateLead({
    required String name,
    required String email,
    required String phone,
    required String role,
    required String github,
    required String twitter,
    required String bio,
    required String image,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("lead").doc().update(
        {
          "name": name,
          "email": email,
          "phone": phone,
          "role": role,
          "github": github,
          "twitter": twitter,
          "bio": bio,
          "image": image,
        },
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteLead({required String email}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("lead")
          .where("email", isEqualTo: email)
          .get()
          .then((value) => value.docs.first.reference.delete());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
