import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class PressPublicationForm2 extends StatefulWidget {
  const PressPublicationForm2({Key? key}) : super(key: key);

  @override
  State<PressPublicationForm2> createState() => _PressPublicationForm2State();
}

class _PressPublicationForm2State extends State<PressPublicationForm2> {
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
          padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 10),
          child: SizedBox(
            height: max(screenSize.height, 668),
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
                  height: 40,
                ),
                _suggestPicture(),
                const SizedBox(
                  height: 50,
                ),
                _suggestText(),
                const Expanded(
                  child: SizedBox(),
                ),
                TextButton(
                  onPressed: () {

                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white, // Couleur de fond blanche
                    primary: Colors.black, // Couleur du texte en noir
                    side: BorderSide(color: Colors.black87 ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Bordure arrondie
                    ),// Couleur de la bordure en gris
                    minimumSize: Size(screenSize.width - 48, 0),
                    padding: EdgeInsets.all(12.0), // Espacement autour du texte// Ajuster la largeur
                  ),
                  child: Text('Modifier',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87
                  ),),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFlatButton(
                  width: screenSize.width - 48,
                  text: 'Enregistrer',
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    // _linkConfirmation();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _suggestPicture() {
    return Container(
      decoration: BoxDecoration(
         /* border: Border.all(
            width: 1,
            color: Theme.of(context).highlightColor,
          ),*/
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 50,
          right: 50,
          bottom: 20,
        ),
        child: Column(
          children: const [
            Text(
              'Photo sugéré',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://pbs.twimg.com/profile_images/1936734396/483468_10150669197413400_16800788399_9263423_2000468711_n_400x400.jpeg',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _suggestText() {
    return Container(

      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10,
          right: 30,
          bottom: 10,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Texte suggéré",
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12),
                  ),
                ),
              ],
            ),


            const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                  hintText: "“Le meilleur burger de Paris ! Et en plus ”",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Ajustez ces valeurs selon vos besoins
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
