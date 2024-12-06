import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/reservation/reservation_list.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import '../constant_url.dart';

class ApiReadReservation {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<ReservationList?> getReservationList(String id) async {
    ReservationList? reservationListModel;
    try {
      var response = await _dio.get(
          '${local}pro/api/read/reservation/read_reservation.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        reservationListModel = ReservationList.fromJson(response.data);
      }
    } on Exception {
      return reservationListModel;
    }
    return reservationListModel;
  }
}
