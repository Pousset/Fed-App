import 'package:fedhubs_pro/services/local/local_database.dart';

const String local = 'http://127.0.0.1:8000';

//const String local = 'https://dev.api.fedhubs.fr/';

// const headers = {'Content-Type': 'application/json'};

Map<String, String> get headers {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  // Add token to headers
  final user = LocalDatabase().getUser();
  if (user != null) {
    headers['Authorization'] = 'Bearer ${user.token}';
  }
  return headers;
}
