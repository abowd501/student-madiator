import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Student.dart';
import '../main.dart';

class StudentApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Student.php";

  Future<List<StudentModel>> fetchStudent() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => StudentModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<StudentModel>> fetchStudentId(String id) async {
    final response = await http.get(Uri.parse(apiUrl+"?id=$id"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => StudentModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }


   void addStudent(StudentModel student) async {
     var url = "http://$localhostip/Api_Student_m/SignUp.php";
    final response = await http.post(Uri.parse(url), body: student.toJson());
    if (response.statusCode == 200) {
      throw Exception('Failed to add student${response.body}');
      }
  }
  Future<bool> login(StudentModel student,context) async {
    try{
    var url = "http://$localhostip/Api_Student_m/Login.php";
    final response = await http.post(Uri.parse(url), body: student.toJson());
    var dd=jsonDecode(response.body);
    if (response.statusCode == 200) {
      await prefs.setString("Student_Id", "${dd["Student_Id"]}");
      await prefs.setString("Name", "${dd["Name"]}");
      await prefs.setString("Role_Id", "${dd["Role_Id"]}");
      await prefs.setString("Email", "${dd["Email"]}");
      await prefs.setString("Vehicle_Id","${dd["Vehicle_Id"]}");
      return dd['message'];
    }}catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("غير متصل بالانترنت")));

    }
    return false;
  }

  Future<void> updateStudent(StudentModel student) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${student.studentId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admin');
    }
  }




}

