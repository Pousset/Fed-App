import 'dart:io';
import 'dart:math';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/models/user.dart';
import 'package:fedhubs_pro/screens/beginner/last_step_page.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/geolocator_service.dart';
import 'package:fedhubs_pro/services/local/global_state.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


enum DownloadYourProfilePictureState {
  first,
  update,
}

class DownloadYourProfilePicture extends StatefulWidget {
  const DownloadYourProfilePicture({Key? key,required,required this.state})
      : super(key: key);

  static Future<List<File?>?> push(BuildContext context,
      {required DownloadYourProfilePictureState state}) async {
    return await Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(
      builder: (context) => DownloadYourProfilePicture(state: state),
      fullscreenDialog: true,
    ));
  }

  final DownloadYourProfilePictureState state;

  @override
  State<DownloadYourProfilePicture> createState() =>
      _DownloadYourProfilePictureState();
}

class _DownloadYourProfilePictureState
    extends State<DownloadYourProfilePicture> {
  int step = 0;

  LoginError? loginError;

  File? _croppedPicture;
  File? _profilePicture;

  void _submit() async {
    final signUpForm = Provider.of<SignUpForm>(context, listen: false);
    final service = Provider.of<Auth>(context, listen: false);
    late final User? user;

    signUpForm.update(profilePicture: _croppedPicture);

    if (signUpForm.loginMethod == "1") {
      LastStepPage.push(context);
    }
    else if(signUpForm.loginMethod == "2"){
      try {
        user = await service.signUpWithEmailAndPassword(signUpForm);
        setState(() => loginError = null);
      } on LoginError catch (e) {
        setState(() => loginError = e);
      }
      if (loginError == null) {
        if (kIsWeb && !await LocationService.checkPermission()) {
          //LastStepPage.push(context);
          ////LocationPermissionPage.push(context, LocationPageAccessMode.first);
        } else if (!kIsWeb && !await GeolocatorService.checkPermission()) {
          //LocationPermissionPage.push(context, LocationPageAccessMode.first);
        } else if (user != null) {
          //LastStepPage.push(context);
        }
      } else {
        final globalState = Provider.of<GlobalState>(context, listen: false);
        globalState.loginError = loginError;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    } else if (signUpForm.loginMethod == "3") {
      try {
        if (signUpForm.password != null) {
          final accessToken = await FacebookAuth.i.accessToken;
          if (accessToken != null) {
            final userData = await FacebookAuth.i.getUserData();
            final user =
                await service.signUpWithService(userData['id'], signUpForm);
            if (kIsWeb && !await LocationService.checkPermission()) {
              // LocationPermissionPage.push(
              //     context, LocationPageAccessMode.first);
            } else if (!kIsWeb && !await GeolocatorService.checkPermission()) {
              // LocationPermissionPage.push(
              //     context, LocationPageAccessMode.first);
            } else if (user != null) {
              //LastStepPage.push(context);
            }
          } else {
            throw const LoginError(
                title: 'Expired Token',
                message: 'Votre token facebook à expiré');
          }
        }
      } on LoginError {
        final globalState = Provider.of<GlobalState>(context, listen: false);
        globalState.loginError = loginError;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    }
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      _profilePicture = imageTemp;
      await editPicture();
      if (widget.state == DownloadYourProfilePictureState.update) {
        Navigator.of(context).pop([_profilePicture, _croppedPicture]);
      }
    } on PlatformException {
      rethrow;
    }
  }

  Future<void> editPicture() async {
    final _croppedFile = await ImageCropper().cropImage(
      sourcePath: _profilePicture!.path,
      
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Redimensionner',
          toolbarColor: Theme.of(context).secondaryHeaderColor,
          toolbarWidgetColor: Colors.white,
          statusBarColor: Theme.of(context).secondaryHeaderColor,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (_croppedFile != null) {
      _croppedPicture = File(_croppedFile.path);
    }
    if (widget.state == DownloadYourProfilePictureState.first) {
      setState(() {});
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    const SizedBox(height: 32),
                    if (_croppedPicture == null) ...[
                      _buildButton(
                        screenSize,
                        context,
                        text: 'Prendre une photo',
                        icon: Icons.photo_camera_rounded,
                        onPressed: () => _pickImage(ImageSource.camera),
                        iconColor: Colors.white, // Couleur de l'icône en blanc
                      ),

                      const SizedBox(height: 32),
                      _buildButton(
                        screenSize,
                        context,
                        text: 'Télécharger de la galerie',
                        icon: Icons.photo_rounded,
                        onPressed: () => _pickImage(ImageSource.gallery),
                        iconColor: Colors.white, // Définissez la couleur de l'icône sur orange
                      ),
                    ],


                    if (_croppedPicture != null) _buildProfilePicture(context),
                    const Expanded(flex: 1, child: SizedBox()),
                    if (_croppedPicture != null)
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

  Widget _buildProfilePicture(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        child: Stack(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(195)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x24000000),
                      offset: Offset(0, 4),
                      blurRadius: 35,
                    )
                  ]),
              child: Image.file(
                _croppedPicture!,
                height: 195,
                width: 195,
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Stack(children: [
                Icon(
                  Icons.circle,
                  color: Colors.orange, // Couleur du cercle en orange
                  size: 40,
                ),
                const Positioned(
                  left: 9,
                  bottom: 9,
                  child: Icon(
                    Icons.edit,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ],
        ),
        onTap: editPicture,
      ),
    );
  }

  Widget _buildButton(Size screenSize, BuildContext context,
      {required String text,
        required IconData icon,
        required VoidCallback onPressed,
        required Color iconColor}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 35,
            blurStyle: BlurStyle.outer,
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(120.0)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: screenSize.width - 64,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orange
                      .withOpacity(0.5), // Couleur du cercle avec opacité
                  child: Icon(
                    icon,
                    size: 18,
                    color: Colors.white, // Couleur de l'icône en blanc
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(120.0)),
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
            onTap: _croppedPicture != null
                ? () => setState(() => _croppedPicture = null)
                : () => Navigator.of(context).pop(),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            widget.state == DownloadYourProfilePictureState.first
                ? 'Téléchargez votre photo'
                : 'Changez votre photo',
            textAlign: TextAlign.center,
            style: const TextStyle(
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
          "Ces données seront affichées dans le profil de"
          " votre compte pour des raisons de sécurité",
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
