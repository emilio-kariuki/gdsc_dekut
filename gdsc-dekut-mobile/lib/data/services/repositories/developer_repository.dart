import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/developer_model.dart';

class DeveloperRepository {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<bool> contactDeveloper({required String email}) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: encodeQueryParameters(<String, String>{
          'subject':
              'Hello there i have some information i want to get from you!',
        }),
      );

      launchUrl(emailLaunchUri);

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<List<DeveloperModel>> getDevelopers() async {
    try {
      final firebaseFirestore = FirebaseFirestore.instance;

      final developers = await firebaseFirestore
          .collection("developers")
          .get()
          .then((value) => value.docs
              .map((e) => DeveloperModel.fromJson(e.data()))
              .toList());

      return developers;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
