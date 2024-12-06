import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/error_message/error_handling_delete.dart';
import 'package:fedhubs_pro/models/event/single_event/delete_user_event.dart';
import 'package:fedhubs_pro/models/section/sect9_delete_catalog.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';

import 'constant_url.dart';

class ApiDelete {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<ErrorHandlingDelete?> deleteDataEvent(DeleteUserEvent model) async {
    ErrorHandlingDelete? errorMessageModel;
    try {
      var response = await _dio.post('${local}pro/api/delete/delete_event.php',
          data: model.toJson(), options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingDelete.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingDelete?> deleteDataCatalog(DeleteCatalog model) async {
    ErrorHandlingDelete? errorMessageModel;
    try {
      var response = await _dio.post(
          '${local}pro/api/delete/delete_catalog.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingDelete.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }
}
