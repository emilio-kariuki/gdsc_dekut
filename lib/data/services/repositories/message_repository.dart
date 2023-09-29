// ignore_for_file: unnecessary_null_comparison, avoid_print, deprecated_member_use, use_build_context_synchronously, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/data/Models/message_model.dart';
import 'package:gdsc_bloc/data/local_storage/shared_preference_manager.dart';

class MessageRepository {
  Future sendMessage({
    required String message,
    required String image,
  }) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore.collection("messages").add({
        "message": message,
        "name": await SharedPreferencesManager().getName(),
        "id": await SharedPreferencesManager().getId(),
        "time": DateTime.now().millisecondsSinceEpoch,
        "image": image,
        "timestamp": DateTime.now().toString(),
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> deleteMessage({required int time}) async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("messages")
          .where("time", isEqualTo: time)
          .get()
          .then((value) => value.docs.first.reference.delete());

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Stream<List<Message>> getMessages() async* {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final messages = firebaseFirestore
          .collection("messages")
          .orderBy("time", descending: false)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Message.fromJson(e.data())).toList());

      yield* messages;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
