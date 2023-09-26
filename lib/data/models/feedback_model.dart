// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

List<FeedbackModel> feedbackModelFromJson(String str) => List<FeedbackModel>.from(json.decode(str).map((x) => FeedbackModel.fromJson(x)));

String feedbackModelToJson(List<FeedbackModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackModel {
    String? email;
    String? feedback;

    FeedbackModel({
        this.email,
        this.feedback,
    });

    factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        email: json["email"],
        feedback: json["feedback"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "feedback": feedback,
    };
}
