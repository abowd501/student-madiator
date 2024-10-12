import 'package:meta/meta.dart';
import 'dart:convert';

class AdsModel {
  String? adsId;
  String? adsImage;
  String? link;




  AdsModel({
    this.adsId,
    required this.adsImage,
    required this.link,
  });

  factory AdsModel.fromRawJson(String str) => AdsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
    adsId: json["Ads_Id"],
    adsImage: json["Ads_Image"],
    link: json["Link"],
  );

  Map<String, dynamic> toJson() => {
    "Ads_Id": adsId,
    "Ads_Image": adsImage,
    "Link": link,
  };
}
