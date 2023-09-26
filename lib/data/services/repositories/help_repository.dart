import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/feedback_model.dart';
import '../../models/report_model.dart';

class HelpRepository {
    Future<bool> reportProblem({
    required String title,
    required String description,
    required String appVersion,
    required String contact,
    required String image,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final email = await FirebaseAuth.instance.currentUser!.email;
      await firebaseFirestore.collection("problem").add({
        "email": email,
        "title": title,
        "description": description,
        "appVersion": appVersion,
        "contact": contact,
        "image": image,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

    Future<bool> createFeedback({
    required String feedback,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final email = await FirebaseAuth.instance.currentUser!.email;

      await firebaseFirestore.collection("feedback").add({
        "email": email,
        "feedback": feedback,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

    Future<List<ReportModel>> getReports() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final problem = await firebaseFirestore.collection("problem").get().then(
          (value) =>
              value.docs.map((e) => ReportModel.fromJson(e.data())).toList());

      return problem;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<FeedbackModel>> getFeedback() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final feedback = await firebaseFirestore
          .collection("feedback")
          .get()
          .then((value) =>
              value.docs.map((e) => FeedbackModel.fromJson(e.data())).toList());

      return feedback;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }







}