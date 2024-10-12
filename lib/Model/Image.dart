import 'package:meta/meta.dart';
import 'dart:convert';

class ImageModel {
  String id;
  String image;
  String apatrmentId;

  ImageModel({
    required this.id,
    required this.image,
    required this.apatrmentId,
  });

  factory ImageModel.fromRawJson(String str) => ImageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["Id"],
    image: json["Image"],
    apatrmentId: json["Apatrment_Id"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Image": image,
    "Apatrment_Id": apatrmentId,
  };
}
