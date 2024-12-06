// To parse this JSON data, do
//
//     final userEvent = userEventFromJson(jsonString);

import 'dart:convert';

UserEvent userEventFromJson(String str) => UserEvent.fromJson(json.decode(str));

String userEventToJson(UserEvent data) => json.encode(data.toJson());

class UserEvent {
  UserEvent({
    this.idClient,
    this.idEvent,
    this.eventType,
    this.displayOnCard,
    this.eventImage,
    this.eventName,
    this.description,
    this.startDateTimeEvent,
    this.endDateTimeEvent,
    this.bookingAccessEvent,
  });

  String? idClient;
  String? idEvent;
  String? eventType;
  String? displayOnCard;
  String? eventImage;
  String? eventName;
  String? description;
  DateTime? startDateTimeEvent;
  DateTime? endDateTimeEvent;
  String? bookingAccessEvent;

  factory UserEvent.fromJson(Map<String, dynamic> json) => UserEvent(
    idClient: json["id_client"],
    eventType: json["event_type"],
    displayOnCard: json["display_on_card"],
    eventImage: json["event_image"],
    eventName: json["event_name"],
    description: json["description"],
    startDateTimeEvent: DateTime.parse(json["start_date_time_event"]),
    endDateTimeEvent: DateTime.parse(json["end_date_time_event"]),
    bookingAccessEvent: json["booking_access_event"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "id_event": idEvent,
    "event_type": eventType,
    "display_on_card": displayOnCard,
    "event_image": eventImage,
    "event_name": eventName,
    "description": description,
    "start_date_time_event": startDateTimeEvent!.toIso8601String(),
    "end_date_time_event": endDateTimeEvent!.toIso8601String(),
    "booking_access_event": bookingAccessEvent,
  };

}
