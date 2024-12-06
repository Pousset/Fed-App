import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/error_message/error_handling_update.dart';
import 'package:fedhubs_pro/models/event/event_display_on_card.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import '../constant_url.dart';

class ApiUpdateFowardEvent {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<ErrorHandlingUpdate?> putEvent(EventDisplayOnCard model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      var response = await _dio.post(
          '${local}pro/api/update/event/foward_event_on_card.php',
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
