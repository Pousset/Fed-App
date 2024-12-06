// To parse this JSON data, do
//
//     final SuggestEventListModel = SuggestEventListModelFromJson(jsonString);


class SuggestEventListModel {
  SuggestEventListModel({
     this.eventSuggest,
  });

  List<EventSuggest>? eventSuggest;

  factory SuggestEventListModel.fromJson(Map<String, dynamic> json) => SuggestEventListModel(
    eventSuggest: List<EventSuggest>.from(json["body"].map((x) => EventSuggest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "body": List<dynamic>.from(eventSuggest!.map((x) => x.toJson())),
  };
}

class EventSuggest {
  EventSuggest({
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

  factory EventSuggest.fromJson(Map<String, dynamic> json) => EventSuggest(
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

  Map<String, dynamic> toJson() => {
    "id_event_suggest": idEventSuggest,
    "id_partner": idPartner,
    "event_type": eventType,
    "event_image": eventImage,
    "event_name": eventName,
    "description": description,
    "start_date_time_event": startDateTimeEvent!.toIso8601String(),
    "end_date_time_event": endDateTimeEvent!.toIso8601String(),
    "booking_access_event": bookingAccessEvent,
  };
}
