// To parse this JSON data, do
//
//     final deleteUserEvent = deleteUserEventFromJson(jsonString);

import 'dart:convert';

DeleteUserEvent deleteUserEventFromJson(String str) => DeleteUserEvent.fromJson(json.decode(str));

String deleteUserEventToJson(DeleteUserEvent data) => json.encode(data.toJson());

class DeleteUserEvent {
  DeleteUserEvent({
    this.idClient,
    this.idEvent,
  });

  String? idClient;
  String? idEvent;

  factory DeleteUserEvent.fromJson(Map<String, dynamic> json) => DeleteUserEvent(
    idClient: json["id_client"],
    idEvent: json["id_event"],
  );

  Map<String, dynamic> toJson() => {
    "id_client": idClient,
    "id_event": idEvent,
  };
}
