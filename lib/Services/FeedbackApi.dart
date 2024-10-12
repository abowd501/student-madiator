import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Feedback.dart';
import '../main.dart';

class FeedbackApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Feedback.php";

  Future<List<FeedbackModel>> fetchFeedback() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
       //jsonData.sort((a,b)=>b['Feedback_Id'].compareTo(a['Feedback_Id']));
      return jsonData.map((item) => FeedbackModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future addFeedback(FeedbackModel feedback) async {
    try{
    final response = await http.post(
      Uri.parse(apiUrl),
      body: feedback.toJson(),
    );
    var mes=json.decode(response.body);
    if (response.statusCode == 200) {
      return mes["message"];
    }}catch(e){
      return" لايوجد انترنت";
    }

  }

  Future<void> updateFeedback(FeedbackModel feedback) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${feedback.feedbackId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(feedback.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admin');
    }
  }

  Future<void> deleteFeedback(String feedbackId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$feedbackId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete admin');
    }
  }
}
