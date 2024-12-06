import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class IconGalleryPage extends StatefulWidget {
  IconGalleryPage({Key? key}) : super(key: key);

  @override
  State<IconGalleryPage> createState() => _IconGalleryPageState();
}

class _IconGalleryPageState extends State<IconGalleryPage> {
  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      "Galeries d'icônes",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Sélectionnez une icone parmis la liste qui décrit aux mieux votre événement ou promotions.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 10,
                    top: 20,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(40))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recherche...',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Icon(
                        Icons.search,
                        size: 25,
                      )
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                CustomFlatButton(
                    width: screenSize.width - 48,
                    text: "Confirmer",
                    color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
