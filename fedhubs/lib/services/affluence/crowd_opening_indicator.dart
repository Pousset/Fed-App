import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/affluence/crowd_opening_indicator.dart';
import 'package:fedhubs_pro/models/error_message/error_handling_update.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import '../constant_url.dart';

class ApiAffluence {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<CrowdOpeningIndicator?> getCrowdOpeningIndicator(
      String idClient) async {
    dynamic crowdOpeningIndicatorModel;
    try {
      var response = await _dio.get(
          '${local}pro/api/read/affluence/read_affluence.php/?id_client=$idClient',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        crowdOpeningIndicatorModel =
            CrowdOpeningIndicator.fromJson(response.data);
      }
    } on Exception {
      return crowdOpeningIndicatorModel;
    }
    return crowdOpeningIndicatorModel;
  }

  Future<ErrorHandlingUpdate?> putCrowdOpeningIndicator(
      CrowdOpeningIndicator model) async {
    ErrorHandlingUpdate? errorMessageModel;
    try {
      var response = await _dio.post(
          '${local}pro/api/update/affluence/update_affluence.php',
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
