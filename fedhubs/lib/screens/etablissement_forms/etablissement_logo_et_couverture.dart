import 'dart:io';
import 'dart:math';


import 'package:fedhubs_pro/screens/etablissement_forms/etablissement_horaires_ouverture.dart';
import 'package:fedhubs_pro/screens/etablissement_forms/etablissement_location.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class LogoANDCouverturePage extends StatefulWidget {
 
  const LogoANDCouverturePage({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const LogoANDCouverturePage(),
      fullscreenDialog: true,
    ));
  }
  

  @override
  State<LogoANDCouverturePage> createState() => _LogoANDCouverturePageState();
  }

class _LogoANDCouverturePageState extends State<LogoANDCouverturePage> {
  
  File? _logoPicture;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      _logoPicture = imageTemp;
    } on PlatformException {
      rethrow;
    }
  }
  

  @override
  Widget build(BuildContext context) {
    

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
            height: screenSize.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildHeader(context, screenSize),
                    const SizedBox(height: 32),
                    _buildButton(
                        screenSize,
                        context,
                        text: 'Sélectionner une photo',
                        icon: Icons.photo_camera_outlined,
                        onPressed: () => _pickImage(ImageSource.gallery),
                      ),
                    const Expanded(flex: 1, child: SizedBox()),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Suivant',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () => EtablissementHorairesOuverture.push(context)
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

      SizedBox(height: 25),
      Align(
                    alignment: Alignment.centerLeft,
                      child: GestureDetector(
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
                      onTap: () => Navigator.of(context).pop(),),
                    ),
      SizedBox(height: 25),
      Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            'Photo de couverture & Logo',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
       Align(
          alignment: Alignment.topLeft,
          child: const Text(
                        'Présentez votre établissement aux utilisateurs avec un visuel attrayant.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
        ),

      
    ];
  }


  Widget _buildButton(Size screenSize, BuildContext context,
      {required String text,
      required IconData icon,
      required VoidCallback onPressed
      //
      }) {
    return Container(
      decoration: BoxDecoration(
         border: Border.all(
            color: Colors.grey,
            width: 0.5,  // Set the border width
         ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              //width: screenSize.width - 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Positioned(
                      left: 9,
                      bottom: 9,
                      child: Icon(
                        icon,
                        size: 22,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(
                    text,
                    style: const TextStyle(
                      color: Color.fromRGBO(247, 136, 93, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
        ),
    );
  }

  
}
  


