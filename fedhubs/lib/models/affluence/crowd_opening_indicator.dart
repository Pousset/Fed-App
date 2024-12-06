// To parse this JSON data, do
//
//     final crowdOpenningIndicator = crowdOpenningIndicatorFromJson(jsonString);

import 'dart:convert';

CrowdOpeningIndicator crowdOpeningIndicatorFromJson(String str) => CrowdOpeningIndicator.fromJson(json.decode(str));

String crowdOpeningIndicatorToJson(CrowdOpeningIndicator data) => json.encode(data.toJson());

class CrowdOpeningIndicator {

  CrowdOpeningIndicator({
    this.idClient,
    this.opening,
    this.crowdIndicator,
});

  String? idClient;
  bool? opening;
  int? crowdIndicator;


  factory CrowdOpeningIndicator.fromJson(Map<String, dynamic> json) => CrowdOpeningIndicator(
    idClient: json["id_client"],
    opening: int.parse(json["opening"]) == 0 ? false : true,
    crowdIndicator: int.parse(json["crowd_indicator"]),

  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "opening": opening== true ? 1 : 0,
    "crowd_indicator": crowdIndicator,
  };
}
