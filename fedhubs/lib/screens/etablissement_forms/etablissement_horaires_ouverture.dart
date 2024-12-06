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



class EtablissementHorairesOuverture extends StatefulWidget {
 
  const EtablissementHorairesOuverture({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const EtablissementHorairesOuverture(),
      fullscreenDialog: true,
    ));
  }

  @override
  State<EtablissementHorairesOuverture> createState() => _EtablissementHorairesOuvertureState();
  }

class _EtablissementHorairesOuvertureState extends State<EtablissementHorairesOuverture> {
  
List<String> daysOfWeek = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];
  List<TextEditingController> startTimeControllers = [];
  List<TextEditingController> endTimeControllers = [];
  List<bool> light = 
    [true, true, true,true,true,true, true];

  @override
  void initState() {
    super.initState();
    // Initialiser les contrôleurs de texte pour chaque jour de la semaine
    for (int i = 0; i < daysOfWeek.length; i++) {
      startTimeControllers.add(TextEditingController());
      endTimeControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Disposer les contrôleurs de texte
    for (var controller in startTimeControllers) {
      controller.dispose();
    }
    for (var controller in endTimeControllers) {
      controller.dispose();
    }
    super.dispose();
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
            height: max(screenSize.height, 900),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildHeader(context, screenSize),
                    const SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Lundi',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                       Switch(
                            value: light[0],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[0] = value;
                              });
                            },
                          ),
                              ],
                 ),
                  
                    Row(
                      children: [
                        Container(
                          width: 140,
                          child: TextFormField( 
                            controller: startTimeControllers[0],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 140,
                          child: TextFormField(
                            controller: endTimeControllers[0],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,

                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                        const SizedBox(width: 10),

                        Container(
                          width: 40,
                          child: TextFormField(
                            controller: endTimeControllers[0],
                            onTap: () => setState(() {}), // You might have a reason for this, but it doesn't seem to do anything here.
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                              labelText: "",
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                              ),
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.add, // Replace with the icon you want to use
                                color: Colors.grey, // You can customize the icon color here
                              ),
                              prefixIconConstraints: const BoxConstraints(minWidth: 56),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                              ),
                              filled: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Mardi',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        Switch(
                            value: light[1],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[1] = value;
                              });
                            },
                          )
                              ],
                 ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: startTimeControllers[1],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: endTimeControllers[1],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                      ],
                    ),
                    
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Mercredi',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                       Switch(
                            value: light[2],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[2] = value;
                              });
                            },
                          ),
                              ],
                 ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: startTimeControllers[2],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: endTimeControllers[2],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                      ],
                    ),
                    
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Jeudi',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        Switch(
                            value: light[3],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[3] = value;
                              });
                            },
                          )
                              ],
                 ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: startTimeControllers[3],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: endTimeControllers[3],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                      ],
                    ),

                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Vendredi',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                       Switch(
                            value: light[4],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[4] = value;
                              });
                            },
                          ),
                              ],
                 ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: startTimeControllers[4],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: endTimeControllers[4],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                      ],
                    ),
                    
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Samedi',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),

                        Switch(
                            value: light[5],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[5] = value;
                              });
                            },
                          )
                              ],
                 ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: startTimeControllers[5],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: endTimeControllers[5],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                      ],
                    ),

                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                    Text(
                          'Dimanche',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                       Switch(
                            value: light[6],
                            activeColor: Colors.red,
                            onChanged: (bool value) {
                              setState(() {
                                light[6] = value;
                              });
                            },
                          ),
                              ],
                 ),
                  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: startTimeControllers[6],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Ouverture",
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
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 175,
                          child: TextFormField( 
                            controller: endTimeControllers[6],
                            onTap: () => setState(() {}),
                            style: const TextStyle(
                            fontSize: 14,
                            
                            fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        labelText: "Fermeture",
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
                        ),
                      ],
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
            'Horaires d’ouverture',
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
  


