import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class PressePublicationPage1 extends StatefulWidget {
  const PressePublicationPage1({Key? key}) : super(key: key);

  @override
  State<PressePublicationPage1> createState() => _PressePublicationPage1State();
}

class _PressePublicationPage1State extends State<PressePublicationPage1> {
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
                    'Publication presse',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Ici vous retrouverez toutes les publications de presse que vous avez ajouté.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              _PressPublication(),
              const SizedBox(
                height: 30,
              ),
              _PressPublication(),
              const SizedBox(
                height: 30,
              ),
              _PressPublication(),
              const SizedBox(
                height: 100,
              ),
              const Expanded(child: SizedBox()),
              CustomFlatButton(
                width: realScreenSize.width,
                text: "Ajouter une publication",
                color: Colors.black,
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget _PressPublication() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          elevation: (15),
          shadowColor: Colors.black.withOpacity(0.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://imgr.cineserie.com/2022/12/301333.jpg?imgeng=/f_jpg/cmpr_0/w_212/h_318/m_cropbox&ver=1",
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "“Le meilleur burger de Paris ! Et en plus Vegan”",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          left: 320,
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(246, 136, 93, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: const Text("Publié"),
          ),
        ),
      ],
    );
  }
}
