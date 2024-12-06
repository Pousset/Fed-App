import 'dart:math';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/screens/sign_in/download_profile_picture.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/geolocator_service.dart';
import 'package:fedhubs_pro/services/local/global_state.dart';
import 'package:fedhubs_pro/widgets/others/validators.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/inputs/sign_in_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';




class CompleteYourProfile extends StatefulWidget {
 
  const CompleteYourProfile({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const CompleteYourProfile(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<CompleteYourProfile> createState() => _CompleteYourProfileState();
  }

class _CompleteYourProfileState extends State<CompleteYourProfile> {
  late final TextEditingController firstnameController;
  late final TextEditingController lastnameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController addressController;

  final Map<String, bool> _isSubmitted = {
    'firstname': false,
    'lastname': false,
    'phoneNumber': false,
    'address': false,
  };
  LoginError? loginError;

@override
  void initState() {
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
    firstnameController = TextEditingController(text: signUpForm.firstname);
    lastnameController = TextEditingController(text: signUpForm.lastname);
    phoneNumberController = TextEditingController(text: signUpForm.phoneNumber);
    addressController = TextEditingController(text: signUpForm.address);
    super.initState();
  }
  

  void _submit() async {
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
    final _service = Provider.of<Auth>(context, listen: false);
    signUpForm.update(
      firstname: firstnameController.text,
      lastname: lastnameController.text,
      phoneNumber: phoneNumberController.text,
      address: addressController.text,
    );
    if (signUpForm.loginMethod == "1") {
      DownloadYourProfilePicture.push(context,state: DownloadYourProfilePictureState.first);
    } else if (signUpForm.loginMethod == "2") {
      final _googleSignIn =
          Provider.of<GlobalState>(context, listen: false).googleSignIn!;
      try {
        if (signUpForm.password != null) {
          if (await _googleSignIn.isSignedIn()) {
            final user = await _service.signUpWithService(_googleSignIn.currentUser!.id, signUpForm);
           if (kIsWeb && !await LocationService.checkPermission()) {
              //LocationPermissionPage.push(context, LocationPageAccessMode.first);
            } else if (!kIsWeb && !await GeolocatorService.checkPermission()) {
              //LocationPermissionPage.push(context, LocationPageAccessMode.first);
            } else if (user != null) {//CongratulationsPage.push(context);
            }
          } else {
            throw const LoginError(
                title: 'Expired Token',
                message: 'Votre token facebook à expiré');
          }
        }
      } on LoginError catch (e) {
        final globalState = Provider.of<GlobalState>(context, listen: false);
        globalState.loginError = e;
        Navigator.of(context).pop();
      }
    } else if (signUpForm.loginMethod == "3") {
      DownloadYourProfilePicture.push(context,state: DownloadYourProfilePictureState.first);
    }
  }
  void _updateState() {
    setState(() {});
  }

  void _onEditingComplete(String name, bool isValid) {
    setState(() => _isSubmitted[name] = true);
    if (isValid) FocusScope.of(context).nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    final validators = SignUpFormValidators();
    final _formIsValid = validators.formIsValid(
      firstname: firstnameController.text,
      lastname: lastnameController.text,
      phoneNumber: phoneNumberController.text,
      address: addressController.text,
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(0.6),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: SizedBox(
            height: max(screenSize.height, 778),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildHeader(context, screenSize),
                    const SizedBox(height: 32),
                    SignInTextField(
                      controller: lastnameController,
                      label: 'Nom',
                      hintText: 'Nom',
                      isWrong: _isSubmitted['lastname']! &&
                          !validators.lastnameValidator
                              .isValid(lastnameController.text),
                      errorText: validators.invalidEmptyLastnameErrorText,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChange: _updateState,
                      onEditingComplete: () => _onEditingComplete(
                          'lastname',
                          validators.lastnameValidator
                              .isValid(lastnameController.text)),
                    ),
                    SignInTextField(
                      controller: firstnameController,
                      label: 'Prenom',
                      hintText: 'Prenom',
                      isWrong: _isSubmitted['firstname']! &&
                          !validators.firstnameValidator
                              .isValid(firstnameController.text),
                      errorText: validators.invalidEmptyFirstnameErrorText,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChange: _updateState,
                      onEditingComplete: () => _onEditingComplete(
                          'firstname',
                          validators.firstnameValidator
                              .isValid(firstnameController.text)),
                    ),
                    SignInTextField(
                      controller: phoneNumberController,
                      label: 'Téléphone',
                      hintText: 'Téléphone',
                      isWrong: _isSubmitted['phoneNumber']! &&
                          validators.phoneNumberValidator
                              .isValid(phoneNumberController.text)
                              .isNotEmpty,
                      errorText: validators.phoneNumberValidator
                          .isValid(phoneNumberController.text),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onChange: _updateState,
                      onEditingComplete: () => _onEditingComplete(
                          'phoneNumber',
                          validators.phoneNumberValidator
                              .isValid(phoneNumberController.text)
                              .isEmpty),
                    ),
                    SignInTextField(
                      controller: addressController,
                      label: 'Adresse',
                      hintText: 'Adresse',
                      isWrong: _isSubmitted['address']! &&
                          !validators.addressValidator
                              .isValid(addressController.text),
                      errorText: validators.invalidEmptyAddressErrorText,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      onChange: _updateState,
                      onEditingComplete: () => _onEditingComplete(
                          'address',
                          validators.addressValidator
                              .isValid(addressController.text)),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Suivant',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: _formIsValid ? _submit : null,
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
          const SizedBox(
            width: 16,
          ),
          const Text(
            'Remplissez votre profil',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
      const SizedBox(height: 32),
      const SizedBox(
        width: 350,
        child: Text(
          "Ces données seront affichées dans le profil de votre compte pour des raisons de sécurité",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    ];
  }
  
}
  