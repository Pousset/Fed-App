import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fedhubs_pro/models/account_handling/redirection_account_to_enterprise.dart';
import 'package:fedhubs_pro/models/section/all_filters.dart';
import 'package:fedhubs_pro/models/section/entreprise_categories_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_gallery_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_information_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_menu_model.dart';
import 'package:fedhubs_pro/models/section/entreprise_timetable_model.dart';
import 'package:fedhubs_pro/models/section/payment_methods.dart';
import 'package:fedhubs_pro/models/section/sect1_visit_card.dart';
import 'package:fedhubs_pro/models/section/sect2_crowd_info.dart';
import 'package:fedhubs_pro/models/section/sect4_general_info.dart';
import 'package:fedhubs_pro/models/section/sect5_social_network_links.dart';
import 'package:fedhubs_pro/models/section/sect6_comforts_availability.dart';
import 'package:fedhubs_pro/models/section/sect7_external_services.dart';
import 'package:fedhubs_pro/models/section/sect8_payment_info.dart';
import 'package:fedhubs_pro/services/dio_iterceptor.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/foundation.dart';
import '../constant_url.dart';

class ApiReadEnterprise {
  late final Future<Dio> _dio = _getDio();
  final Future<PersistCookieJar> cookieJar;

  ApiReadEnterprise(this.cookieJar);

  Future<Dio> _getDio() async {
    return Dio()
      ..interceptors.addAll([DioInterceptor(), CookieManager(await cookieJar)]);
  }

  VisitCardSect1? visitcard;

  Future<RedirectionAccountToEnterprise?> redirectionEnterprise() async {
    try {
      final dio = await _dio;
      var response = await dio.get(
        '$local/api/pro/entreprises_by_user',
        options: Options(headers: headers),
      );
      if (response.statusCode == 201) {
        return RedirectionAccountToEnterprise.fromJson(response.data);
      }
    } on Exception {
      return null;
    }
    return null;
  }

  Future<VisitCardSect1> fetchVisitCardSect1(String id) async {
    try {
      final dio = await _dio;
      final response = await dio.get('$local/api/public/entreprise?id=$id',
          options: Options(headers: headers));
      if (response.statusCode == 201) {
        visitcard = VisitCardSect1.fromJson(response.data['company']);
        return visitcard!;
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<EntrepriseInformationModel> fetchEntrepriseInformation(
      String id) async {
    try {
      final dio = await _dio;
      final response = await dio.get('$local/api/public/entreprise?id=$id',
          options: Options(headers: headers));
      if (response.statusCode == 201) {
        final model =
            EntrepriseInformationModel.fromJson(response.data['company']);
        model.idClient = id;
        return model;
      } else {
        return Future.error(Exception("Fail to Load data !"));
      }
    } catch (e) {
      return Future.error(Exception(e.toString()));
    }
  }

  Future<EntrepriseTimetableModel> fetchEntrepriseTimetable(String id) async {
    try {
      final dio = await _dio;
      final response = await dio.get(
          '${local}pro/api/read/sections_read/read_entreprise_timetable.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return EntrepriseTimetableModel.fromJson(response.data);
      } else {
        return Future.error(Exception("Fail to Load data !"));
      }
    } catch (e) {
      return Future.error(Exception(e.toString()));
    }
  }

  Future<EntrepriseTimetableModel> fetchEntrepriseReservationTimetable(
      String id) async {
    try {
      final dio = await _dio;
      final response = await dio.get(
          '${local}pro/api/read/sections_read/read_entreprise_reservation_timetable.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return EntrepriseTimetableModel.fromJson(response.data);
      } else {
        return Future.error(Exception("Fail to Load data !"));
      }
    } catch (e) {
      return Future.error(Exception(e.toString()));
    }
  }

  Future<EntrepriseMenuLinkListModel> fetchEntrepriseMenuLinkList(
      String id) async {
    try {
      final dio = await _dio;
      final response = await dio.get(
          '${local}pro/api/read/sections_read/read_section9.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return EntrepriseMenuLinkListModel.fromJson(response.data);
      } else {
        return Future.error(Exception("Fail to Load data !"));
      }
    } catch (e) {
      return Future.error(Exception(e.toString()));
    }
  }

  Future<EntrepriseGalleryModel> fetchEntrepriseGalleryList(String id) async {
    try {
      // final response = await _dio.get(
      //     '${local}pro/api/read/sections_read/read_gallery.php/?id_client=$id',
      //     options: Options(headers: headers));
      final Response response = Response(
          statusCode: 200,
          requestOptions: RequestOptions(
            path:
                '${local}pro/api/read/sections_read/read_gallery.php/?id_client=$id',
          ),
          data: {
            "message": "galery",
            "galery": {
              "current_page": 1,
              "data": [
                {
                  "id": 7,
                  "img_name": "frite",
                  "img_url":
                      "https://images.assetsdelivery.com/compings_v2/luka007/luka0071505/luka007150500232.jpg",
                  "img_description": null,
                  "company_id": 1,
                  "type_id": 1,
                  "article_id": null
                },
                {
                  "id": 6,
                  "img_name": "burger",
                  "img_url":
                      "https://thumbs.dreamstime.com/b/wooden-table-food-top-view-cafe-102532611.jpg",
                  "img_description": null,
                  "company_id": 1,
                  "type_id": 0,
                  "article_id": null
                },
                {
                  "id": 5,
                  "img_name": "pizza",
                  "img_url":
                      "https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg",
                  "img_description": null,
                  "company_id": 1,
                  "type_id": 2,
                  "article_id": null
                },
                {
                  "id": 4,
                  "img_name": "frite",
                  "img_url":
                      "https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg",
                  "img_description": null,
                  "company_id": 1,
                  "type_id": 2,
                  "article_id": null
                },
                {
                  "id": 3,
                  "img_name": "frite",
                  "img_url":
                      "https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg",
                  "img_description": null,
                  "company_id": 1,
                  "type_id": 2,
                  "article_id": null
                },
                {
                  "id": 2,
                  "img_name": "frite",
                  "img_url":
                      "https://images.pexels.com/photos/262978/pexels-photo-262978.jpeg",
                  "img_description": null,
                  "company_id": 1,
                  "type_id": 2,
                  "article_id": null
                }
              ],
              "first_page_url":
                  "http://127.0.0.1:8000/api/public/galery?page=1",
              "from": 1,
              "last_page": 1,
              "last_page_url": "http://127.0.0.1:8000/api/public/galery?page=1",
              "links": [
                {"url": null, "label": "&laquo; Previous", "active": false},
                {
                  "url": "http://127.0.0.1:8000/api/public/galery?page=1",
                  "label": "1",
                  "active": true
                },
                {"url": null, "label": "Next &raquo;", "active": false}
              ],
              "next_page_url": null,
              "path": "http://127.0.0.1:8000/api/public/galery",
              "per_page": 8,
              "prev_page_url": null,
              "to": 6,
              "total": 6
            }
          });
      if (response.statusCode == 200) {
        final data = response.data!['galery']['data'];
        return EntrepriseGalleryModel.fromJson(data);
      } else {
        return Future.error(Exception("Fail to Load data !"));
      }
    } catch (e) {
      return Future.error(Exception(e.toString()));
    }
  }

  Future<List<FilterSection>> fetchFilters() async {
    try {
      final dio = await _dio;
      final response = await dio.get('${local}public/api/read_filters.php/');
      if (response.statusCode == 200) {
        return Filters.fromJson(response.data).filters;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 404) return [];
      } else {}
    } catch (e) {
      if (kDebugMode) print('Error: $e');
      return Future.error(Exception(e.toString()));
    }
    return [];
  }

  Future<List<PaymentSection>> fetchPaymentMethods() async {
    try {
      final dio = await _dio;
      final response =
          await dio.get('${local}public/api/read_payment_methods.php/');

      if (response.statusCode == 200) {
        return PaymentMethods.fromJson(response.data).paymentMethods;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 404) return [];
      } else {}
    } catch (e) {
      return Future.error(Exception("Fail to Load data !"));
    }
    return [];
  }

  Future<EntrepriseCategoriesModel> fetchEntrepriseCategories(String id) async {
    try {
      // final response = await _dio.get(
      //     '${local}api/pro/read/sections_read/read_gallery.php/?id_client=$id',
      //     options: Options(headers: headers));
      final Response response = Response(
          statusCode: 200,
          requestOptions: RequestOptions(
            path:
                '${local}pro/api/read/sections_read/read_gallery.php/?id_client=$id',
          ),
          data: {
            "message": "Entrerprise",
            "entreprise": {
              "id": 1,
              "price_range": 0,
              "paymentmethod": [
                {
                  "category_name": "Carte bancaire",
                  "methods": {"4": "Visa"}
                },
              ],
              "category": [
                {
                  "category_name": "Diététique",
                  "methods": {"1": "100% Végan"}
                }
              ],
              "tags": [
                {"company_tag_label": "italienFood"},
                {"company_tag_label": "italien"},
                {"company_tag_label": "tag"}
              ]
            }
          });
      if (response.statusCode == 200) {
        final data = response.data!['entreprise'];
        return EntrepriseCategoriesModel.fromJson(data);
      } else {
        return Future.error(Exception("Fail to Load data !"));
      }
    } catch (e) {
      return Future.error(Exception(e.toString()));
    }
  }

  Future<CrowdInfoSect2> fetchCrowdInfoSect2(String id) async {
    try {
      final dio = await _dio;
      var response = await dio.get(
          '${local}pro/api/read/sections_read/read_section2.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return CrowdInfoSect2.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<GeneralInfoSect4> fetchGeneralInfoSect4(String id) async {
    try {
      final dio = await _dio;
      var response = await dio.get(
          '${local}pro/api/read/sections_read/read_section4.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return GeneralInfoSect4.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<SocialLinksSect5> fetchSocialLinksSect5(String id) async {
    try {
      final dio = await _dio;
      var response = await dio.get(
          '${local}pro/api/read/sections_read/read_section5.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return SocialLinksSect5.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ComfortAvailabilitySect6> fetchComfortAvailabilitySect6(
      String id) async {
    try {
      final dio = await _dio;
      var response = await dio.get(
          '${local}pro/api/read/sections_read/read_section6.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return ComfortAvailabilitySect6.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ExternalServicesSect7> fetchExternalServicesSect7(String id) async {
    try {
      final dio = await _dio;
      var response = await dio.get(
          '${local}pro/api/read/sections_read/read_section7.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return ExternalServicesSect7.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PaymentInfoSect8> fetchPaymentInfoSect8(String id) async {
    try {
      final dio = await _dio;
      var response = await dio.get(
          '${local}pro/api/read/sections_read/read_section8.php/?id_client=$id',
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return PaymentInfoSect8.fromJson(response.data);
      } else {
        throw Exception("Fail to Load data !");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
