// To parse this JSON data, do
//
//     final catalogList = catalogListFromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

EntrepriseMenuLinkListModel entrepriseMenuLinkListFromJson(String str) =>
    EntrepriseMenuLinkListModel.fromJson(json.decode(str));

String entrepriseMenuLinkListToJson(EntrepriseMenuLinkListModel data) => json.encode(data.toJson());

class EntrepriseMenuLinkListModel {
  EntrepriseMenuLinkListModel({
    required this.menulist,
  });

  List<MenuLink> menulist;

  factory  EntrepriseMenuLinkListModel.fromJson(Map<String, dynamic> json) =>
       EntrepriseMenuLinkListModel(
         menulist:
            List< MenuLink>.from(json["body"].map((x) =>  MenuLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(menulist.map((x) => x.toJson())),
      };
}

class MenuLink {
  MenuLink({
    required this.idMenu,
    required this.name,
    required this.link,
  });

  String idMenu;
  String name;
  String link;

  factory MenuLink.fromJson(Map<String, dynamic> json) => MenuLink(
        idMenu: json["id_catalog"] ?? '',
        name: clean(json["catalog_name"]) ?? '',
        link: clean(json["catalog_link"]) ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id_catalog": idMenu,
        "catalog_name": name,
        "catalog_link": link,
      };

  void setMenuLink(MenuLink v){
    name = v.name;
    link = v.link;

  }

  factory MenuLink.empty() => MenuLink(idMenu: '', name: '', link: '');
}