import 'dart:convert';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/Booking.dart';
import '../main.dart';


class BookingApiService {
  final String apiUrl = "http://${localhostip.toString()}/Api_Student_m/Booking.php";

  Future<List<BookingModel>> fetchBooking(String book,String id) async {

    final response = await http.get(Uri.parse(apiUrl+"?Vehicle_Id=$id&&Book=$book"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => BookingModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<BookingModel>> fetchBookingId(String Id) async {
    final response = await http.get(Uri.parse(apiUrl+"?id=$Id"));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => BookingModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> addBooking(BookingModel booking) async {
    final response = await http.post(Uri.parse(apiUrl), body: booking.toJson());
    if(response.statusCode==200) {
      return true;
      }
    if(response.statusCode==204){
      return false;
    }
    return false;

  }



  Future<bool> updateBooking(String booking) async {
    final response = await http.put(Uri.parse('$apiUrl?id=${booking}'),
     // body: json.encode(booking.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 204) {
      return false;
    }
    return false ;
  }

  Future<bool> deleteBooking(String bookingId) async {
    final response = await http.delete(Uri.parse(apiUrl+"?Id=$bookingId"));
    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 204) {
      return false;
    }
    return false ;
  }
}
