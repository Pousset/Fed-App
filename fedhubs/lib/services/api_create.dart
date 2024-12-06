import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/error_message/error_handling_creation.dart';
import 'package:fedhubs_pro/models/event/single_event/single_suggest_event.dart';
import 'package:fedhubs_pro/models/event/single_event/single_user_event.dart';
import 'package:fedhubs_pro/models/section/sect9bis_single_catalog.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import 'constant_url.dart';

class ApiCreate {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<ErrorHandlingCreation?> postDataCatalog(SingleCatalog model) async {
    ErrorHandlingCreation? errorMessageModel;
    try {
      var response = await _dio.post(
          '${local}pro/api/create/create_catalog.php',
          data: model.toJson(),
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingCreation.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingCreation?> postDataEvent(UserEvent model) async {
    ErrorHandlingCreation? errorMessageModel;
    try {
      var response = await _dio.post('${local}pro/api/create/create_event.php',
          data: model.toJson(), options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingCreation.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }

  Future<ErrorHandlingCreation?> postDataSuggestEvent(
      SuggestEvent model) async {
    ErrorHandlingCreation? errorMessageModel;
    try {
      var response = await _dio.post('${local}pro/api/create/create_event.php',
          data: model.toJson(), options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingCreation.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }
}
