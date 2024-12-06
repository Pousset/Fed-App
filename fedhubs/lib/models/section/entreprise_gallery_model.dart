import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

EntrepriseGalleryModel entrepriseGalleryListFromJson(String str) =>
    EntrepriseGalleryModel.fromJson(json.decode(str));

String entrepriseGalleryListToJson(EntrepriseGalleryModel data) =>
    json.encode(data.toJson());

class EntrepriseGalleryModel {
  EntrepriseGalleryModel({
    required this.gallery,
    required this.bannerPicture,
    required this.profilPicture,
  });

  GalleryPicture? bannerPicture;
  GalleryPicture? profilPicture;
  List<GalleryPicture> gallery;

  factory EntrepriseGalleryModel.fromJson(List<Map<String, dynamic>> json) {
    final allPictures =
        List<GalleryPicture>.from(json.map((x) => GalleryPicture.fromJson(x)));

    late final GalleryPicture? bannerPicture, profilPicture;
    try {
      bannerPicture = allPictures.firstWhere((element) => element.type == 0);
    } catch (e) {
      bannerPicture = null;
    }
    try {
      profilPicture = allPictures.firstWhere((element) => element.type == 1);
    } catch (e) {
      profilPicture = null;
    }

    return EntrepriseGalleryModel(
      gallery: allPictures,
      bannerPicture: bannerPicture,
      profilPicture: profilPicture,
    );
  }

  Map<String, dynamic> toJson() => {
        "body": List<dynamic>.from(gallery
            .expand((element) =>
                [bannerPicture, profilPicture].where((e) => e != null))
            .map((x) => x!.toJson())),
      };
}

class GalleryPicture {
  GalleryPicture({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.type,
  });

  String id;
  String name;
  String description;
  String url;
  int type;

  factory GalleryPicture.fromJson(Map<String, dynamic> json) => GalleryPicture(
        id: '${json["id"]}',
        name: clean(json["img_name"]) ?? '',
        description: clean(json["img_description"]) ?? '',
        url: clean(json["img_url"]) ?? '',
        type: json["type_id"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img_name": name,
        "img_description": description,
        "img_url": url,
        "type_id": type,
      };

  void setGalleryPicture(GalleryPicture v) {
    name = v.name;
    description = v.description;
    url = v.url;
    type = v.type;
  }

  factory GalleryPicture.empty() => GalleryPicture(
        id: '',
        name: '',
        description: '',
        url: '',
        type: 0,
      );
}
