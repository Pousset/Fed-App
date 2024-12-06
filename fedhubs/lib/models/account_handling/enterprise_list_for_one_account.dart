// To parse this JSON data, do
//
//     final enterpriseAccountHandleList = enterpriseAccountHandleListFromJson(jsonString);

import 'dart:convert';

EnterpriseAccountHandleList enterpriseAccountHandleListFromJson(String str) => EnterpriseAccountHandleList.fromJson(json.decode(str));

String enterpriseAccountHandleListToJson(EnterpriseAccountHandleList data) => json.encode(data.toJson());

class EnterpriseAccountHandleList {
  EnterpriseAccountHandleList({
    this.body,
  });

  List<Body>? body;

  factory EnterpriseAccountHandleList.fromJson(Map<String, dynamic> json) => EnterpriseAccountHandleList(
    body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "body": List<dynamic>.from(body!.map((x) => x.toJson())),
  };
}

class Body {
  Body({
    this.idClient,
    this.companyName,
    this.address,
    this.backgroundImage,
  });

  String? idClient;
  String? companyName;
  String? address;
  String? backgroundImage;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    idClient: json["id_client"],
    companyName: json["company_name"],
    address: json["address"],
    backgroundImage: json["background_image"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "company_name": companyName,
    "address": address,
    "background_image": backgroundImage,
  };
}
