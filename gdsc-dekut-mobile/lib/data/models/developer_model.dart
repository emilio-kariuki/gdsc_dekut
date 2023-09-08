// To parse this JSON data, do
//
//     final developerModel = developerModelFromJson(jsonString);

import 'dart:convert';

List<DeveloperModel> developerModelFromJson(String str) => List<DeveloperModel>.from(json.decode(str).map((x) => DeveloperModel.fromJson(x)));

String developerModelToJson(List<DeveloperModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeveloperModel {
    String? name;
    String? email;
    String? phone;
    String? role;

    DeveloperModel({
        this.name,
        this.email,
        this.phone,
        this.role,
    });

    factory DeveloperModel.fromJson(Map<String, dynamic> json) => DeveloperModel(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
    };
}
