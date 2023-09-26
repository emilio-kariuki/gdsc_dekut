// To parse this JSON data, do
//
//     final twitterModel = twitterModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<TwitterModel> twitterModelFromJson(String str) => List<TwitterModel>.from(json.decode(str).map((x) => TwitterModel.fromJson(x)));

String twitterModelToJson(List<TwitterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TwitterModel {
    String? title;
    String? link;
    String? image;
    String ? id;
    Timestamp startTime;
    Timestamp endTime;
    Timestamp? date;

    TwitterModel({
        required this.id,
        this.title,
        this.link,
        this.image,
        this.date,
        required this.startTime,
        required this.endTime,
    });

    factory TwitterModel.fromJson(Map<String, dynamic> json) => TwitterModel(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        image: json["image"],
        startTime: json["startTime"],
        date: json["date"],
        endTime: json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "image": image,
        "startTime": startTime,
        "date": date,
        "endTime": endTime,
    };
}
