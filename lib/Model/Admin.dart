import 'package:meta/meta.dart';
import 'dart:convert';

class AdminModel {
  String? adminId;
  String userName;
  String phone;
  String email;
  String password;
  String name;

  AdminModel({
    this.adminId,
    required this.userName,
    required this.phone,
    required this.email,
    required this.password,
    required this.name,
  });

  factory AdminModel.fromRawJson(String str) => AdminModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
    adminId: json["Admin_Id"],
    userName: json["User_Name"],
    phone: json["Phone"],
    email: json["Email"],
    password: json["Password"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Admin_Id": adminId,
    "User_Name": userName,
    "Phone": phone,
    "Email": email,
    "Password": password,
    "Name": name,
  };
}
