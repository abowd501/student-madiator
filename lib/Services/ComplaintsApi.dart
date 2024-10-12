import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Complaints.dart';
import '../Model/Notification.dart';
import '../main.dart';


class ComplaintsApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Complaints.php";

  Future<List<ComplaintsModel>> fetchComplaints() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
     // jsonData.sort((a,b)=>b['Complaint_Id'].compareTo(a['Complaint_Id']));
      return jsonData.map((item) => ComplaintsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<ComplaintsModel>> fetchComplaintsId(String id) async {
    final response = await http.get(Uri.parse(apiUrl+"?id=$id"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => ComplaintsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<void> addComplaints(ComplaintsModel complaint,context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      //headers: {'Content-Type': 'application/json'},
      body: complaint.toJson(),
    );
    if(response.statusCode==200){
      var mes= await jsonDecode(response.body);
      print(mes);
     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${mes["message"]}")));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("somethings went  worng")));
    }

  }
  Future<void> updateComplaints(ComplaintsModel complaint) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${complaint.complaintId}'),
      body: complaint.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admin');
    }
  }
  Future<void> deleteComplaints(String complaintId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$complaintId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete admin');
    }
  }
}
