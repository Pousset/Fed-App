import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import '../constant_url.dart';

class ApiDeleteEnterprise {
  late final Future<Dio> _dio = _getDio();
  final Future<PersistCookieJar> cookieJar;

  ApiDeleteEnterprise(this.cookieJar);

  Future<Dio> _getDio() async {
    return Dio()
      ..interceptors.addAll([DioInterceptor(), CookieManager(await cookieJar)]);
  }

  Future<bool> deleteEntrepriseMenuLink(String idMenu) async {
    try {
      final dio = await _dio;
      final response = await dio.post(
          '${local}pro/api/delete/delete_catalog.php',
          data: {"id_catalog": idMenu},
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> deleteEntrepriseGalleryPicture(String idGalery) async {
    try {
      // final dio = await _dio;
      // final response = await dio.post(
      //     '${local}api/pro/delete/delete_galery.php',
      //     data: {"id": idGalery},
      //     options: Options(headers: headers));
      final Response response = Response(
        statusCode: 200,
        requestOptions: RequestOptions(
          path: '${local}pro/api/update/update_galery.php',
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        return true;
      }
    } on Exception {
      return false;
    }
    return false;
  }

  Future<bool> deleteEntrepriseTag(String tag, String idClient) async {
    try {
      Map<String, dynamic> data = {'name': tag, 'id_client': idClient};
      // final dio = await _dio;
      // var response = await dio.delete('${local}api/pro/delete_tag',
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
