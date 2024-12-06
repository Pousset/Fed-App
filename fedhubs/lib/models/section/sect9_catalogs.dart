// To parse this JSON data, do
//
//     final catalogList = catalogListFromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

CatalogListModel catalogListFromJson(String str) =>
    CatalogListModel.fromJson(json.decode(str));

String catalogListToJson(CatalogListModel data) => json.encode(data.toJson());

class CatalogListModel {
  CatalogListModel({
    this.catalog,
  });

  List<Catalog>? catalog;

  factory CatalogListModel.fromJson(Map<String, dynamic> json) =>
      CatalogListModel(
        catalog:
            List<Catalog>.from(json["body"].map((x) => Catalog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(catalog!.map((x) => x.toJson())),
      };
}

class Catalog {
  Catalog({
    this.idClient,
    this.idCatalog,
    this.catalogName,
    this.catalogLink,
  });

  String? idClient;
  String? idCatalog;
  String? catalogName;
  String? catalogLink;

  factory Catalog.fromJson(Map<String, dynamic> json) => Catalog(
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
