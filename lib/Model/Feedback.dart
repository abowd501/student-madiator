import 'package:meta/meta.dart';
import 'dart:convert';

class FeedbackModel {
  String? feedbackId;
  String? feedback;
  String? feedbackTime;
  String? studentId;

  FeedbackModel({
    required this.feedbackId,
    required this.feedback,
    required this.feedbackTime,
    required this.studentId,
  });

  factory FeedbackModel.fromRawJson(String str) => FeedbackModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
    feedbackId: json["Feedback_Id"],
    feedback: json["Feedback"],
    feedbackTime: json["Feedback_Time"],
    studentId: json["Student_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Feedback_Id": feedbackId,
    "Feedback": feedback,
    "Feedback_Time": feedbackTime,
    "Student_Id": studentId,
  };
}
