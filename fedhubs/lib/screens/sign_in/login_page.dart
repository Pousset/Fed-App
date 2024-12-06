import 'dart:math';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/screens/sign_in/forgot_your_password.dart';
import 'package:fedhubs_pro/screens/sign_in/complete_profile.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/global_state.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/inputs/sign_in_text_field.dart';
import 'package:fedhubs_pro/widgets/others/validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';


enum LoginMode {
  login,
  signin,
}

class LoginPage extends StatefulWidget with EmailAndPasswordValidators {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  LoginMode loginMode = LoginMode.login;
  LoginError? loginError;
  bool _passwordConfirm = false;
  bool _emailConfirm = false;

  @override
  void initState() {
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
    signUpForm.reset();
    super.initState();
  }

  Future<void> _submit() async {
    _passwordConfirm = true;

    if (loginMode == LoginMode.login) {
      final service = Provider.of<Auth>(context, listen: false);
      try {
        await service.signInWithEmailAndPassword(
            emailController.text, passwordController.text);
        setState(() => loginError = null);
      } on LoginError catch (e) {
        setState(() => loginError = e);
      }
      if (loginError == null) {
        service.loginState.checkLoggedIn();
      }
    } else {
      final signUpForm = Provider.of<SignUpForm>(context, listen: false);
      signUpForm.update(
        loginMethod: "1",
        email: emailController.text,
        password: passwordController.text,
      );
      CompleteYourProfile.push(context);
    }
  }

  void _emailEditingComplete() {
    setState(() {
      _emailConfirm = true;
      loginError = null;
    });
    final newFocus = widget.emailValidator.isValid(emailController.text)
        ? passwordFocusNode
        : emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _updateState() {
    setState(() {
      loginError = null;
    });
  }

  void _toggleLoginMode() {
    if (loginMode == LoginMode.login) {
      loginMode = LoginMode.signin;
    } else {
      loginMode = LoginMode.login;
    }
    _emailConfirm = false;
    _passwordConfirm = false;
    emailController.clear();
    passwordController.clear();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
    setState(() {});
  }

  void _facebookLogin() async {
    final service = Provider.of<Auth>(context, listen: false);
    late final User? user;

    final accessToken = await FacebookAuth.i.accessToken;
    if (accessToken != null) {
      try {
        final userData = await FacebookAuth.i.getUserData();
        user = await service.signInWithService(
            3, userData['id'], userData['email'], accessToken.token);
        if (user != null) service.loginState.checkLoggedIn();
      } on LoginError catch (e) {
        if (e.title == 'Not Found') {
          final userData = await FacebookAuth.i.getUserData();
          if (!mounted) return;
          final signUpForm = Provider.of<SignUpForm>(context, listen: false);
          signUpForm.update(
            loginMethod: "3",
            email: userData['email'],
            password: accessToken.token,
            urlPicture: userData['picture']['data']['url'],
          );

          final isExist =
              await service.checkIsUserAlreadyExist(3, userData['email']);
          if (!isExist) {
            CompleteYourProfile.push(context).then((value) => setState(() {}));
            setState(() => loginError = null);
          } else {
            setState(() => loginError = const LoginError(
                title: 'EmailAlreadyUse', message: 'Ce compte existe déjà'));
          }
        } else {
          setState(() => loginError = e);
        }
      } on PlatformException {
        _facebookLogin();
      }
    } else {
      final result = await FacebookAuth.i.login();
      switch (result.status) {
        case LoginStatus.success:
          final accessToken = await FacebookAuth.i.accessToken;
          final userData = await FacebookAuth.i.getUserData();
          try {
            user = await service.signInWithService(
                3, userData['id'], userData['email'], accessToken!.token);
            if (user != null) service.loginState.checkLoggedIn();
            setState(() => loginError = null);
          } on LoginError catch (e) {
            if (e.title == 'Not Found') {
              final userData = await FacebookAuth.i.getUserData();
              if (!mounted) return;
              final signUpForm =
                  Provider.of<SignUpForm>(context, listen: false);
              signUpForm.update(
                loginMethod: "3",
                email: userData['email'],
                password: accessToken!.token,
                urlPicture: userData['picture']['data']['url'],
              );

              final isExist =
                  await service.checkIsUserAlreadyExist(3, userData['email']);
              if (!isExist) {
                CompleteYourProfile.push(context).then((value) => setState(() {}));
                setState(() => loginError = null);
              } else {
                setState(() => loginError = const LoginError(
                    title: 'EmailAlreadyUse',
                    message: 'Ce compte existe déjà'));
              }
            } else {
              setState(() => loginError = e);
            }
          }
          break;
        default:
          setState(() {
            loginError = LoginError(
              title: result.status.name,
              message: result.message!,
            );
          });
          break;
      }
    }
  }

  void _googleSignIn() async {
    final global = Provider.of<GlobalState>(context, listen: false);
    final service = Provider.of<Auth>(context, listen: false);
    final googleSignIn = GoogleSignIn();
    global.googleSignIn = googleSignIn;
    late final User? user;
    googleSignIn.signOut();

    GoogleSignInAccount? currentUser = await googleSignIn.signIn();

    if (currentUser != null) {
      final idToken = (await currentUser.authentication).idToken!;
      try {
        if (loginMode == LoginMode.login) {
          user = await service.signInWithService(
              2, currentUser.id, currentUser.email, idToken);
          if (user != null) service.loginState.checkLoggedIn();
        } else {
          if (!mounted) return;
          final signUpForm = Provider.of<SignUpForm>(context, listen: false);
          signUpForm.update(
            loginMethod: "2",
            email: currentUser.email,
            password: idToken,
            urlPicture: JwtDecoder.decode(idToken)['picture'],
          );
          final isExist =
              await service.checkIsUserAlreadyExist(2, currentUser.email);
          if (!isExist) {
             CompleteYourProfile.push(context);
            setState(() => loginError = null);
          } else {
            setState(() => loginError = const LoginError(
                title: 'EmailAlreadyUse', message: 'Ce compte existe déjà'));
          }
        }
      } on LoginError catch (e) {
        if (e.title == 'Not Found') {
          if (!mounted) return;
          final signUpForm = Provider.of<SignUpForm>(context, listen: false);
          signUpForm.update(
            loginMethod: "2",
            email: currentUser.email,
            password: idToken,
            urlPicture: JwtDecoder.decode(idToken)['picture'],
          );
          final isExist =
              await service.checkIsUserAlreadyExist(2, currentUser.email);
          if (!isExist) {
             CompleteYourProfile.push(context);
            setState(() => loginError = null);
            setState(() => loginError = e);
          } else {
            setState(() => loginError = const LoginError(
                title: 'EmailAlreadyUse', message: 'Ce compte existe déjà'));
          }
        } else {
          setState(() => loginError = e);
        }
      }
    } else {
      setState(() {});
    }
  }

  void _sendResetCode() async {
    if (widget.emailValidator.isValid(emailController.text)) {
      try {
        final service = Provider.of<Auth>(context, listen: false);
        final signUpForm = Provider.of<SignUpForm>(context, listen: false);
        await service.forgotYourPassword(emailController.text);
        signUpForm.update(email: emailController.text);
        if (!mounted) return;
        ForgotYourPassword.push(context);
      } on LoginError catch (e) {
        setState(() => loginError = e);
      }
    } else {
      setState(() => _emailConfirm = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final allFormIsValid =
        ((widget.emailValidator.isValid(emailController.text)) &&
            widget.passwordValidator.strength(passwordController.text) >=
                (loginMode == LoginMode.login ? 1 : 4));

    final globalState = Provider.of<GlobalState>(context);
    if (globalState.loginError != null) {
      FocusScope.of(context).requestFocus(emailFocusNode);
      loginError = globalState.loginError;
      globalState.loginError = null;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: SizedBox(
            height: max(screenSize.height, 732),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(flex: 3, child: SizedBox()),
                    Image.asset(
                      'assets/icon/icon_no_background.png',
                      scale: 3,
                    ),
                    const Text(
                      'Bienvenue sur Fedhubs',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Découvrez, savourez, profitez',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    if (loginError == null) const SizedBox(height: 32),
                    if (loginError != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        loginError!.message,
                        style: const TextStyle(
                          color: Color.fromRGBO(211, 47, 47, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    SignInTextField(
                      label: 'Email',
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      focusNode: emailFocusNode,
                      isWrong: loginError?.title == 'Not Found' ||
                          loginError?.title == 'Email Already Use' ||
                          (_emailConfirm &&
                              !widget.emailValidator
                                  .isValid(emailController.text)),
                      errorText: emailController.text.isEmpty
                          ? widget.invalidEmptyEmailErrorText
                          : (loginError != null
                              ? (loginError!.title == 'Email Already Use'
                                  ? widget.invalidEmailAlreadyUseErrorText
                                  : widget.invalidEmailErrorText)
                              : widget.invalidWrongEmailErrorText),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: _emailEditingComplete,
                      onChange: () {
                        _emailConfirm = true;
                        _updateState();
                      },
                    ),
                    SignInTextField(
                      label: 'Mot de passe',
                      hintText: 'Mot de passe',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      isWrong: loginError?.title == 'Unauthorized' ||
                          (_passwordConfirm &&
                              widget
                                  .invalidPasswordText(passwordController.text,
                                      loginError, loginMode)
                                  .isNotEmpty),
                      errorText: widget.invalidPasswordText(
                          passwordController.text, loginError, loginMode),
                      passwordStrength: widget.passwordValidator
                          .strength(passwordController.text),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: allFormIsValid
                          ? _submit
                          : () => setState(() {
                                _passwordConfirm = true;
                              }),
                      onChange: () {
                        _passwordConfirm = true;
                        _updateState();
                      },
                    ),
                    const SizedBox(height: 25),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: loginMode == LoginMode.login
                          ? 'Se connecter'
                          : "Créer un compte",
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: allFormIsValid ? _submit : null,
                    ),
                    const SizedBox(height: 9),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _sendResetCode,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Mot de passe perdu ?',
                          style: TextStyle(
                            color: widget.emailValidator
                                    .isValid(emailController.text)
                                ? Theme.of(context).secondaryHeaderColor
                                : Theme.of(context)
                                    .secondaryHeaderColor
                                    .withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 21),
                    const Text(
                      'Ou se connecter avec',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildServiceButton(
                          width: (screenSize.width - 60) / 2,
                          text: 'Google',
                          color: Colors.white,
                          onPressed: _googleSignIn,
                          svgPath: 'assets/icon_google.svg',
                        ),
                        _buildServiceButton(
                          width: (screenSize.width - 60) / 2,
                          text: 'Facebook',
                          color: Colors.white,
                          onPressed: _facebookLogin,
                          svgPath: 'assets/icon_facebook.svg',
                        ),
                      ],
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _toggleLoginMode,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: loginMode == LoginMode.login
                                        ? 'Pas de compte ? '
                                        : 'Vous avez un compte ? ',
                                  ),
                                  TextSpan(
                                    text: loginMode == LoginMode.login
                                        ? "S'inscrire"
                                        : "Se connecter",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                    ),
                                  ),
                                ],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceButton({
    required String text,
    required String svgPath,
    required double width,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 35,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: MaterialButton(
        minWidth: width,
        onPressed: onPressed,
        color: color,
        splashColor: Colors.white,
        highlightColor: Colors.white,
        elevation: 0,
        highlightElevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(120.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SvgPicture.asset(
                svgPath,
              ),
              const SizedBox(width: 10.0),
              Text(
                text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
