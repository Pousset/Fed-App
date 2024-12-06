import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/screens/sign_in/login_page.dart';

abstract class StringValidator {
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String? value) {
    return value?.isNotEmpty ?? false;
  }
}

class EmailStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    final parts = value.split('@');
    if (parts.length == 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      final fqdn = parts[1].split('.');
      if (fqdn.length == 2 && fqdn[0].isNotEmpty && fqdn[1].isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}

class PasswordStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.length >= 8;
  }

  int strength(String value) {
    final password = value.trim();
    // r'^
    //   (?=.*[A-Z])       // should contain at least one upper case
    //   (?=.*[a-z])       // should contain at least one lower case
    //   (?=.*?[0-9])      // should contain at least one digit
    //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
    //   .{8,}             // Must be at least 8 characters in length
    // $
    if (RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~+-.,:;=?]).{12,}$')
        .hasMatch(password)) return 6;
    if (RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~+-.,:;=?]).{8,}$')
        .hasMatch(password)) return 5;
    if (RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(password)) return 4;
    if (RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$').hasMatch(password)) {
      return 3;
    }
    if (password.length >= 8) return 2;
    if (password.isNotEmpty) return 1;
    return 0;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = EmailStringValidator();
  final PasswordStringValidator passwordValidator = PasswordStringValidator();
  final String invalidEmptyEmailErrorText = "L'email ne peut pas être vide";
  final String invalidEmailErrorText = "Veuillez vérifier votre adresse email";
  final String invalidWrongEmailErrorText =
      "Veuillez vérifier le format de votre email";
  final String invalidEmailAlreadyUseErrorText =
      'Veuillez utiliser une autre adresse mail';
  final String invalidWrongPasswordErrorText =
      "Le mot de passe doit au moins contenir 8 caractères";
  final String invalidPasswordErrorText =
      "Veuillez vérifier votre mot de passe";

  String invalidPasswordText(
      String password, LoginError? loginError, LoginMode mode) {
    if (password.isEmpty) {
      return "Le mot de passe ne peut pas être vide";
    } else if (loginError?.title == 'Unauthorized' && mode == LoginMode.login) {
      return "Veuillez vérifier votre mot de passe";
    } else if (mode == LoginMode.login) {
      return '';
    } else {
      switch (passwordValidator.strength(password)) {
        case 1:
          return 'Le mot de passe doit au moins contenir 8 caractères.';
        case 2:
          return 'Le mot de passe doit au moins un chiffre, une minuscule, une majuscule.';
        case 3:
          return 'Le mot de passe doit au moins une minuscule, une majuscule.';
        case 4:
          return "Il est conseillé d'ajouter un symbole à votre mot de passe.";
        case 5:
          return "Il est conseillé d'avoir un mot de passe d'au moins 12 caractères.";
        default:
          return '';
      }
    }
  }
}

class PhoneNumberStringValidator {
  String isValid(String value) {
    String pattern =
        r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return SignUpFormValidators().invalidEmptyPhoneNumberErrorText;
    } else if (!regExp.hasMatch(value)) {
      return SignUpFormValidators().invalidWrongPhoneNumberErrorText;
    }
    return '';
  }
}

class SignUpFormValidators {
  final StringValidator firstnameValidator = NonEmptyStringValidator();
  final StringValidator lastnameValidator = NonEmptyStringValidator();
  final PhoneNumberStringValidator phoneNumberValidator =
      PhoneNumberStringValidator();
  final StringValidator addressValidator = NonEmptyStringValidator();
  final PasswordStringValidator passwordValidator = PasswordStringValidator();
  final String invalidEmptyFirstnameErrorText = 'Veuillez entrer votre prénom ';
  final String invalidEmptyLastnameErrorText =
      'Veuillez entrer votre nom de famille';
  final String invalidEmptyPhoneNumberErrorText =
      'Veuillez entrer votre numéro de téléphone';
  final String invalidWrongPhoneNumberErrorText =
      'Veuillez entrer un numéro de téléphone valide';
  final String invalidEmptyAddressErrorText = 'Veuillez entrer votre adresse';

  bool formIsValid({
    required String firstname,
    required String lastname,
    required String phoneNumber,
    required String address,
  }) {
    return firstnameValidator.isValid(firstname) &&
        lastnameValidator.isValid(lastname) &&
        phoneNumberValidator.isValid(phoneNumber).isEmpty &&
        addressValidator.isValid(address);
  }
}
