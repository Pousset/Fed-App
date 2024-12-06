// To parse this JSON data, do
//
//     final timetableSect3 = timetableSect3FromJson(jsonString);

import 'dart:convert';

EntrepriseTimetableModel entrepriseTimetableModelFromJson(String str) =>
    EntrepriseTimetableModel.fromJson(json.decode(str));

String entrepriseTimetableModelToJson(EntrepriseTimetableModel data) =>
    json.encode(data.toJson());

class EntrepriseTimetableModel {
  EntrepriseTimetableModel({
    required this.mondayHours,
    required this.tuesdayHours,
    required this.wednesdayHours,
    required this.thursdayHours,
    required this.fridayHours,
    required this.saturdayHours,
    required this.sundayHours,
  });

  final OpenHours mondayHours;
  final OpenHours tuesdayHours;
  final OpenHours wednesdayHours;
  final OpenHours thursdayHours;
  final OpenHours fridayHours;
  final OpenHours saturdayHours;
  final OpenHours sundayHours;

  factory EntrepriseTimetableModel.fromJson(Map<String, dynamic> json) =>
      EntrepriseTimetableModel(
        mondayHours: OpenHours.fromJson(json["monday"] ?? {}),
        tuesdayHours: OpenHours.fromJson(json["tuesday"] ?? {}),
        wednesdayHours: OpenHours.fromJson(json["wednesday"] ?? {}),
        thursdayHours: OpenHours.fromJson(json["thursday"] ?? {}),
        fridayHours: OpenHours.fromJson(json["friday"] ?? {}),
        saturdayHours: OpenHours.fromJson(json["saturday"] ?? {}),
        sundayHours: OpenHours.fromJson(json["sunday"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "monday": mondayHours.toJson(),
        "tuesday": tuesdayHours.toJson(),
        "wednesday": wednesdayHours.toJson(),
        "thursday": thursdayHours.toJson(),
        "friday": fridayHours.toJson(),
        "saturday": saturdayHours.toJson(),
        "sunday": sundayHours.toJson(),
      };

  factory EntrepriseTimetableModel.empty() => EntrepriseTimetableModel(
        mondayHours: OpenHours.fromJson({}),
        tuesdayHours: OpenHours.fromJson({}),
        wednesdayHours: OpenHours.fromJson({}),
        thursdayHours: OpenHours.fromJson({}),
        fridayHours: OpenHours.fromJson({}),
        saturdayHours: OpenHours.fromJson({}),
        sundayHours: OpenHours.fromJson({}),
      );

  @override
  String toString() {
    return toJson().toString();
  }
}

class OpenHours {
  OpenHours({
    this.start = '',
    this.end = '',
  }) {
    isClosed = start == end;
  }

  late bool isClosed;
  String start;
  String end;

  factory OpenHours.fromJson(Map<String, dynamic> json) => OpenHours(
        start: json["start"] ?? '',
        end: json["end"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "start": isClosed ? '00:00:00' : start,
        "end": isClosed ? '00:00:00' : end,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
