import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Notification.dart';
import '../main.dart';


class NotificationApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Notification.php";

  Future<List<NotificationModel>> fetchNotification() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => NotificationModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
  Future<List<NotificationModel>> fetchNotificationId(String id) async {
    final response = await http.get(Uri.parse(apiUrl+"?id=$id"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => NotificationModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addNotification(NotificationModel note,context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      //headers: {'Content-Type': 'application/json'},
      body: note.toJson(),
    );
    if(response.statusCode==200){
      var mes=jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${mes["message"]}")));
    }else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("somethings went  worng")));
    }
    if (response.statusCode != 201) {
      throw Exception('Failed to add admin');
    }
  }

  Future<void> updateNotification(NotificationModel note) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${note.notificationId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admin');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$notificationId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete admin');
    }
  }
}
