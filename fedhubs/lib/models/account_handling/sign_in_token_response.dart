// To parse this JSON data, do
//
//     final signInTokenResponse = signInTokenResponseFromJson(jsonString);

import 'dart:convert';

SignInTokenResponse signInTokenResponseFromJson(String str) => SignInTokenResponse.fromJson(json.decode(str));

String signInTokenResponseToJson(SignInTokenResponse data) => json.encode(data.toJson());

class SignInTokenResponse {
  SignInTokenResponse({
    this.status,
    this.message,
    this.jwt,
  });

  bool? status;
  String? message;
  String? jwt;

  factory SignInTokenResponse.fromJson(Map<String, dynamic> json) => SignInTokenResponse(
    status: json["status"],
    message: json["message"],
    jwt: json["jwt"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "jwt": jwt,
  };
}