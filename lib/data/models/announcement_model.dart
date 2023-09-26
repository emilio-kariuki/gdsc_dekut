// To parse this JSON data, do
//
//     final announcementModel = announcementModelFromJson(jsonString);

import 'dart:convert';

List<AnnouncementModel> announcementModelFromJson(String str) =>
    List<AnnouncementModel>.from(
        json.decode(str).map((x) => AnnouncementModel.fromJson(x)));

String announcementModelToJson(List<AnnouncementModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnnouncementModel {
  String? id;
  String? title;
  String? position;
  String? name;

  AnnouncementModel({
    this.id,
    this.title,
    this.position,
    this.name,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      AnnouncementModel(
        id: json["id"],
        title: json["title"],
        position: json["position"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "position": position,
        "name": name,
      };
}
