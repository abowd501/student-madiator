import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Model/Apartment.dart';
import '../main.dart';

class ApartmentApiService {
  final String apiUrl = "http://$localhostip/Api_Student_m/Apartment.php";

  get context => null;
  var con=0;
  Future<List<ApartmentModel>> fetchApartment() async {

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      // con=jsonData.length;
      return jsonData.map((item) => ApartmentModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }


  }

  Future<void> addApartment(ApartmentModel apartment,context) async {
    final response = await http.post(
      Uri.parse(apiUrl),
     // headers: {'Content-Type': 'application/json'},
      body: apartment.toJson(),
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

  Future<void> updateApartment(ApartmentModel apartment) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${apartment.apartmentId}'),
      //headers: {'Content-Type': 'application/json'},
      body: apartment.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update Apartment');
    }
  }

  Future<void> deleteApartment(String apartmentId) async {
    final response = await http.delete(Uri.parse('$apiUrl/$apartmentId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete Apartment');
    }
  }


}
