import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../foundation/constants.dart';

class MenuLinksPage extends StatefulWidget {
  const MenuLinksPage({Key? key}) : super(key: key);

  @override
  State<MenuLinksPage> createState() => _MenuLinksPageState();
}

class _MenuLinksPageState extends State<MenuLinksPage> {
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
            padding: EdgeInsets.fromLTRB(20, screenSize.height * 0.09, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Cartes Ajoutées",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Retrouver ici les cartes que vous avez déjà ajouté.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                _linksTile("Boisson", "fedhubs.org/cartedesboissons.pdf"),
                const SizedBox(
                  height: 35,
                ),
                _linksTile("Boisson", "fedhubs.org/cartedesboissons.pdf"),
                const SizedBox(
                  height: 35,
                ),
                _linksTile("Boisson", "fedhubs.org/cartedesboissons.pdf"),
                const SizedBox(
                  height: 35,
                ),
                _linksTile("Boisson", "fedhubs.org/cartedesboissons.pdf"),
                const Expanded(child: SizedBox()),
                CustomFlatButton(
                    width: screenSize.width - 48,
                    text: "+ Ajouter au menu",
                    color: Colors.white)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _linksTile(title, link) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Boisson",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "fedhubs.org/cartedesboissons.pdf",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const Icon(
          Icons.edit_outlined,
        )
      ],
    );
  }
}
