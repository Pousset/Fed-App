// To parse this JSON data, do
//
//     final errorHandlingCreation = errorHandlingCreationFromJson(jsonString);

import 'dart:convert';

ErrorHandlingCreation errorHandlingCreationFromJson(String str) => ErrorHandlingCreation.fromJson(json.decode(str));

String errorHandlingCreationToJson(ErrorHandlingCreation data) => json.encode(data.toJson());

class ErrorHandlingCreation {
  ErrorHandlingCreation({
     this.error,
     this.message,
  });

  bool? error;
  String? message;

  factory ErrorHandlingCreation.fromJson(Map<String, dynamic> json) => ErrorHandlingCreation(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
