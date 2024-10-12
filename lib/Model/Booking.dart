import 'package:meta/meta.dart';
import 'dart:convert';

class BookingModel {
  String? bookingId;
  String? booking;
  String? bookTime;
  String? studentId;
  String? vehicleId;

  BookingModel({
    this.bookingId,
    this.booking,
    this.bookTime,
    this.studentId,
    this.vehicleId,
  });

  factory BookingModel.fromRawJson(String str) => BookingModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    bookingId: json["Booking_Id"],
    booking: json["Booking"],
    bookTime: json["Book_Time"],
    studentId: json["Student_Id"],
    vehicleId: json["Vehicle_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Booking_Id": bookingId,
    "Booking": booking,
    "Book_Time": bookTime,
    "Student_Id": studentId,
    "Vehicle_Id": vehicleId,
  };
}
