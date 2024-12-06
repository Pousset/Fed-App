// To parse this JSON data, do
//
//     final eventDisplayOnCard = eventDisplayOnCardFromJson(jsonString);

import 'dart:convert';

EventDisplayOnCard eventDisplayOnCardFromJson(String str) => EventDisplayOnCard.fromJson(json.decode(str));

String eventDisplayOnCardToJson(EventDisplayOnCard data) => json.encode(data.toJson());

class EventDisplayOnCard {
  EventDisplayOnCard({
    this.idClient,
    this.idEvent,
    this.startDateTimeEvent,
  });

  String? idClient;
  String? idEvent;
  DateTime? startDateTimeEvent;

  factory EventDisplayOnCard.fromJson(Map<String, dynamic> json) => EventDisplayOnCard(
    idClient: json["id_client"],
    idEvent: json["id_event"],
    startDateTimeEvent: DateTime.parse(json["start_date_time_event"]),
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "id_event": idEvent,
    "start_date_time_event": startDateTimeEvent!.toIso8601String(),
  };
}
