import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:flutter/foundation.dart';
import 'constant_url.dart';
import 'package:http_parser/http_parser.dart';

class AuthenticationService {
  final Dio dio;
  final PersistCookieJar cookieJar;
  AuthenticationService(this.dio, this.cookieJar);

  static Future<AuthenticationService> init(
      Future<PersistCookieJar> cookieJar) async {
    final dio = Dio()
      ..interceptors.addAll([DioInterceptor(), CookieManager(await cookieJar)]);

    return AuthenticationService(dio, await cookieJar);
  }

  Future<bool> logout() async {
    try {
      final String token = LocalDatabase().getUser()?.token ?? '';
      final response = await dio.post(
        '$local/api/public/logout',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (_) {
      return false;
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    throw Exception('Unknown error');
  }

  Future<bool> checkIsUserAlreadyExist(int loginMethod, String email) async {
    try {
      await dio.post(
        '$local/api/public/login',
        data: {
          'login_method_id': loginMethod,
          'email': email,
          loginMethod == 1 ? 'password' : 'token': '',
        },
      );
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        return false;
      } else if (e.response?.statusCode == 401) {
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    throw Exception('Unknown error');
  }

  Future<User?> fetchUserData(String token, String tokenExp) async {
    try {
      final response = await dio.get(
        '$local/api/public/read_user',
        options: Options(headers: headers),
      );

      if (response.statusCode == 201) {
        final data = response.data['User'];
        data['token'] = token;
        data['token_exp'] = tokenExp;
        return User.fromJson(data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Unauthorized',
            message: "Vos identifiants sont incorrects",
          );
        }
        if (e.response?.statusCode == 404) {
          throw const LoginError(
            title: 'Not Found',
            message: "Adresse mail introuvable",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return null;
  }

  Future<User?> fetchUserWithService(
      int loginMethod, String userId, String email, String token) async {
    try {
      final response = await dio.post(
        '$local/api/public/login',
        data: {
          'login_method_id': loginMethod,
          'user_id': userId,
          'email': email,
          'token': token
        },
      );
      if (response.statusCode == 201) {
        final String token = response.data['access_token'];
        final String tokenExp = response.data['exp'];
        return fetchUserData(token, tokenExp);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Unauthorized',
            message: "Vos identifiants sont incorrects",
          );
        }
        if (e.response?.statusCode == 404) {
          throw const LoginError(
            title: 'Not Found',
            message: "Adresse mail introuvable",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return null;
  }

  Future<User?> fetchUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final response = await dio.post(
        '$local/api/pro/login',
        data: {'login_method_id': 1, 'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        final String token = response.data['access_token'];
        final String tokenExp = response.data['exp'];
        return fetchUserData(token, tokenExp);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Unauthorized',
            message: "Vos identifiants sont incorrects",
          );
        }
        if (e.response?.statusCode == 404) {
          throw const LoginError(
            title: 'Not Found',
            message: "Adresse mail introuvable",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return null;
  }

  Future<User?> createUserWithService(
    String userId,
    SignUpForm signUpForm,
  ) async {
    try {
      final formData = FormData.fromMap(
        {
          'login_method_id': int.parse(signUpForm.loginMethod!),
          'user_id': userId,
          'email': signUpForm.email!,
          'token': signUpForm.password!,
          'firstname': signUpForm.firstname!.trim(),
          'lastname': signUpForm.lastname!.trim(),
          'phone': signUpForm.phoneNumber!.trim(),
          'address': signUpForm.address!.trim(),
          'gender': 'null',
          'birth_date': '1970-01-01',
          'isPro': '1',
          'avatar': MultipartFile.fromBytes(
              signUpForm.profilePicture!.readAsBytesSync(),
              filename: 'image.png',
              contentType: MediaType('image', 'png'))
        },
      );

      final response = await dio.post(
        '$local/api/public/register',
        data: formData,
      );

      if (response.statusCode == 201) {
        return await fetchUserWithService(int.parse(signUpForm.loginMethod!),
            userId, signUpForm.email!, signUpForm.password!);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Email Already Use',
            message: "Ce compte existe déjà",
          );
        }
      }
      // print('STATUS: ${e.response?.statusCode}');
      // print('DATA: ${e.response?.data}');
      // print('HEADERS: ${e.response?.headers}');
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(SignUpForm signUpForm) async {
    try {
      final formData = FormData.fromMap(
        {
          'login_method_id': 1,
          'email': signUpForm.email!,
          'password': signUpForm.password!,
          'firstname': signUpForm.firstname!.trim(),
          'lastname': signUpForm.lastname!.trim(),
          'phone_number': signUpForm.phoneNumber!.trim(),
          'address': signUpForm.address!.trim(),
          'gender': 'null',
          'birth_date': '1970-01-01',
          'isPro': '1',
          'avatar': MultipartFile.fromBytes(
              signUpForm.profilePicture!.readAsBytesSync(),
              filename: 'image.png',
              contentType: MediaType('image', 'png'))
        },
      );

      final response = await dio.post(
        '$local/api/public/register',
        data: formData,
      );

      if (response.statusCode == 201) {
        return await fetchUserWithEmailAndPassword(
            signUpForm.email!, signUpForm.password!);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Email Already Use',
            message: "Cette adresse email est déjà utilisée",
          );
        }
      }
      // print('STATUS: ${e.response?.statusCode}');
      // print('DATA: ${e.response?.data}');
      // print('HEADERS: ${e.response?.headers}');
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return null;
  }

  Future<bool> forgotYourPassword(String email) async {
    try {
      final response = await dio.post(
        '$local/api/public/forgot_your_password',
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          throw const LoginError(
            title: 'Not Found',
            message: "Adresse mail introuvable",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return false;
  }

  Future<bool> checkCode(String email, String code) async {
    try {
      final response = await dio.post(
        '$local/api/public/verify_code',
        data: {
          'email': email,
          'code': code,
        },
      );

      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Unauthorized',
            message: "Code incorrect",
          );
        }
        if (e.response?.statusCode == 404) {
          throw const LoginError(
            title: 'Not Found',
            message: "Adresse mail introuvable",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return false;
  }

  Future<bool> resetPassword(String email, String code, String password) async {
    try {
      final response = await dio.post(
        '$local/api/public/reset_password',
        data: {
          'email': email,
          'code': code,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          throw const LoginError(
            title: 'Unauthorized',
            message: "Code incorrect",
          );
        }
        if (e.response?.statusCode == 404) {
          throw const LoginError(
            title: 'Not Found',
            message: "Adresse mail introuvable",
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      rethrow;
    }
    return false;
  }
}
