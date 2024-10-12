import 'package:meta/meta.dart';
import 'dart:convert';

class DBStudentsModel {
  String dbId;
  String regstNum;
  String studentName;

  DBStudentsModel({
    required this.dbId,
    required this.regstNum,
    required this.studentName,
  });

  factory DBStudentsModel.fromRawJson(String str) => DBStudentsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DBStudentsModel.fromJson(Map<String, dynamic> json) => DBStudentsModel(
    dbId: json["DB_Id"],
    regstNum: json["Regst_Num"],
    studentName: json["Student_Name"],
  );

  Map<String, dynamic> toJson() => {
    "DB_Id": dbId,
    "Regst_Num": regstNum,
    "Student_Name": studentName,
  };
}
