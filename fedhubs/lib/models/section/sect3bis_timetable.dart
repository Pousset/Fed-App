// To parse this JSON data, do
//
//     final timetableSect3Bis = timetableSect3BisFromJson(jsonString);

import 'dart:convert';

TimetableSect3Bis timetableSect3BisFromJson(String str) => TimetableSect3Bis.fromJson(json.decode(str));

String timetableSect3BisToJson(TimetableSect3Bis data) => json.encode(data.toJson());

class TimetableSect3Bis {
  TimetableSect3Bis({
    this.idClient,
    this.mondayStart1,
    this.mondayEnd1,
    this.mondayStart2,
    this.mondayEnd2,
    this.tuesdayStart1,
    this.tuesdayEnd1,
    this.tuesdayStart2,
    this.tuesdayEnd2,
    this.wednesdayStart1,
    this.wednesdayEnd1,
    this.wednesdayStart2,
    this.wednesdayEnd2,
    this.thursdayStart1,
    this.thursdayEnd1,
    this.thursdayStart2,
    this.thursdayEnd2,
    this.fridayStart1,
    this.fridayEnd1,
    this.fridayStart2,
    this.fridayEnd2,
    this.saturdayStart1,
    this.saturdayEnd1,
    this.saturdayStart2,
    this.saturdayEnd2,
    this.sundayStart1,
    this.sundayEnd1,
    this.sundayStart2,
    this.sundayEnd2,
  });

  String? idClient;
  String? mondayStart1;
  String? mondayEnd1;
  String? mondayStart2;
  String? mondayEnd2;
  String? tuesdayStart1;
  String? tuesdayEnd1;
  String? tuesdayStart2;
  String? tuesdayEnd2;
  String? wednesdayStart1;
  String? wednesdayEnd1;
  String? wednesdayStart2;
  String? wednesdayEnd2;
  String? thursdayStart1;
  String? thursdayEnd1;
  String? thursdayStart2;
  String? thursdayEnd2;
  String? fridayStart1;
  String? fridayEnd1;
  String? fridayStart2;
  String? fridayEnd2;
  String? saturdayStart1;
  String? saturdayEnd1;
  String? saturdayStart2;
  String? saturdayEnd2;
  String? sundayStart1;
  String? sundayEnd1;
  String? sundayStart2;
  String? sundayEnd2;

  factory TimetableSect3Bis.fromJson(Map<String, dynamic> json) => TimetableSect3Bis(
    idClient: json["id_client"],
    mondayStart1: json["monday_start1"],
    mondayEnd1: json["monday_end1"],
    mondayStart2: json["monday_start2"],
    mondayEnd2: json["monday_end2"],
    tuesdayStart1: json["tuesday_start1"],
    tuesdayEnd1: json["tuesday_end1"],
    tuesdayStart2: json["tuesday_start2"],
    tuesdayEnd2: json["tuesday_end2"],
    wednesdayStart1: json["wednesday_start1"],
    wednesdayEnd1: json["wednesday_end1"],
    wednesdayStart2: json["wednesday_start2"],
    wednesdayEnd2: json["wednesday_end2"],
    thursdayStart1: json["thursday_start1"],
    thursdayEnd1: json["thursday_end1"],
    thursdayStart2: json["thursday_start2"],
    thursdayEnd2: json["thursday_end2"],
    fridayStart1: json["friday_start1"],
    fridayEnd1: json["friday_end1"],
    fridayStart2: json["friday_start2"],
    fridayEnd2: json["friday_end2"],
    saturdayStart1: json["saturday_start1"],
    saturdayEnd1: json["saturday_end1"],
    saturdayStart2: json["saturday_start2"],
    saturdayEnd2: json["saturday_end2"],
    sundayStart1: json["sunday_start1"],
    sundayEnd1: json["sunday_end1"],
    sundayStart2: json["sunday_start2"],
    sundayEnd2: json["sunday_end2"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "monday_start1": mondayStart1,
    "monday_end1": mondayEnd1,
    "monday_start2": mondayStart2,
    "monday_end2": mondayEnd2,
    "tuesday_start1": tuesdayStart1,
    "tuesday_end1": tuesdayEnd1,
    "tuesday_start2": tuesdayStart2,
    "tuesday_end2": tuesdayEnd2,
    "wednesday_start1": wednesdayStart1,
    "wednesday_end1": wednesdayEnd1,
    "wednesday_start2": wednesdayStart2,
    "wednesday_end2": wednesdayEnd2,
    "thursday_start1": thursdayStart1,
    "thursday_end1": thursdayEnd1,
    "thursday_start2": thursdayStart2,
    "thursday_end2": thursdayEnd2,
    "friday_start1": fridayStart1,
    "friday_end1": fridayEnd1,
    "friday_start2": fridayStart2,
    "friday_end2": fridayEnd2,
    "saturday_start1": saturdayStart1,
    "saturday_end1": saturdayEnd1,
    "saturday_start2": saturdayStart2,
    "saturday_end2": saturdayEnd2,
    "sunday_start1": sundayStart1,
    "sunday_end1": sundayEnd1,
    "sunday_start2": sundayStart2,
    "sunday_end2": sundayEnd2,
  };
}
