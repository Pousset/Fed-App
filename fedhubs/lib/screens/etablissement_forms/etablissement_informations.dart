import 'dart:math';

import 'package:fedhubs_pro/models/login_error.dart';
import 'package:fedhubs_pro/models/post/sign_up/sign_up_form.dart';
import 'package:fedhubs_pro/screens/etablissement_forms/etablissement_location.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';



class EtablissementInformations extends StatefulWidget {
 
  const EtablissementInformations({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const EtablissementInformations(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<EtablissementInformations> createState() => _EtablissementInformationsState();
  }

class _EtablissementInformationsState extends State<EtablissementInformations> {
  

  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //Color? instagramIconColor = Colors.deepOrange[100]; // Couleur par défaut de l'icône Facebook
  String labelText = ''; // Texte du libellé par défaut
  double facebookImageOpacity = 0.6; // Opacité initiale de l'image Facebook
  double instagramImageOpacity = 0.6;
  double linkedinImageOpacity = 0.6; // Opacité initiale de l'image Facebook
  double snapchatImageOpacity = 0.6;
  double twitterImageOpacity = 0.6; // Opacité initiale de l'image Facebook
  double youtubeImageOpacity = 0.6;// Opacité initiale de l'image Instagram

  final FocusNode _phoneFocusNode = FocusNode();


  bool _isHintVisible = true;

  @override
  void initState() {
    super.initState();
    _phoneFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    phoneController.dispose();
    _phoneFocusNode.removeListener(_onFocusChanged);
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isHintVisible = !_phoneFocusNode.hasFocus && phoneController.text.isEmpty;
    });
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
            height: max(screenSize.height, 800),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildHeader(context, screenSize),
                    const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Informations',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.45),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                    TextFormField( 
                      controller: nameController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: "Nom de l’établissement",
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),
                    
                    const SizedBox(height: 10),
                    TextFormField( 
                      controller: specialityController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: "Spécialité",
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),
                     const SizedBox(height: 10),
                    TextFormField(
                        maxLines: null,
                        minLines: 1,
                        controller: descriptionController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: "Déscription de l’établissement",
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),
                    const SizedBox(height: 20),
                    Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Coordonnées',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.45),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                    TextFormField(
                        controller: phoneController,
                        onTap: () => setState(() {}),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                          labelText: "Phone",
                          labelStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                          ),
                          fillColor: Colors.white,
                          prefixIconConstraints: const BoxConstraints(minWidth: 56),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          filled: true,
                        )
                    ),
                    const SizedBox(height: 10),
                    TextFormField( 
                      controller: websiteController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: "Site Web",
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),
                     const SizedBox(height: 10),
                    TextFormField( 
                      controller: emailController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: "Email",
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child:    Row(

                        children: [
                          Container(
                            margin: EdgeInsets.all(12.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Réinitialiser les opacités de toutes les images
                                  instagramImageOpacity = 0.6;
                                  linkedinImageOpacity = 0.6;
                                  snapchatImageOpacity = 0.6;
                                  twitterImageOpacity = 0.6;
                                  youtubeImageOpacity = 0.6;
                                  // Mettre à jour l'opacité de l'image Facebook
                                  facebookImageOpacity = 1.0;
                                  labelText = 'Facebook'; // Mettre à jour le texte du libellé
                                });
                              },
                              child: Opacity(
                                opacity: facebookImageOpacity,
                                child: SvgPicture.asset(
                                  'assets/facebook.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Réinitialiser les opacités de toutes les images
                                  facebookImageOpacity = 0.6;
                                  linkedinImageOpacity = 0.6;
                                  snapchatImageOpacity = 0.6;
                                  twitterImageOpacity = 0.6;
                                  youtubeImageOpacity = 0.6;
                                  // Mettre à jour l'opacité de l'image Instagram
                                  instagramImageOpacity = 1.0;
                                  labelText = 'Instagram'; // Mettre à jour le texte du libellé
                                });
                              },
                              child: Opacity(
                                opacity: instagramImageOpacity,
                                child: SvgPicture.asset(
                                  'assets/instagram.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Réinitialiser les couleurs de tous les icônes
                                  facebookImageOpacity = 0.6;
                                  instagramImageOpacity = 0.6;
                                  snapchatImageOpacity = 0.6;
                                  twitterImageOpacity = 0.6;
                                  youtubeImageOpacity = 0.6;
                                 // linkedinIconColor
                                  linkedinImageOpacity = 1.0;

                                  labelText = 'LinkedIn'; // Mettre à jour le texte du libellé
                                });
                              },
                              child: Opacity(
                                opacity: linkedinImageOpacity,
                                child: SvgPicture.asset(
                                  'assets/linkedin.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Réinitialiser les couleurs de tous les icônes
                                  facebookImageOpacity = 0.6;
                                  instagramImageOpacity = 0.6;
                                  twitterImageOpacity = 0.6;
                                  youtubeImageOpacity = 0.6;
                                  linkedinImageOpacity = 0.6;
                                 //snapchatIconCoolr
                                  snapchatImageOpacity = 1.0;

                                  labelText = 'Snapchat'; // Mettre à jour le texte du libellé
                                });
                              },
                              child: Opacity(
                                opacity: snapchatImageOpacity,
                                child: SvgPicture.asset(
                                  'assets/snapchat.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Réinitialiser les couleurs de tous les icônes
                                  facebookImageOpacity = 0.6;
                                  instagramImageOpacity = 0.6;
                                  youtubeImageOpacity = 0.6;
                                  linkedinImageOpacity = 0.6;
                                  snapchatImageOpacity = 0.6;
                                  //snapchatIconCoolr
                                  twitterImageOpacity = 1.0;

                                  labelText = 'Twitter'; // Mettre à jour le texte du libellé
                                });
                              },
                              child: Opacity(
                                opacity: twitterImageOpacity,
                                child: SvgPicture.asset(
                                  'assets/twitter.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(12.5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Réinitialiser les couleurs de tous les icônes
                                  facebookImageOpacity = 0.6;
                                  instagramImageOpacity = 0.6;
                                  twitterImageOpacity = 0.6;
                                  linkedinImageOpacity = 0.6;
                                  snapchatImageOpacity = 0.6;
                                  //snapchatIconCoolr
                                  youtubeImageOpacity = 1.0;

                                  labelText = 'Youtube'; // Mettre à jour le texte du libellé
                                });
                              },
                              child: Opacity(
                                opacity: youtubeImageOpacity,
                                child: SvgPicture.asset(
                                  'assets/youtube.svg',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                    const SizedBox(height: 10),
                    TextFormField( 
                      controller: facebookController,
                      onTap: () => setState(() {}),
                      style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                  labelText: labelText,
                                  labelStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                  ),
                                  fillColor: Colors.white,
                                  prefixIconConstraints: const BoxConstraints(minWidth: 56),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                                ),
                                filled: true,
                                )
                                ),
            

                    const Expanded(flex: 1, child: SizedBox()),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Suivant',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () => LocationPage.push(context, LocationPageAccessMode.first)
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
            'Créer un nouvel établissement',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ];
  }

}


