import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_white_flat_button.dart';
import 'package:fedhubs_pro/widgets/forms/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class CreateStampForm extends StatefulWidget {
  const CreateStampForm({Key? key}) : super(key: key);

  @override
  State<CreateStampForm> createState() => _CreateStampFormState();
}

class _CreateStampFormState extends State<CreateStampForm> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nomController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _offreController = TextEditingController();
    final TextEditingController _specialiteController = TextEditingController();
    final TextEditingController _urlController = TextEditingController();


    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(screenSize.height, 668),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Theme.of(context).primaryColorDark,
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
                        ],
                      ),
                      // onTap: isLoading ? null : () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Image.asset(
                     'assets/icon/Vector.png'
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Timbre',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Offrez à vos clients un produit au bout d’un certain nombre d’achat. ',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Création de la fidélité sur :",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Text(
                      "feed.fedhubs.biz",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color.fromRGBO(246, 136, 93, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.info_outline_rounded,
                      color: Color.fromRGBO(246, 136, 93, 1),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Création de la fidélité sur Fedhubs:",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 600,
                  height: 50,
                  child: TextFormField(
                      controller: _nomController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: "Nom du produit",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey

                        ),
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 56),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 600,
                  height: 50,
                  child: TextFormField(
                      controller: _descriptionController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: "Description du produit",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey

                        ),
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 56),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 600,
                  height: 50,
                  child: TextFormField(
                      controller: _offreController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: "Offre",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey

                        ),
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 56),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 600,
                  height: 50,
                  child: TextFormField(
                      controller: _specialiteController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: "Specialité de l'offre",
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey

                        ),
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 56),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                      )
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 600,
                  height: 50,
                  child: TextFormField(
                      controller: _urlController,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                      color: Colors.orange),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        labelText: "Lien vers l'offre",
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                            fontSize: 14,
                          color: Colors.blueGrey

                        ),
                        fillColor: Colors.white,
                        prefixIconConstraints: const BoxConstraints(minWidth: 56),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                      )
                  ),
                ),

                const Expanded(child: SizedBox()),
                CustomFlatButton(
                    width: screenSize.width - 48,
                    text: "Enregistrer",
                    color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
