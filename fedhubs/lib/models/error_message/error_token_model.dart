// To parse this JSON data, do
//
//     final errorTokenModel = errorTokenModelFromJson(jsonString);

import 'dart:convert';

ErrorTokenModel errorTokenModelFromJson(String str) => ErrorTokenModel.fromJson(json.decode(str));

String errorTokenModelToJson(ErrorTokenModel data) => json.encode(data.toJson());

class ErrorTokenModel {
  ErrorTokenModel({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ErrorTokenModel.fromJson(Map<String, dynamic> json) => ErrorTokenModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}