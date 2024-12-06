// To parse this JSON data, do
//
//     final singleCatalog = singleCatalogFromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

SingleCatalog singleCatalogFromJson(String str) =>
    SingleCatalog.fromJson(json.decode(str));

String singleCatalogToJson(SingleCatalog data) => json.encode(data.toJson());

class SingleCatalog {
  SingleCatalog({
    this.idClient,
    this.idCatalog,
    this.catalogName,
    this.catalogLink,
  });

  String? idClient;
  String? idCatalog;
  String? catalogName;
  String? catalogLink;

  factory SingleCatalog.fromJson(Map<String, dynamic> json) => SingleCatalog(
        idClient: json["id_client"],
        idCatalog: json["id_catalog"],
        catalogName: clean(json["catalog_name"]),
        catalogLink: clean(json["catalog_link"]),
      );

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "id_catalog": idCatalog,
        "catalog_name": catalogName,
        "catalog_link": catalogLink,
      };
}
