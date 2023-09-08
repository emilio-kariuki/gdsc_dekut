import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../blocs/minimal_functonality/network_observer/network_bloc.dart';

class AppRepository {
  observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(const NetworkNotify());
      } else {
        NetworkBloc().add(const NetworkNotify(isConnected: true));
      }
    });
  }

  Future<File> getImage() async {
    await [
      Permission.storage,
      Permission.photos,
      Permission.mediaLibrary,
    ].request();
    final imagePicker = ImagePicker();
    try {
      var pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        return File(pickedImage.path);
      } else {
        throw Exception("No image selected");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<String> uploadImage({required File image}) async {
    try {
      final imageUrl = await FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().toString()}.png")
          .putFile(image);

      return await imageUrl.ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> openLink({required String link}) async {
    try {
      if (await canLaunchUrl(Uri.parse(link.trim()))) {
        await launch(link, forceSafariVC: false);
      } else {
        throw 'Could not launch $link';
      }
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> copyToClipboard({required String text}) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));

      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<bool> downloadAndSaveImage(
      {required String url, required String fileName}) async {
    try {
      final directory = await getTemporaryDirectory();
      final path = directory.path;
      await Dio().download(url, '$path/$url');
      GallerySaver.saveImage('$path/$url', albumName: "GDSC");

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future share({required String message}) async {
    try {
      await Share.share(message);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future tweet({required String message}) async {
    try {
      var tweetUrl =
          'https://twitter.com/intent/tweet?text=${Uri.encodeComponent(message)}';
      if (await canLaunch(tweetUrl)) {
        await launch(tweetUrl);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<String> selectDate({required BuildContext context}) async {
    try {
      final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
          const Duration(days: 30),
        ),
      );

      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      return DateTime(
        date!.year,
        date.month,
        date.day,
        time!.hour,
        time.minute,
      ).toString();
    } catch (e) {
      debugPrint(e.toString());
      throw Exception("Error fetching appointment time");
    }
  }

  Future<String> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return pickedTime!.format(context);
  }

  Future<Timestamp> selectSpaceTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    final DateTime now = DateTime.now();
    final DateTime date = DateTime(now.year, now.month, now.day);
    final DateTime dateTime = DateTime(
        date.year, date.month, date.day, pickedTime!.hour, pickedTime.minute);
    return Timestamp.fromDate(dateTime);
  }
}
