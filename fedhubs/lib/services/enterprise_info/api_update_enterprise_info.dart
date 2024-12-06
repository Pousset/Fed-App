import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fedhubs_pro/models/error_message/error_handling_update.dart';
import 'package:fedhubs_pro/models/section/entreprise_gallery_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_information_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_menu_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_timetable_model.dart';
import 'package:fedhubs_pro/models/section/sect2_crowd_info.dart';
import 'package:fedhubs_pro/models/section/sect4_general_info.dart';
import 'package:fedhubs_pro/models/section/sect5_social_network_links.dart';
import 'package:fedhubs_pro/models/section/sect6_comforts_availability.dart';
import 'package:fedhubs_pro/models/section/sect7_external_services.dart';
import 'package:fedhubs_pro/models/section/sect8_payment_info.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';

import '../constant_url.dart';

class ApiUpdateEnterprise {
  late final Future<Dio> _dio = _getDio();
  final Future<PersistCookieJar> cookieJar;

  ApiUpdateEnterprise(this.cookieJar);

  Future<Dio> _getDio() async {
    return Dio()
      ..interceptors.addAll([DioInterceptor(), CookieManager(await cookieJar)]);
  }

  Future<bool> putEstablishmentInformation(
      EntrepriseInformationModel model) async {
    try {
      final dio = await _dio;
      final response = await dio.put(
          '${local}pro/api/update/update_sections/update_entreprise_information.php',
          data: model.toJson(),
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          print(response.data.statusCode);
          print(response.data.reasonPhrase);
          return false;
        }
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> putEntrepriseTimetable(
      EntrepriseTimetableModel model, String idClient) async {
    try {
      Map<String, dynamic> data = model.toJson();
      data['id_client'] = idClient;
      final dio = await _dio;
      final response = await dio.put(
          '${local}pro/api/update/update_sections/update_entreprise_timetable.php',
          data: data,
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> putEntrepriseReservationTimetable(
      EntrepriseTimetableModel model, String idClient) async {
    try {
      Map<String, dynamic> data = model.toJson();
      data['id_client'] = idClient;
      final dio = await _dio;
      final response = await dio.put(
          '${local}pro/api/update/update_sections/update_entreprise_reservation_timetable.php',
          data: data,
          options: Options(headers: headers));

      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> putEntrepriseMenuLink(MenuLink model, String idClient) async {
    try {
      Map<String, dynamic> data = model.toJson();
      data['id_client'] = idClient;
      final dio = await _dio;
      final response = await dio.put(
          '${local}pro/api/update/update_sections/update_section9_catalog.php',
          data: data,
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> putEntrepriseGalleryPicture(
    GalleryPicture model,
    String idClient, {
    File? picture,
  }) async {
    try {
      Map<String, dynamic> data = model.toJson();
      if (picture != null) data.remove('img_url');
      data['id_client'] = idClient;

      final formData = FormData.fromMap(data);
      if (picture != null) {
        formData.files.add(MapEntry(
            'picture',
            MultipartFile.fromBytes(picture.readAsBytesSync(),
                filename: 'image.png',
                contentType: MediaType('image', 'png'))));
      }

      // final dio = await _dio;
      // var response = await dio.post('${local}pro/api/update/update_galery.php',
      //     data: formData, options: Options(headers: headers));

      if (kDebugMode) {
        print(formData.fields +
            formData.files
                .map((e) => MapEntry(e.key, e.value.filename!))
                .toList());
      }
      final Response response = Response(
        statusCode: 200,
        requestOptions: RequestOptions(
          path: '${local}pro/api/update/update_galery.php',
          data: data,
          headers: headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> putEntrepriseCategoriesPosition(
      String position, String idClient) async {
    try {
      final data = {
        "position": position,
        "idClient": idClient,
      };

      // final dio = await _dio;
      // final response = await dio.put(
      //     '${local}api/pro/update_category_position',
      //     data: data,
      //     options: Options(headers: headers));
      // if (response.statusCode == 200) {
      //   return true;
      // }
      return true;
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> putEntreprisePriceRange(int priceRange, String idClient) async {
    try {
      final data = {"price_range": priceRange, "company_id": 1};

      // final dio = await _dio;
      // final response = await dio.put(
      //     '${local}api/pro/update_company',
      //     data: data,
      //     options: Options(headers: headers));
      // if (response.statusCode == 200) {
      //   return true;
      // }
      return true;
    } on Exception {
      return false;
    }
    return false;
  }

  Future<ErrorHandlingUpdate?> putCrowdInfoSect2(CrowdInfoSect2 model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      final dio = await _dio;
      var response = await dio.put(
          '${local}pro/api/update/update_sections/update_section2.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingUpdate?> putGeneralInfoSect4(
      GeneralInfoSect4 model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      final dio = await _dio;
      var response = await dio.put(
          '${local}pro/api/update/update_sections/update_section4.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingUpdate?> putSocialLinksSect5(
      SocialLinksSect5 model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      final dio = await _dio;
      var response = await dio.put(
          '${local}pro/api/update/update_sections/update_section5.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingUpdate?> putComfortAvailabilitySect6(
      ComfortAvailabilitySect6 model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      final dio = await _dio;
      var response = await dio.put(
          '${local}pro/api/update/update_sections/update_section6.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingUpdate?> putExternalServicesSect7(
      ExternalServicesSect7 model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      final dio = await _dio;
      var response = await dio.put(
          '${local}pro/api/update/update_sections/update_section7.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingUpdate?> putPaymentInfoSect8(
      PaymentInfoSect8 model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      final dio = await _dio;
      var response = await dio.put(
          '$local/pro/api/update/update_sections/update_section8.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }
}
