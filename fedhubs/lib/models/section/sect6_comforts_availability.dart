// To parse this JSON data, do
//
//     final comfortAvailabilitySect6 = comfortAvailabilitySect6FromJson(jsonString);

import 'dart:convert';

ComfortAvailabilitySect6 comfortAvailabilitySect6FromJson(String str) => ComfortAvailabilitySect6.fromJson(json.decode(str));

String comfortAvailabilitySect6ToJson(ComfortAvailabilitySect6 data) => json.encode(data.toJson());

class ComfortAvailabilitySect6 {
  ComfortAvailabilitySect6({
    this.idClient,
    this.toiletEnable,
    this.tvEnable,
    this.wifiEnable,
    this.handicapEnable,
    this.musicEnable,
  });

  String? idClient;
  bool? toiletEnable;
  bool? tvEnable;
  bool? wifiEnable;
  bool? handicapEnable;
  bool? musicEnable;

  factory ComfortAvailabilitySect6.fromJson(Map<String, dynamic> json) => ComfortAvailabilitySect6(
    toiletEnable: int.parse(json["toilet_enable"]) == 0 ? false : true,
    tvEnable: int.parse(json["tv_enable"]) == 0 ? false : true,
    wifiEnable: int.parse(json["wifi_enable"]) == 0 ? false : true,
    handicapEnable: int.parse(json["handicap_enable"]) == 0 ? false : true,
    musicEnable: int.parse(json["music_enable"]) == 0 ? false : true,
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "toilet_enable": toiletEnable == true ? 1 : 0,
    "tv_enable": tvEnable== true ? 1 : 0,
    "wifi_enable": wifiEnable== true ? 1 : 0,
    "handicap_enable": handicapEnable== true ? 1 : 0,
    "music_enable": musicEnable== true ? 1 : 0,
  };
}
