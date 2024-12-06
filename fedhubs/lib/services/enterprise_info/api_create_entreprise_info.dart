import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fedhubs_pro/models/section/entreprise_gallery_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_menu_model.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import '../constant_url.dart';

class ApiCreateEnterprise {
  late final Future<Dio> _dio = _getDio();
  final Future<PersistCookieJar> cookieJar;

  ApiCreateEnterprise(this.cookieJar);

  Future<Dio> _getDio() async {
    return Dio()
      ..interceptors.addAll([DioInterceptor(), CookieManager(await cookieJar)]);
  }

  Future<bool> postEntrepriseMenuLink(MenuLink model, String idClient) async {
    try {
      Map<String, dynamic> data = model.toJson();
      data.remove('id_catalog');
      data['id_client'] = idClient;

      final dio = await _dio;
      final response = await dio.post(
          '${local}pro/api/create/create_catalog.php',
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

  Future<bool> postEntrepriseGalleryPicture(
      GalleryPicture model, File picture, String idClient) async {
    try {
      Map<String, dynamic> data = model.toJson();
      data.remove('id');
      data['id_client'] = idClient;

      final formData = FormData.fromMap(data);
      formData.files.add(MapEntry(
          'picture',
          MultipartFile.fromBytes(picture.readAsBytesSync(),
              filename: 'image.png', contentType: MediaType('image', 'png'))));

      // final dio = await _dio;
      // var response = await dio.post('${local}api/create/create_galery.php',
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
          path: '${local}pro/api/create/create_galery.php',
        ),
        data: {},
      );
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> postEntrepriseCategories(
      String categoryId, String idClient) async {
    try {
      final data = {
        "category_id": categoryId,
        "company_id": idClient,
      };
      // final dio = await _dio;
      // final response = await dio.post(
      //     '${local}api/pro/create_tie_company_category',
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

  Future<bool> postEntreprisePaymentMethods(
      String paymentMethodId, String idClient) async {
    try {
      final data = {
        "payment_method_id": paymentMethodId,
        "company_id": idClient,
      };
      // final dio = await _dio;
      // final response = await dio.post(
      //     '${local}api/pro/create_tie_payment_method_category',
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

  Future<bool> postEntrepriseTag(String tag, String idClient) async {
    try {
      Map<String, dynamic> data = {'name': tag, 'id_client': idClient};
      // final dio = await _dio;
      // var response = await dio.post('${local}api/pro/create_tag',
      //     data: data, options: Options(headers: headers));
      // if (response.statusCode == 200) {
      //   return true;
      // }
      return true;
    } on Exception {
      return false;
    }
    return false;
  }
}
