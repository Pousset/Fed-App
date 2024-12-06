// To parse this JSON data, do
//
//     final reservationList = reservationListFromJson(jsonString);

import 'dart:convert';

ReservationList reservationListFromJson(String str) => ReservationList.fromJson(json.decode(str));

String reservationListToJson(ReservationList data) => json.encode(data.toJson());

class ReservationList {
  ReservationList({
    required this.body,
  });

  List<Body> body;

  factory ReservationList.fromJson(Map<String, dynamic> json) => ReservationList(
    body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class Body {
  Body({
    required this.idClient,
    required this.idConsumer,
    required this.personNumber,
    required this.date,
    required this.comments,
    required this.reason,
  });

  String idClient;
  String idConsumer;
  String personNumber;
  DateTime date;
  String comments;
  String reason;

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    idClient: json["id_client"],
    idConsumer: json["id_consumer"],
    personNumber: json["person_number"],
    date: DateTime.parse(json["date"]),
    comments: json["comments"],
    reason: json["reason"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "id_consumer": idConsumer,
    "person_number": personNumber,
    "date": date.toIso8601String(),
    "comments": comments,
    "reason": reason,
  };
}
