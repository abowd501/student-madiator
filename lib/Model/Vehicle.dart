import 'package:meta/meta.dart';
import 'dart:convert';

class VehicleModel {
  String vehicleId;
  String type;
  String stringPoint;
  String distnitionPoint;
  String arrivalTime;
  String returnTime;
  String numSeats;
  String stute;
  String discription;
  String studentId;
  String? images;

  VehicleModel({
    required this.vehicleId,
    required this.type,
    required this.stringPoint,
    required this.distnitionPoint,
    required this.arrivalTime,
    required this.returnTime,
    required this.numSeats,
    required this.stute,
    required this.discription,
    required this.studentId,
    required this.images
  });

  factory VehicleModel.fromRawJson(String str) => VehicleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
    vehicleId: json["Vehicle_Id"],
    type: json["Type"],
    stringPoint: json["String_Point"],
    distnitionPoint: json["Distnition_Point"],
    arrivalTime: json["Arrival_Time"],
    returnTime: json["Return_Time"],
    numSeats: json["Num_Seats"],
    stute: json["Stute"],
    discription: json["Discription"],
    studentId: json["Student_Id"],
    images: json["Images"],
  );

  Map<String, String> toJson() => {
    "Vehicle_Id": vehicleId.toString(),
    "Type": type.toString(),
    "String_Point": stringPoint.toString(),
    "Distnition_Point": distnitionPoint.toString(),
    "Arrival_Time": arrivalTime.toString(),
    "Return_Time": returnTime.toString(),
    "Num_Seats": numSeats.toString(),
    "Stute": stute.toString(),
    "Discription": discription.toString(),
    "Student_Id": studentId.toString(),
    "Images": images.toString()
  };
}

class ImageModel {
  String imageId;
  String image;
  //String vehicleId;

  ImageModel({
    required this.imageId,
    required this.image,
   // required this.vehicleId,
  });

  factory ImageModel.fromRawJson(String str) => ImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, String> json) => ImageModel(
    imageId: json[0].toString(),
    image: json[0].toString(),
   // vehicleId: json["Vehicle_Id"].toString(),
  );

  Map<String, String> toJson() => {
    "Image_Id": imageId,
    "Image": image,
  //  "Vehicle_Id": vehicleId,
  };
}
