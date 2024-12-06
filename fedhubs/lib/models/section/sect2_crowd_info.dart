// To parse this JSON data, do
//
//     final crowdInfoSect2 = crowdInfoSect2FromJson(jsonString);

import 'dart:convert';

import 'package:fedhubs_pro/services/functions.dart';

CrowdInfoSect2 crowdInfoSect2FromJson(String str) =>
    CrowdInfoSect2.fromJson(json.decode(str));

String crowdInfoSect2ToJson(CrowdInfoSect2 data) => json.encode(data.toJson());

class CrowdInfoSect2 {
  CrowdInfoSect2({
    this.idClient,
    this.redCrowdIndicatorInfo,
    this.orangeCrowdIndicatorInfo,
    this.greenCrowdIndicatorInfo,
    this.crowdInfoPlus,
  });

  String? idClient;
  String? redCrowdIndicatorInfo;
  String? orangeCrowdIndicatorInfo;
  String? greenCrowdIndicatorInfo;
  dynamic crowdInfoPlus;

  factory CrowdInfoSect2.fromJson(Map<String, dynamic> json) => CrowdInfoSect2(
        redCrowdIndicatorInfo: clean(json["red_crowd_indicator_info"]),
        orangeCrowdIndicatorInfo: clean(json["orange_crowd_indicator_info"]),
        greenCrowdIndicatorInfo: clean(json["green_crowd_indicator_info"]),
        crowdInfoPlus: clean(json["crowd_info_plus"]),
      );

  Map<String, dynamic> toJson() => {
        "id_client": idClient,
        "red_crowd_indicator_info": redCrowdIndicatorInfo,
        "orange_crowd_indicator_info": orangeCrowdIndicatorInfo,
        "green_crowd_indicator_info": greenCrowdIndicatorInfo,
        "crowd_info_plus": crowdInfoPlus,
      };
}
