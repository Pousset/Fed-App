// ignore_for_file: unnecessary_const

/*
  Flutter UI
  ----------
  lib/screens/simple_login.dart
*/

import 'package:fedhubs_pro/models/account_handling/sign_in.dart';
import 'package:fedhubs_pro/models/account_handling/sign_in_token_response.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/screens/companies/companies_display.dart';
import 'package:fedhubs_pro/screens/login_forms/register.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/widgets/buttons/form_button.dart';
import 'package:flutter/material.dart';

class SimpleLoginScreen extends StatefulWidget {
  const SimpleLoginScreen({Key? key}) : super(key: key);

  /// Callback for when this form is submitted successfully. Parameters are (email, password)
  //final Function(String email, String password) onSubmitted;

  // SimpleLoginScreen({this.onSubmitted});
  @override
  SimpleLoginScreenState createState() => SimpleLoginScreenState();
}

class SimpleLoginScreenState extends State<SimpleLoginScreen> {
  late String email, password;
  late String emailError, passwordError;
  //Function(String email, String password) get onSubmitted => widget.onSubmitted;
  final Color _mainColor = const Color(0xFFF6885D);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignIn _modelSignIn = SignIn();
  final SignInTokenResponse _modelSignInTokenResponse = SignInTokenResponse();
  late Future<SignInTokenResponse?> _signInTokenResponseModel;
  RegExp emailExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  late User? user;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    checkIfAlreadyLogin();
  }

  void checkIfAlreadyLogin() async {
    user = LocalDatabase().getUser();
    if (user == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const CompaniesAccountListPage()));
    }
  }

/*  bool validate() {
    RegExp emailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    bool isValid = true;
    if (_modelSignIn.email.isEmpty || !emailExp.hasMatch(_modelSignIn.email)) {
      setState(() {
        emailError = "L'email est invalide.";
      });
      isValid = false;
    }

    if (_modelSignIn.password.isEmpty) {
      setState(() {
        passwordError = "Merci, d'entrer votre mot de passe.";
      });
      isValid = false;
    }

    return isValid;
  }*/

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * .12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Image.asset('assets/logo_black.png'),
                        ),
                        const Text(
                          "FEDHUBS",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * .01),
                    const Text(
                      "J'ai déjà un compte FEDHUBS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: screenHeight * .12),

                    // champ login
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty || !emailExp.hasMatch(value)) {
                          return "Ceci n'est pas un email";
                        }
                        if (_modelSignInTokenResponse.status == false) {
                          return 'Votre email est incorrect ?';
                        }

                        return null;
                      },
                      onSaved: (String? value) {
                        _modelSignIn.email = value;
                      },
                    ),
                    SizedBox(height: screenHeight * .025),

                    TextFormField(
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        border: const OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(15.0))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Mot de passe invalide';
                        }
                        if (_modelSignInTokenResponse.status == false) {
                          return 'Votre mot de passe est incorrect ?';
                        }

                        return null;
                      },
                      onChanged: (String? value) {
                        _modelSignIn.password = value;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    FormButton(
                      height: screenHeight * .08,
                      width: double.infinity,
                      text: "SE CONNECTER",
                      onPressed: () async {
                        _formKey.currentState!.save();
                        _signInTokenResponseModel =
                            (() async => SignInTokenResponse())();
                        await _signInTokenResponseModel.then((value) {
                          setState(() {
                            _modelSignInTokenResponse.status = value!.status;
                            _modelSignInTokenResponse.message = value.message;
                            _modelSignInTokenResponse.jwt = value.jwt;
                          });
                        });
                        if (_formKey.currentState!.validate() &&
                            _modelSignInTokenResponse.jwt != null) {
                          // loginData.setBool('login', false);
                          // loginData.setString(
                          //     'jwt', _modelSignInTokenResponse.jwt!);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CompaniesAccountListPage()));
                        }
                      },
                    ),
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SimpleRegisterScreen(),
                        ),
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Nouveau sur FEDHUBS ?\n",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: "S'INSCRIRE",
                              style: TextStyle(
                                color: _mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
