// To parse this JSON data, do
//
//     final resource = resourceFromJson(jsonString);

import 'dart:convert';

Resource resourceFromJson(String str) => Resource.fromJson(json.decode(str));

String resourceToJson(Resource data) => json.encode(data.toJson());

class Resource {
  String? id;
  String? title;
  String? link;
  String? description;
  String? imageUrl;
  String? category;
  bool? isApproved;
  String? userId;

  Resource(
      {
      this.id,
        this.title,
      this.link,
      this.description,
      this.imageUrl,
      this.category,
      this.isApproved,
      this.userId});

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        isApproved: json["isApproved"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "description": description,
        "imageUrl": imageUrl,
        "category": category,
        "isApproved": isApproved,
        "userId": userId,
      };
}
