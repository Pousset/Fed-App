import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:flutter/foundation.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';

class LoginState extends ChangeNotifier {
  final LocalDatabase storage;
  bool _loggedIn = false;

  LoginState(this.storage) {
    checkLoggedIn();
  }

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    notifyListeners();
  }

  bool checkLoggedIn() {
    final user = storage.getUser();
    try {
      loggedIn =
          user != null && DateTime.parse(user.tokenExp).isAfter(DateTime.now());
    } on FormatException {
      loggedIn = false;
    }
    if (loggedIn == false) {
      storage.removeCompany();
    }
    return loggedIn;
  }
}
