// To parse this JSON data, do
//
//     final suggestEvent = suggestEventFromJson(jsonString);

import 'dart:convert';

SuggestEvent suggestEventFromJson(String str) => SuggestEvent.fromJson(json.decode(str));

String suggestEventToJson(SuggestEvent data) => json.encode(data.toJson());

class SuggestEvent {
  SuggestEvent({
    this.idEventSuggest,
    this.idPartner,
    this.eventType,
    this.eventImage,
    this.eventName,
    this.description,
    this.startDateTimeEvent,
    this.endDateTimeEvent,
    this.bookingAccessEvent,
  });

  String? idEventSuggest;
  String? idPartner;
  String? eventType;
  String? eventImage;
  String? eventName;
  String? description;
  DateTime? startDateTimeEvent;
  DateTime? endDateTimeEvent;
  String? bookingAccessEvent;

  factory SuggestEvent.fromJson(Map<String, dynamic> json) => SuggestEvent(
    idEventSuggest: json["id_event_suggest"],
    idPartner: json["id_partner"],
    eventType: json["event_type"],
    eventImage: json["event_image"],
    eventName: json["event_name"],
    description: json["description"],
    startDateTimeEvent: DateTime.parse(json["start_date_time_event"]),
    endDateTimeEvent: DateTime.parse(json["end_date_time_event"]),
    bookingAccessEvent: json["booking_access_event"],
  );


  // Special add
  Map<String, dynamic> toJson() => {
    "id_client": idEventSuggest,
    "event_type": eventType,
    "event_image": eventImage,
    "event_name": eventName,
    "description": description,
    "start_date_time_event": startDateTimeEvent!.toIso8601String(),
    "end_date_time_event": endDateTimeEvent!.toIso8601String(),
    "booking_access_event": bookingAccessEvent,
  };
}
