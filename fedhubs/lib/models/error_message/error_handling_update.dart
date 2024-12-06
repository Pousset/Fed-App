// To parse this JSON data, do
//
//     final ErrorHandlingUpdate = ErrorHandlingUpdateFromJson(jsonString);

import 'dart:convert';

ErrorHandlingUpdate errorHandlingUpdateFromJson(String str) => ErrorHandlingUpdate.fromJson(json.decode(str));

String errorHandlingUpdateToJson(ErrorHandlingUpdate data) => json.encode(data.toJson());

class ErrorHandlingUpdate {
  ErrorHandlingUpdate({
    this.error,
    this.message,
  });

  bool? error;
  String? message;

  factory ErrorHandlingUpdate.fromJson(Map<String, dynamic> json) => ErrorHandlingUpdate(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
