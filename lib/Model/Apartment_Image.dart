import 'package:meta/meta.dart';
import 'dart:convert';

class ApartmentImageModel {
  String imageId;
  String image;
  String apartmentId;

  ApartmentImageModel({
    required this.imageId,
    required this.image,
    required this.apartmentId,

  });

  factory ApartmentImageModel.fromRawJson(String str) => ApartmentImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApartmentImageModel.fromJson(Map<String, dynamic> json) => ApartmentImageModel(
    imageId: json["image_Id"],
    image: json["image"],
    apartmentId: json["apartment_Id"],
  );

  Map<String, dynamic> toJson() => {
    "image_Id": imageId,
    "image": image,
    "apartment_Id": apartmentId,
  };
}




