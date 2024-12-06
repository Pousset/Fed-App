import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../foundation/constants.dart';

class SelectMenuTypeCreation extends StatefulWidget {
  const SelectMenuTypeCreation({Key? key}) : super(key: key);

  @override
  State<SelectMenuTypeCreation> createState() => _SelectMenuTypeCreationState();
}

class _SelectMenuTypeCreationState extends State<SelectMenuTypeCreation> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(screenSize.height, 668),
          child: Padding(
              padding:
                  EdgeInsets.fromLTRB(20, screenSize.height * 0.09, 20, 20),
              child: Column(
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
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(80),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromRGBO(246, 136, 93, 1),
                        )),
                    child: Text(
                      'Remplir le menu manuellement',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "OU",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.all(80),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromRGBO(246, 136, 93, 1),
                        )),
                    child: Text(
                      'Remplir le menu manuellement',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomFlatButton(
                    width: screenSize.width - 48,
                    text: "Suivant",
                    color: Colors.white,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
