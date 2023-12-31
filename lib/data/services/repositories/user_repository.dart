import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utilities/image_urls.dart';
import '../../local_storage/shared_preference_manager.dart';
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
      },SetOptions(merge: true));
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
      final email = await FirebaseAuth.instance.currentUser!.email;
      final name = await FirebaseAuth.instance.currentUser!.displayName;

      final isUserRegistered = await checkIsDataCollected();

      if (!isUserRegistered) {
        await createUserData(
          user: UserModel(name, email, "phone", "github", "linkedin", "twitter",
              userId, "technology", "imageUrl"),
          id: userId,
        );
        final user = await firebaseFirestore
            .collection("users")
            .doc(userId)
            .get()
            .then((value) => UserModel.fromJson(value.data()!));

        return user;
      } else {
        final user = await firebaseFirestore
            .collection("users")
            .doc(userId)
            .get()
            .then((value) => UserModel.fromJson(value.data()!));

        return user;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> checkIsDataCollected() async {
    try {
      final userId = await FirebaseAuth.instance.currentUser!.uid;

      final firebaseFirestore = FirebaseFirestore.instance;

      final user = await firebaseFirestore
          .collection("users")
          .where("userId", isEqualTo: userId)
          .get()
          .then((value) =>
              value.docs.map((e) => LeadsModel.fromJson(e.data())).toList());

      if (user.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
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

      debugPrint("the name is : $name");

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
      }).then((value) {
        print("Updated ");
        return true;
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
