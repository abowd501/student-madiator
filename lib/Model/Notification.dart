import 'dart:convert';

class NotificationModel {
  String? notificationId;
  String node;
  String notificationTime;
  String studentId;

  NotificationModel({
    this.notificationId,
    required this.node,
    required this.notificationTime,
    required this.studentId,
  });

  factory NotificationModel.fromRawJson(String str) => NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    notificationId: json["Notification_Id"],
    node: json["Node"],
    notificationTime: json["Notification_Time"],
    studentId: json["Student_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Notification_Id": notificationId,
    "Node": node,
    "Notification_Time": notificationTime,
    "Student_Id": studentId,
  };
}
