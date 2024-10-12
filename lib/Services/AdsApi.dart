import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Ads.dart';
import '../main.dart';

class AdsApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Ads.php";

  Future<List<AdsModel>> fetchAds() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => AdsModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }


  }

  Future<void> addAds(AdsModel ads,context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: ads.toJson(),
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

  Future<void> updateAdmin(AdsModel ads) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${ads.adsId}'),

      headers: {'Content-Type': 'application/json'},
      body: json.encode(ads.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admin');
    }
  }

  Future<void> deleteAdmin(String adsId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$adsId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete admin');
    }
  }
}
