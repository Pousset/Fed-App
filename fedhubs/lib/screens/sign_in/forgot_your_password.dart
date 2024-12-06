import 'dart:math';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/screens/sign_in/reset_password.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/global_state.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ForgotYourPassword extends StatefulWidget {
  const ForgotYourPassword({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const ForgotYourPassword(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<ForgotYourPassword> createState() => _ForgotYourPasswordState();
}

class _ForgotYourPasswordState extends State<ForgotYourPassword> {
  LoginError? loginError;
  late Code code;

  @override
  void initState() {
    code = Code(4);
    super.initState();
  }

  void _submit() async {
    final service = Provider.of<Auth>(context, listen: false);
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
    if (signUpForm.email != null) {
      try {
        await service.checkCode(signUpForm.email!, code.value);
        setState(() => loginError = null);
        if (!mounted) return;
        ResetPassword.push(context, code.value);
      } on LoginError catch (e) {
        setState(() => loginError = e);
      }
    } else {
      final globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.loginError = const LoginError(
          title: 'Not Found', message: "Adresse mail introuvable");
      Navigator.of(context).pop();
    }
  }

  void _sendBackResetCode() async {
    final service = Provider.of<Auth>(context, listen: false);
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
    if (signUpForm.email != null) {
      try {
        service.forgotYourPassword(signUpForm.email!);
        setState(() => loginError = null);
      } on LoginError catch (e) {
        setState(() => loginError = e);
      }
    } else {
      final globalState = Provider.of<GlobalState>(context, listen: false);
      globalState.loginError = const LoginError(
          title: 'Not Found', message: "Adresse mail introuvable");
      Navigator.of(context).pop();
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
                    if (loginError == null) const SizedBox(height: 62),
                    if (loginError != null) ...[
                      const SizedBox(height: 25),
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
                    numberSection(screenSize, code),
                    const SizedBox(height: 32),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _sendBackResetCode,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          'Renvoyer un code',
                          style: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Suivant',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: _submit,
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
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
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
      SizedBox(
        width: 350,
        child: Text(
          "Veuillez inscrire le code reçu à l'adresse ${signUpForm.email}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    ];
  }

  Widget numberSection(Size screenSize, Code code) {
    final width = (screenSize.width - 40) / code.length - 10;
    return Row(
      children: List.generate(code.length, (index) {
        final isLast = index == code.length - 1;
        return number(
          width: width,
          action: isLast ? TextInputAction.done : TextInputAction.next,
          controller: code.controllers[index],
          onEditingComplete: isLast ? () => code.send(context) : null,
        );
      }),
    );
  }

  Widget number({
    required double width,
    required TextInputAction action,
    required TextEditingController controller,
    VoidCallback? onEditingComplete,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        child: Container(
          width: width,
          height: 76,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(width / 4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 16,
                  blurStyle: BlurStyle.outer)
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(width / 4)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                controller: controller,
                onChanged: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).previousFocus();
                  } else if (onEditingComplete == null) {
                    FocusScope.of(context).nextFocus();
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
                onEditingComplete: onEditingComplete,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  counterText: '',
                ),
                style: const TextStyle(fontWeight: FontWeight.w600),
                cursorColor: const Color.fromRGBO(0, 0, 0, 0.6),
                textInputAction: action,
                maxLength: 1,
              ),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

class Code {
  Code(this.length)
      : controllers = List.generate(length, (index) => TextEditingController());

  final int length;
  final List<TextEditingController> controllers;

  String get value => controllers.fold('', (a, b) => a + b.text);

  Future<void> send(BuildContext context) async {
    FocusScope.of(context).unfocus();
  }
}
