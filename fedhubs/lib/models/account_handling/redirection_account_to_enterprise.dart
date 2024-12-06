// To parse this JSON data, do
//
//     final redirectionAccountToEnterprise = redirectionAccountToEnterpriseFromJson(jsonString);

import 'dart:convert';

RedirectionAccountToEnterprise redirectionAccountToEnterpriseFromJson(
        String str) =>
    RedirectionAccountToEnterprise.fromJson(json.decode(str));

String redirectionAccountToEnterpriseToJson(
        RedirectionAccountToEnterprise data) =>
    json.encode(data.toJson());

class RedirectionAccountToEnterprise {
  RedirectionAccountToEnterprise({
    this.enterpriseBody,
    this.idAccount,
    this.countCompany,
  });

  List<Enterprise>? enterpriseBody;
  String? idAccount;
  int? countCompany;

  factory RedirectionAccountToEnterprise.fromJson(Map<String, dynamic> json) =>
      RedirectionAccountToEnterprise(
        enterpriseBody: List<Enterprise>.from(
            json["entreprise"].map((x) => Enterprise.fromJson(x))),
        idAccount: json["id_account"],
        countCompany: json["count_company"],
      );

  Map<String, dynamic> toJson() => {
        "entreprise":
            List<dynamic>.from(enterpriseBody!.map((x) => x.toJson())),
        "id_account": idAccount,
        "count_company": countCompany,
      };
}

class Enterprise {
  Enterprise({
    required this.id,
    required this.companyName,
    required this.typeActivity,
    required this.description,
    required this.logo,
    required this.phoneNumber,
    required this.email,
    required this.websiteLink,
    required this.address,
    required this.longitude,
    required this.latitude,
    required this.price,
    required this.commentsNumbers,
    required this.rating,
  });

  int id;
  String companyName;
  String typeActivity;
  String description;
  String logo;
  String phoneNumber;
  String email;
  String websiteLink;
  String address;
  double longitude;
  double latitude;
  int price;
  int commentsNumbers;
  double? rating;

  factory Enterprise.fromJson(Map<String, dynamic> json) => Enterprise(
        id: json["id"],
        companyName: json["company_name"] ?? '',
        typeActivity: json["type_activity"] ?? '',
        description: json["description"] ?? '',
        logo: json["logo"] ?? '',
        phoneNumber: json["phone_number"] ?? '',
        email: json["email"] ?? '',
        websiteLink: json["website_link"] ?? '',
        address: json["address"] ?? '',
        longitude: json["longitude"] ?? 0,
        latitude: json["latitude"] ?? 0,
        price: json["price_range"] ?? 0,
        commentsNumbers: json["comment_numbers"] ?? 0,
        rating: json["rating"] is int
            ? (json["rating"]).toDouble()
            : json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "type_activity": typeActivity,
        "description": description,
        "logo": logo,
        "phone_number": phoneNumber,
        "email": email,
        "website_link": websiteLink,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "price": price,
        "commentsNumbers": commentsNumbers,
        "rating": rating,
      };
}
