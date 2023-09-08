// To parse this JSON data, do
//
//     final reportModel = reportModelFromJson(jsonString);

import 'dart:convert';

List<ReportModel> reportModelFromJson(String str) => List<ReportModel>.from(json.decode(str).map((x) => ReportModel.fromJson(x)));

String reportModelToJson(List<ReportModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReportModel {
    String? email;
    String? title;
    String? description;
    String? image;
    String? contact;
    String? appVersion;

    ReportModel({
        this.email,
        this.title,
        this.description,
        this.image,
        this.contact,
        this.appVersion,
    });

    factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        email: json["email"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        contact: json["contact"],
        appVersion: json["appVersion"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "title": title,
        "description": description,
        "image": image,
        "contact": contact,
        "appVersion": appVersion,
    };
}
