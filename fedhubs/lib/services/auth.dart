import 'dart:convert';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/services/authentication_service.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/services/local/login_state.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:crypto/crypto.dart';


abstract class AuthBase {
  User? get currentUser;
  Future<User?> signUpWithService(String userId, SignUpForm signUpForm);
  Future<User?> signInWithService(
      int loginMethod, String userId, String email, String token);
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(SignUpForm signUpForm);
  Future<void> signOut();
}

class Auth implements AuthBase {
  Auth(this.loginState, this.cookieJar);

  final LoginState loginState;
  final Future<PersistCookieJar> cookieJar;

  late final _service = AuthenticationService.init(cookieJar);

  @override
  Future<User?> signUpWithService(String userId, SignUpForm signUpForm) async {
    try {
      final service = await _service;
      final user = await service.createUserWithService(userId, signUpForm);
      if (user != null) await LocalDatabase().setUser(user);
      return user;
    } on LoginError {
      rethrow;
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(SignUpForm signUpForm) async {
    try {
      final service = await _service;
      signUpForm = signUpForm
        ..password =
            sha512256.convert(utf8.encode(signUpForm.password!)).toString();
      final user = await service.createUserWithEmailAndPassword(
        signUpForm,
      );
      if (user != null) await LocalDatabase().setUser(user);
      return user;
    } on LoginError {
      rethrow;
    }
  }

  @override
  User? get currentUser {
    final User? user = LocalDatabase().getUser();
    if (user?.token != null) {
      try {
        // if (!JwtDecoder.isExpired(user!.token)) {
        //   return user;
        // }
        return user;
      } on FormatException {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<User?> signInWithService(
      int loginMethod, String userId, String email, String token) async {
    try {
      final service = await _service;
      final user =
          await service.fetchUserWithService(loginMethod, userId, email, token);
      if (user != null) await LocalDatabase().setUser(user);
      return user;
    } on LoginError {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final service = await _service;
      final user = await service.fetchUserWithEmailAndPassword(
        email,
        password,//sha512256.convert(utf8.encode(password)).toString(),
      );
      if (user != null) await LocalDatabase().setUser(user);
      return user;
    } on LoginError {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await logout();
    await LocalDatabase().removeUser();
    await GoogleSignIn().signOut();
    await FacebookAuth.i.logOut();
    loginState.loggedIn = false;
  }

  Future<bool> checkIsUserAlreadyExist(int loginMethod, String email) async {
    final service = await _service;
    return await service.checkIsUserAlreadyExist(loginMethod, email);
  }

  Future<bool> logout() async {
    final service = await _service;
    return await service.logout();
  }

  Future<bool> forgotYourPassword(String email) async {
    try {
      final service = await _service;
      await service.forgotYourPassword(email);
      return true;
    } on LoginError {
      rethrow;
    }
  }

  Future<bool> checkCode(String email, String code) async {
    try {
      final service = await _service;
      await service.checkCode(email, code);
      return true;
    } on LoginError {
      rethrow;
    }
  }

  Future<bool> resetPassword(String email, String code, String password) async {
    try {
      final service = await _service;
      await service.resetPassword(
        email,
        code,
        sha512256.convert(utf8.encode(password)).toString(),
      );
      return true;
    } on LoginError {
      rethrow;
    }
  }
}
