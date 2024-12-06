import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.firstname,
    required this.lastname,
    required this.token,
    required this.tokenExp,
    required this.profilePicture,
    required this.phoneNumber,
    required this.address,
  });

  String firstname;
  String lastname;
  String token;
  String tokenExp;
  String profilePicture;
  String phoneNumber;
  String address;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"] ?? "",
        tokenExp: json['token_exp'] ?? "",
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        profilePicture: json["profile_picture"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_exp": tokenExp,
        "firstname": firstname,
        "lastname": lastname,
        "profile_picture": profilePicture,
        "phone_number": phoneNumber,
        "address": address,
      };

  @override
  String toString() => toJson().toString();
}
