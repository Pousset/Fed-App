import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';

SignUpForm signUpFormFromJson(String str) =>
    SignUpForm.fromJson(json.decode(str));

String signUpFormToJson(SignUpForm data) => json.encode(data.toJson());


class SignUpForm with ChangeNotifier {
  SignUpForm({
    this.loginMethod,
    this.email,
    this.password,
    this.firstname,
    this.lastname,
    this.phoneNumber,
    this.address,
    this.urlPicture,
    this.profilePicture,
  });

  String? loginMethod;
  String? email;
  String? password;
  String? firstname;
  String? lastname;
  String? phoneNumber;
  String? address;
  String? urlPicture;
  File? profilePicture;

  factory SignUpForm.fromJson(Map<String, dynamic> json) => SignUpForm(
        loginMethod: json["login_method"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        firstname: json["firstname"] ?? "",
        lastname: json["lastname"] ?? "",
        phoneNumber: json["phone_number"] ?? "",
        address: json["address"] ?? "",
        urlPicture: json["url_picture"] ?? "",
        profilePicture: json["profile_picture"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "login_method": loginMethod,
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "phone_number": phoneNumber,
        "address": address,
        "url_picture": urlPicture,
        "profile_picture": profilePicture,
      };

  void update({
    String? loginMethod,
    String? email,
    String? password,
    String? firstname,
    String? lastname,
    String? phoneNumber,
    String? address,
    String? urlPicture,
    File? profilePicture,
  }) {
    if (loginMethod != null) this.loginMethod = loginMethod;
    if (email != null) this.email = email;
    if (password != null) this.password = password;
    if (firstname != null) this.firstname = firstname;
    if (lastname != null) this.lastname = lastname;
    if (phoneNumber != null) this.phoneNumber = phoneNumber;
    if (address != null) this.address = address;
    if (urlPicture != null) this.urlPicture = urlPicture;
    if (profilePicture != null) this.profilePicture = profilePicture;
    notifyListeners();
  }

  @override
  String toString() {
    return 'login_method: $loginMethod, email: $email, password: $password, firstname: $firstname, '
        'lastname: $lastname, phoneNumber: $phoneNumber, '
        'address: $address, profilePicture: $profilePicture, urlPicture: $urlPicture';
  }

  void reset() {
    loginMethod = '';
    email = '';
    password = '';
    firstname = '';
    lastname = '';
    phoneNumber = '';
    address = '';
    urlPicture = '';
    profilePicture = null;
  }
}
