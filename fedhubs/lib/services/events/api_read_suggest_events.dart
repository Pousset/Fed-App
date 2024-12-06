import 'package:dio/dio.dart';
import 'package:fedhubs_pro/models/event/event_list/event_suggest_list.dart';
import 'package:fedhubs_pro/models/event/single_event/single_suggest_event.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
import '../constant_url.dart';

class ApiReadSuggestEvent {
  final Dio _dio = Dio()..interceptors.add(DioInterceptor());

  Future<SuggestEventListModel>? getCasualEventSuggestList() async {
    dynamic casualEventSuggestListModel;
    try {
      var response = await _dio.get(
          '${local}pro/api/read/event/suggest_events/read_event_suggest.php',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        casualEventSuggestListModel =
            SuggestEventListModel.fromJson(response.data);
      }
    } on Exception {
      return casualEventSuggestListModel;
    }
    return casualEventSuggestListModel;
  }

/*  Future<SuggestEventListModel> getArchiveEventSuggestList() async {
    var _archiveEventSuggestListModel;
    try {
      var response = await _dio.get(local+'pro/api/read/event/suggest_events/read_archive_event_suggest.php',
      options: Options(headers: headers));
      if (response.statusCode == 200) {
        _archiveEventSuggestListModel = SuggestEventListModel.fromJson(response.data);
      }
    } catch (Exception) {
      return _archiveEventSuggestListModel;
    }
    return _archiveEventSuggestListModel;
  }*/

  Future<SuggestEvent> fetchSingleSuggestEvent(String idSuggestEvent) async {
    try {
      var response = await _dio.get(
          '${local}pro/api/read/event/suggest_events/read_single_event_suggest.php/?id_event_suggest=$idSuggestEvent',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return SuggestEvent.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
