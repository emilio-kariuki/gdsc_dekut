// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  String name;
  String id;
  String message;
  int time;
  String image;
  DateTime timestamp;

  Message({
    required this.name,
    required this.id,
    required this.message,
    required this.time,
    required this.timestamp,
    required this.image,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        image: json["image"],
        name: json["name"],
        id: json["id"],
        message: json["message"],
        time: json["time"],
        timestamp: DateTime.parse(json["timestamp"])
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "id": id,
        "message": message,
        "time": time,
        "timestamp": timestamp.toIso8601String()
      };
}
