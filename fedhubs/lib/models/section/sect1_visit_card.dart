// To parse this JSON data, do
//
//     final visitCardSect1 = visitCardSect1FromJson(jsonString);

import 'dart:convert';
import 'package:fedhubs_pro/services/functions.dart';

VisitCardSect1 visitCardSect1FromJson(String str) =>
    VisitCardSect1.fromJson(json.decode(str));

String visitCardSect1ToJson(VisitCardSect1 data) => json.encode(data.toJson());

class VisitCardSect1 {
  VisitCardSect1({
    this.id,
    this.logo,
    this.companyName,
    this.typeActivity,
    this.description,
    this.address,
    this.commentsNumbers,
    this.rating,
    this.price,
  });

  int? id;
  String? logo;
  String? companyName;
  String? typeActivity;
  String? description;
  String? address;
  int? commentsNumbers;
  double? rating;
  int? price;

  factory VisitCardSect1.fromJson(Map<String, dynamic> json) {
    return VisitCardSect1(
      logo: json["logo"],
      companyName: clean(json["company_name"]),
      typeActivity: clean(json["type_activity"]),
      description: clean(json["description"]),
      address: clean(json["address"]),
      rating:
          json["rating"] is int ? (json["rating"]).toDouble() : json["rating"],
      price: json["price_range"],
      commentsNumbers: json["comment_numbers"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_client": id,
        "company_name": companyName,
        "type_activity": typeActivity,
        "description": description,
      };
}
