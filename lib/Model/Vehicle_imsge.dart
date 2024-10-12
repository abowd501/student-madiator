import 'package:meta/meta.dart';
import 'dart:convert';

class Vehicle_ImsgeModel {
  String imageId;
  String image;
  String vehicleId;

  Vehicle_ImsgeModel({
    required this.imageId,
    required this.image,
    required this.vehicleId,
  });

  factory Vehicle_ImsgeModel.fromRawJson(String str) => Vehicle_ImsgeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vehicle_ImsgeModel.fromJson(Map<String, dynamic> json) => Vehicle_ImsgeModel(
    imageId: json["Image_Id"],
    image: json["Image"],
    vehicleId: json["Vehicle_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Image_Id": imageId,
    "Image": image,
    "Vehicle_Id": vehicleId,
  };
}
