import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method == 'POST') {
      if (kDebugMode) {
        print(
            'REQUEST[${options.method}] => PATH: ${options.path}, DATA: ${options.data}');
      }
    } else {
      if (kDebugMode) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
      }
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}, DATA: ${response.data}',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, DATA: ${err.response?.data}',
      );
    }
    return super.onError(err, handler);
  }
}
