// To parse this JSON data, do
//
//     final timetableSect3 = timetableSect3FromJson(jsonString);

import 'dart:convert';

TimetableSect3 timetableSect3FromJson(String str) => TimetableSect3.fromJson(json.decode(str));

String timetableSect3ToJson(TimetableSect3 data) => json.encode(data.toJson());

class TimetableSect3 {
  TimetableSect3({
    this.idClient,
    this.mondayHours,
    this.tuesdayHours,
    this.wednesdayHours,
    this.thursdayHours,
    this.fridayHours,
    this.saturdayHours,
    this.sundayHours,
  });

  String? idClient;
  String? mondayHours;
  String? tuesdayHours;
  String? wednesdayHours;
  String? thursdayHours;
  String? fridayHours;
  String? saturdayHours;
  String? sundayHours;

  factory TimetableSect3.fromJson(Map<String, dynamic> json) => TimetableSect3(
    mondayHours: json["monday_hours"],
    tuesdayHours: json["tuesday_hours"],
    wednesdayHours: json["wednesday_hours"],
    thursdayHours: json["thursday_hours"],
    fridayHours: json["friday_hours"],
    saturdayHours: json["saturday_hours"],
    sundayHours: json["sunday_hours"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "monday_hours": mondayHours,
    "tuesday_hours": tuesdayHours,
    "wednesday_hours": wednesdayHours,
    "thursday_hours": thursdayHours,
    "friday_hours": fridayHours,
    "saturday_hours": saturdayHours,
    "sunday_hours": sundayHours,
  };
}
