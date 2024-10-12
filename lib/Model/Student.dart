import 'package:meta/meta.dart';
import 'dart:convert';

class StudentModel {
  String? studentId;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? collage;
  String? level;
  String? address;
  String? rugsNum;
  String? image;
  String? roleId;

  StudentModel({
   this.studentId,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.collage,
    this.level,
    this.address,
    this.rugsNum,
    this.image,
    this.roleId,
  });

  factory StudentModel.fromRawJson(String str) => StudentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    studentId: json["Student_Id"],
    name: json["Name"],
    email: json["Email"],
    phone: json["Phone"],
    password: json["Password"],
    collage: json["Collage"],
    level: json["Level"],
    address: json["Address"],
    rugsNum: json["Rugs_Num"],
    image: json["Image"],
    roleId: json["Role_Id"],
  );

  Map<String, String> toJson() => {
    "Student_Id": studentId.toString(),
    "Name": name.toString(),
    "Email": email.toString(),
    "Phone": phone.toString(),
    "Password": password.toString(),
    "Collage": collage.toString(),
    "Level": level.toString(),
    "Address": address.toString(),
    "Rugs_Num": rugsNum.toString(),
    "Image":image.toString(),
    "Role_Id": roleId.toString(),
  };
}
