import 'package:fedhubs_pro/models/login_error.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GlobalState {
  GlobalState();

  bool isApplicationStart = true;
  LoginError? loginError;
  GoogleSignIn? googleSignIn;
}
