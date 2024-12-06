// To parse this JSON data, do
//
//     final generalInfoSect4 = generalInfoSect4FromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

GeneralInfoSect4 generalInfoSect4FromJson(String str) =>
    GeneralInfoSect4.fromJson(json.decode(str));

String generalInfoSect4ToJson(GeneralInfoSect4 data) =>
    json.encode(data.toJson());

class GeneralInfoSect4 {
  GeneralInfoSect4({
    this.idClient,
    this.phoneNumber,
    this.email,
    this.websiteLink,
    this.address,
  });

  String? idClient;
  String? phoneNumber;
  String? email;
  String? websiteLink;
  String? address;

  factory GeneralInfoSect4.fromJson(Map<String, dynamic> json) =>
      GeneralInfoSect4(
        phoneNumber: clean(json["phone_number"]),
        email: clean(json["email"]),
        websiteLink: clean(json["website_link"]),
        address: clean(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "phone_number": phoneNumber,
        "email": email,
        "website_link": websiteLink,
        "address": address,
      };
}
