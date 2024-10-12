import 'package:meta/meta.dart';
import 'dart:convert';

class ApartmentModel {
  String? apartmentId;
  String? location;
  String? price;
  String? numRoom;
  String? numBith;
  String? floor;
  String? discription;
  String? stute;
  String? addTime;
  String? images;

  ApartmentModel({
    this.apartmentId,
    this.location,
    this.price,
    this.numRoom,
    this.numBith,
    this.floor,
    this.discription,
    this.stute,
    this.addTime,
    this.images,
  });

  factory ApartmentModel.fromRawJson(String str) => ApartmentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApartmentModel.fromJson(Map<String, dynamic> json) => ApartmentModel(
    apartmentId: json["Apartment_Id"],
    location: json["Location"],
    price: json["Price"],
    numRoom: json["Num_Room"],
    numBith: json["Num_Bith"],
    floor: json["Floor"],
    discription: json["Discription"],
    stute: json["Stute"],
    addTime: json["Add_Time"],
    images: json["Images"],
  );

  Map<String, dynamic> toJson() => {
    "Apartment_Id": apartmentId,
    "Location": location,
    "Price": price,
    "Num_Room": numRoom,
    "Num_Bith": numBith,
    "Floor": floor,
    "Discription": discription,
    "Stute": stute,
    "Add_Time": addTime,
    "Images": images,
  };
}
