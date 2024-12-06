import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_white_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../foundation/constants.dart';

class MenuAddLinkSectionPage extends StatefulWidget {
  const MenuAddLinkSectionPage({Key? key}) : super(key: key);

  @override
  State<MenuAddLinkSectionPage> createState() => _MenuAddLinkSectionPageState();
}

class _MenuAddLinkSectionPageState extends State<MenuAddLinkSectionPage> {
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, screenSize.height * 0.09, 20, 0),
          child: SizedBox(
            height: max(screenSize.height, 668),
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
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Lien vers le menu",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Ajoutez directement un lien vers votre menu pour montrer aux clients les plats et boissons que vous proposez. ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Section de menu",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Nom  de section',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      )),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 50,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Nom  de la carte',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      )),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: 'Lien',
                      hintStyle: TextStyle(
                        fontSize: 14,
                      )),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                ),
                const Expanded(child: SizedBox()),
                CustomWhiteFlatButton(
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
