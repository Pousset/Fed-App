// To parse this JSON data, do
//
//     final eventList = eventListFromJson(jsonString);

import 'dart:convert';

EventListModel eventListFromJson(String str) => EventListModel.fromJson(json.decode(str));

String eventListToJson(EventListModel data) => json.encode(data.toJson());

class EventListModel {
  EventListModel({
    required this.event,
  });

  List<Event> event;

  factory EventListModel.fromJson(Map<String, dynamic> json) => EventListModel(event: List<Event>.from(json["body"].map((x) => Event.fromJson(x))),);

  Map<String, dynamic> toJson() => {"body": List<dynamic>.from(event.map((x) => x.toJson())),};
}

class Event {
  Event({
    this.idClient,
    this.idEvent,
    this.eventType,
    this.eventImage,
    this.eventName,
    this.description,
    this.displayOnCard,
    this.startDateTimeEvent,
    this.endDateTimeEvent,
    this.bookingAccessEvent,
  });

  String? idClient;
  String? idEvent;
  String? eventType;
  String? eventImage;
  String? eventName;
  String? description;
  bool? displayOnCard;
  DateTime? startDateTimeEvent;
  DateTime? endDateTimeEvent;
  String? bookingAccessEvent;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    idClient: json["id_client"],
    idEvent: json["id_event"],
    eventType: json["event_type"],
    eventImage: json["event_image"],
    eventName: json["event_name"],
    description: json["description"],
    displayOnCard: int.parse(json["display_on_card"]) == 0 ? false : true,
    startDateTimeEvent: DateTime.parse(json["start_date_time_event"]),
    endDateTimeEvent: DateTime.parse(json["end_date_time_event"]),
    bookingAccessEvent: json["booking_access_event"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "id_event": idEvent,
    "event_type": eventType,
    "event_image": eventImage,
    "event_name": eventName,
    "description": description,
    "start_date_time_event": startDateTimeEvent!.toIso8601String(),
    "end_date_time_event": endDateTimeEvent!.toIso8601String(),
    "booking_access_event": bookingAccessEvent,
  };
}
