import 'dart:convert';

class ComplaintsModel {
  String? complaintId;
  String complaint;
  String complaintTime;
  String studentId;

  ComplaintsModel({
    this.complaintId,
    required this.complaint,
    required this.complaintTime,
    required this.studentId,
  });

  factory ComplaintsModel.fromRawJson(String str) => ComplaintsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ComplaintsModel.fromJson(Map<String, dynamic> json) => ComplaintsModel(
    complaintId: json["Complaint_Id"],
    complaint: json["Complaint"],
    complaintTime: json["Complaint_Time"],
    studentId: json["Student_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Complaint_Id": complaintId,
    "Complaint": complaint,
    "Complaint_Time": complaintTime,
    "Student_Id": studentId,
  };
}
