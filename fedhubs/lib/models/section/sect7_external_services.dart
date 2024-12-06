// To parse this JSON data, do
//
//     final externalServicesSect7 = externalServicesSect7FromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

ExternalServicesSect7 externalServicesSect7FromJson(String str) =>
    ExternalServicesSect7.fromJson(json.decode(str));

String externalServicesSect7ToJson(ExternalServicesSect7 data) =>
    json.encode(data.toJson());

class ExternalServicesSect7 {
  ExternalServicesSect7({
    this.idClient,
    this.buyInPlaceEnable,
    this.takeAwayEnable,
    this.deliverEnable,
    this.ubereatsUrlLink,
    this.delivrooUrlLink,
    this.justeatUrlLink,
    this.ownDeliverEnable,
  });

  String? idClient;
  bool? buyInPlaceEnable;
  bool? takeAwayEnable;
  bool? deliverEnable;
  String? reservationLink;
  String? ubereatsUrlLink;
  String? delivrooUrlLink;
  String? justeatUrlLink;
  bool? ownDeliverEnable;

  factory ExternalServicesSect7.fromJson(Map<String, dynamic> json) =>
      ExternalServicesSect7(
        buyInPlaceEnable:
            int.parse(json["buy_in_place_enable"]) == 0 ? false : true,
        takeAwayEnable: int.parse(json["take_away_enable"]) == 0 ? false : true,
        deliverEnable: int.parse(json["deliver_enable"]) == 0 ? false : true,
        ubereatsUrlLink: clean(json["ubereats_url_link"]),
        delivrooUrlLink: clean(json["delivroo_url_link"]),
        justeatUrlLink: clean(json["justeat_url_link"]),
        ownDeliverEnable:
            int.parse(json["own_deliver_enable"]) == 0 ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "buy_in_place_enable": buyInPlaceEnable == true ? 1 : 0,
        "take_away_enable": takeAwayEnable == true ? 1 : 0,
        "deliver_enable": deliverEnable == true ? 1 : 0,
        "ubereats_url_link": ubereatsUrlLink,
        "delivroo_url_link": delivrooUrlLink,
        "justeat_url_link": justeatUrlLink,
        "own_deliver_enable": ownDeliverEnable == true ? 1 : 0,
      };
}
