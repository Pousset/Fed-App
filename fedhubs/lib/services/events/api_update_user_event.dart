import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/error_message/error_handling_update.dart';
import 'package:fedhubs_pro/models/event/single_event/single_user_event.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import '../constant_url.dart';

class ApiUpdateEvent {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<ErrorHandlingUpdate?> putEvent(UserEvent model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      var response = await _dio.put('${local}pro/api/update/update_event.php',
          data: model.toJson(), options: Options(headers: headers));
      if (response.statusCode == 200) {
        errorMessageModel = ErrorHandlingUpdate.fromJson(response.data);
      }
    } on Exception {
      return errorMessageModel;
    }
    return errorMessageModel;
  }
}
