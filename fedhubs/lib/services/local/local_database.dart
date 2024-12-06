import 'package:fedhubs_pro/models/coordinates.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  LocalDatabase._();
  static final _instance = LocalDatabase._();
  factory LocalDatabase() => _instance;

  static const String userBoxKey = "userBox";
  static const String companyBoxKey = "companyBox";
  static const String coordinatesBoxKey = "coordinatesBox";

  Future<void> initializeHive() async {
    await Hive.initFlutter();

    await Hive.openBox<String>(userBoxKey);
    await Hive.openBox<String>(companyBoxKey);
    await Hive.openBox<String>(coordinatesBoxKey);
  }

  User? getUser() {
    final user = Hive.box<String>(userBoxKey).get('user');
    return user != null ? userFromJson(user) : null;
  }

  Future<void> setUser(User user) =>
      Hive.box<String>(userBoxKey).put('user', userToJson(user));

  Future<void> removeUser() => Hive.box<String>(userBoxKey).delete('user');

  String? get getCompany => Hive.box<String>(companyBoxKey).get('company');
  String? get getAccountId => Hive.box<String>(companyBoxKey).get('accountId');

  Future<void> setCompany(String companyId, String accountId) async {
    Hive.box<String>(companyBoxKey).put('company', companyId);
    Hive.box<String>(companyBoxKey).put('accountId', accountId);
  }

  Future<void> removeCompany() async {
    Hive.box<String>(companyBoxKey).delete('company');
    Hive.box<String>(companyBoxKey).delete('accountId');
  }

  String? getCurrentAddress() =>
      Hive.box<String>(coordinatesBoxKey).get('address');

  CoordinatesModel? getCurrentCoordinates() {
    final coo = Hive.box<String>(coordinatesBoxKey).get('coordinates');

    return coo != null ? coordinatesModelFromJson(coo) : null;
  }
}
