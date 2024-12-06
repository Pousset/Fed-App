// To parse this JSON data, do
//
//     final deleteCatalog = deleteCatalogFromJson(jsonString);

import 'dart:convert';

DeleteCatalog deleteCatalogFromJson(String str) => DeleteCatalog.fromJson(json.decode(str));

String deleteCatalogToJson(DeleteCatalog data) => json.encode(data.toJson());

class DeleteCatalog {
  DeleteCatalog({
    this.idClient,
    this.idCatalog,
  });

  String? idClient;
  String? idCatalog;

  factory DeleteCatalog.fromJson(Map<String, dynamic> json) => DeleteCatalog(
    idClient: json["id_client"],
    idCatalog: json["id_catalog"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "id_catalog": idCatalog,
  };
}
