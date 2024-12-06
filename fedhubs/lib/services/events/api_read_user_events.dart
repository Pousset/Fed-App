import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/event/event_list/event_list.dart';
import 'package:fedhubs_pro/models/event/single_event/single_user_event.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import '../constant_url.dart';

class ApiReadEvent {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<EventListModel?> getLaterEventList(String id) async {
    EventListModel? laterEventListModel;
    try {
      var response = await _dio.get(
          '${local}pro/api/read/event/user_events/read_events.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        laterEventListModel = EventListModel.fromJson(response.data);
      }
    } on Exception {
      return laterEventListModel;
    }
    return laterEventListModel;
  }

  Future<EventListModel?> getArchiveEventList(String id) async {
    EventListModel? archiveEventListModel;
    try {
      var response = await _dio.get(
          '${local}pro/api/read/event/user_events/read_archive.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        archiveEventListModel = EventListModel.fromJson(response.data);
      }
    } on Exception {
      return archiveEventListModel;
    }
    return archiveEventListModel;
  }

  Future<UserEvent> fetchSingleUserEvent(String idEvent) async {
    try {
      var response = await _dio.get(
          '${local}pro/api/read/event/user_events/read_single_event.php/?id_event=$idEvent',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return UserEvent.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
