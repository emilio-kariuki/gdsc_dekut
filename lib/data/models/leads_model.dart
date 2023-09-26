// To parse this JSON data, do
//
//     final leadsModel = leadsModelFromJson(jsonString);

import 'dart:convert';

LeadsModel leadsModelFromJson(String str) => LeadsModel.fromJson(json.decode(str));

String leadsModelToJson(LeadsModel data) => json.encode(data.toJson());

class LeadsModel {
    String? name;
    String? email;
    String? phone;
    String? twitter;
    String? github;
    String? image;
    String? role;
    String? bio;
    String?id;

    LeadsModel({
        this.name,
        this.email,
        this.phone,
        this.twitter,
        this.github,
        this.image,
        this.role,
        this.bio,
        this.id,
    });

    factory LeadsModel.fromJson(Map<String, dynamic> json) => LeadsModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        twitter: json["twitter"],
        github: json["github"],
        image: json["image"],
        role: json["role"],
        bio: json["bio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "twitter": twitter,
        "github": github,
        "image": image,
        "role": role,
        "bio": bio,
    };
}
