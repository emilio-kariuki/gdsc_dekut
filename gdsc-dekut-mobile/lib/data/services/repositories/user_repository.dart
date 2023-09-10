import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utilities/image_urls.dart';
import '../../../utilities/shared_preference_manager.dart';
import '../../models/leads_model.dart';
import '../../models/user_model.dart';

class UserRepository {
  Future<bool> createUserData(
      {required UserModel user, required String id}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(id).set({
        "username": user.name,
        "email": user.email,
        "phone": user.phone,
        "github": user.github,
        "linkedin": user.linkedin,
        "twitter": user.twitter,
        "userID": user.userID,
        "technology": user.technology,
        "imageUrl": user.imageUrl ?? AppImages.defaultImage,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<UserModel> getUser() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;
      final userId = await SharedPreferencesManager().getId();

      final user = await firebaseFirestore
          .collection("users")
          .doc(userId)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));

      return user;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> updateUser({
    required String name,
    required String email,
    required String phone,
    required String github,
    required String linkedin,
    required String twitter,
    required String userId,
    required String technology,
    required String image,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("users").doc(userId).update({
        "username": name,
        "email": email,
        "phone": phone,
        "github": github,
        "linkedin": linkedin,
        "twitter": twitter,
        "userID": userId,
        "technology": technology,
        "imageUrl": image,
      });

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> isUserAdmin() async {
    try {
      final userEmail = await FirebaseAuth.instance.currentUser!.email;
      final firebaseFirestore = FirebaseFirestore.instance;


      final lead = await firebaseFirestore
          .collection("lead")
          .where("email", isEqualTo: userEmail)
          .get()
          .then((value) =>
              value.docs.map((e) => LeadsModel.fromJson(e.data())).toList());

      if (lead.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
