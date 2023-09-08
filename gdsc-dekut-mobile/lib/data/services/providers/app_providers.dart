import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_bloc/data/services/repositories/app_repository.dart';

class AppProviders {
  Future<File> getImage() async {
    final response = await AppRepository().getImage();
    return response;
  }

  Future<String> uploadImage({required File image}) async {
    final imageUrl = await AppRepository().uploadImage(image: image);
    return imageUrl;
  }

  Future<bool> openLink({required String link}) async {
    final response = await AppRepository().openLink(link: link);
    return response;
  }

  Future<bool> copyToClipboard({required String text}) async {
    final response = await AppRepository().copyToClipboard(text: text);
    return response;
  }

  Future<bool> downloadAndSaveImage(
      {required String url, required String fileName}) async {
    final response = await AppRepository().downloadAndSaveImage(
      url: url,
      fileName: fileName,
    );

    return response;
  }

  Future share({required String message}) async {
    final response = await AppRepository().share(message: message);
    return response;
  }

  Future tweet({required String message}) async {
    final response = await AppRepository().tweet(message: message);
    return response;
  }

  Future<String> selectTime(BuildContext context) async {
    final response = await AppRepository().selectTime( context);
    return response;
  }

  Future<Timestamp> selectSpaceTime(BuildContext context) async {
    final response = await AppRepository().selectSpaceTime(context);
    return response;
  }

  Future<String> selectDate(BuildContext context) async {
    final response = await AppRepository().selectDate(context: context);
    debugPrint(response.toString());
    return response;
  }
}
