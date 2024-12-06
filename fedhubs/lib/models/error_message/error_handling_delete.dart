// To parse this JSON data, do
//
//     final ErrorHandlingDelete = ErrorHandlingDeleteFromJson(jsonString);

import 'dart:convert';

ErrorHandlingDelete errorHandlingDeleteFromJson(String str) => ErrorHandlingDelete.fromJson(json.decode(str));

String errorHandlingDeleteToJson(ErrorHandlingDelete data) => json.encode(data.toJson());

class ErrorHandlingDelete {
  ErrorHandlingDelete({
    this.error,
    this.message,
  });

  bool? error;
  String? message;

  factory ErrorHandlingDelete.fromJson(Map<String, dynamic> json) => ErrorHandlingDelete(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
