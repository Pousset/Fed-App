import 'dart:math';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/screens/sign_in/login_page.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/global_state.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/inputs/sign_in_text_field.dart';
import 'package:fedhubs_pro/widgets/others/validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget with EmailAndPasswordValidators {
  ResetPassword({Key? key, required this.code}) : super(key: key);

  static Future<void> push(BuildContext context, String code) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => ResetPassword(code: code),
      fullscreenDialog: true,
    ));
  }

  final String code;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final passwordConfirmFocusNode = FocusNode();

  LoginError? loginError;
  bool _passwordEnableConfirm = false;
  bool _passwordConfirmEnableConfirm = false;

  void _submit() async {
    final service = Provider.of<Auth>(context, listen: false);
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);

    if (signUpForm.email != null) {
      try {
        await service.resetPassword(
            signUpForm.email!, widget.code, passwordController.text);
        if (!mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } on LoginError catch (e) {
        if (e.title == 'Unauthorized') {
          final globalState = Provider.of<GlobalState>(context, listen: false);
          globalState.loginError = e;
          Navigator.of(context).pop();
        }
        setState(() => loginError = e);
      }
    } else {
      final globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.loginError = const LoginError(
          title: 'Not Found', message: "Adresse mail introuvable");
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  void _updateState() {
    setState(() {
      loginError = null;
    });
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
        (widget.passwordValidator.strength(passwordController.text) >= 4 &&
            passwordConfirmController.text == passwordController.text);

    final globalState = Provider.of<GlobalState>(context);
    if (globalState.loginError != null) {
      FocusScope.of(context).requestFocus(passwordFocusNode);
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
            height: max(screenSize.height, 668),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildHeader(context, screenSize),
                    const SizedBox(height: 49),
                    SignInTextField(
                      label: 'Nouveau mot de passe',
                      hintText: 'Nouveau mot de passe',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      isWrong: loginError?.title == 'Unauthorized' ||
                          (_passwordEnableConfirm &&
                              widget
                                  .invalidPasswordText(passwordController.text,
                                      loginError, LoginMode.signin)
                                  .isNotEmpty),
                      errorText: widget.invalidPasswordText(
                          passwordController.text,
                          loginError,
                          LoginMode.signin),
                      passwordStrength: widget.passwordValidator
                          .strength(passwordController.text),
                      textInputAction: TextInputAction.done,
                      onEditingComplete: allFormIsValid
                          ? _submit
                          : () => setState(() {
                                _passwordEnableConfirm = true;
                              }),
                      onChange: () {
                        _passwordEnableConfirm = true;
                        _updateState();
                      },
                    ),
                    SignInTextField(
                      label: 'Confirmation mot de passe',
                      hintText: 'Confirmation mot de passe',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordConfirmController,
                      focusNode: passwordConfirmFocusNode,
                      isWrong: _passwordConfirmEnableConfirm &&
                          passwordConfirmController.text !=
                              passwordController.text,
                      errorText: 'Le mot de passe de correspond pas',
                      textInputAction: TextInputAction.done,
                      onEditingComplete: allFormIsValid
                          ? _submit
                          : () => setState(() {
                                _passwordConfirmEnableConfirm = true;
                              }),
                      onChange: () {
                        _passwordConfirmEnableConfirm = true;
                        _updateState();
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Suivant',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: allFormIsValid ? _submit : null,
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

  List<Widget> _buildHeader(BuildContext context, Size screenSize) {
    return [
      SizedBox(height: screenSize.height * 0.09),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          GestureDetector(
            child: Stack(children: [
              Icon(
                Icons.circle,
                color: Theme.of(context).secondaryHeaderColor,
                size: 40,
              ),
              const Positioned(
                left: 14,
                bottom: 10,
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ]),
            onTap: () => Navigator.of(context).pop(),
          ),
          const SizedBox(
            width: 16,
          ),
          const Text(
            'Mot de passe perdu',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
      const SizedBox(height: 52),
      const SizedBox(
        width: 350,
        child: Text(
          "Créer un nouveau mot de passe",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    ];
  }
}
