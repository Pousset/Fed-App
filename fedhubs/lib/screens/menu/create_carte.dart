import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';
import 'create_section.dart';
import 'lien_carte.dart';

class CreateCarte extends StatefulWidget {
  final List<String> sectionNames; // Ajoutez le paramètre ici

  const CreateCarte({
    Key? key,
    required this.sectionNames, // Assurez-vous d'ajouter le paramètre ici
  }) : super(key: key);
  @override
  State<CreateCarte> createState() => _CreateCarteState();
}

class _CreateCarteState extends State<CreateCarte> {
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
          padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
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
                      width: 18,
                    ),
                    Text(
                      'Création de carte',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Text(
                    'Comment souhaitez-vous',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 88),
                child: Row(
                  children: [
                    Text(
                      'créer votre carte?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Ajustez les marges si nécessaire
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrez l'icône horizontalement
                  children: [
                    Container(
                      width: 120, // Ajustez la largeur du conteneur selon vos besoins
                      height: 120, // Ajustez la hauteur du conteneur selon vos besoins
                      child: Icon(
                        Icons.link,
                        size: 120, // Ajustez la taille de l'icône selon vos besoins
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: "Ajoutez directement ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "un lien vers votre menu",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),  // Ajustez l'espacement vertical si nécessaire
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text("pour montrer aux clients les plats ",
                        style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),),
                    ),
                    SizedBox(height: 8),  // Ajustez l'espacement vertical si nécessaire
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Text("et boissons que vous proposer ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),  // Ajustez l'espacement vertical si nécessaire

              CustomFlatButton(
                width: screenSize.width - 48,
                text: 'Insérez des liens de vos cartes',
                color: Theme.of(context).secondaryHeaderColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LienCarte(
                        sectionNames: widget.sectionNames,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 32),  // Ajustez l'espacement vertical si nécessaire
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Ajustez les marges si nécessaire
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrez l'icône horizontalement
                  children: [
                    Container(
                      width: 120, // Ajustez la largeur du conteneur selon vos besoins
                      height: 120, // Ajustez la hauteur du conteneur selon vos besoins
                      child: Icon(
                        Icons.edit_outlined,
                        size: 120, // Ajustez la taille de l'icône selon vos besoins
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(

                              children: [
                                TextSpan(
                                  text: "Créer votre carte ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                TextSpan(
                                  text: "manuellement ",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                                TextSpan(
                                  text: "et ajoutez",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),  // Ajustez l'espacement vertical si nécessaire
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text("autant de plats et de formule que",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),),
                    ),
                    SizedBox(height: 8),  // Ajustez l'espacement vertical si nécessaire
                    Padding(
                      padding: const EdgeInsets.only(left: 36),
                      child: Text("vous le souhaitez, de manière",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 90.0),
                      child: RichText(
                        text: TextSpan(

                          children: [
                            TextSpan(
                              text: "simple et claire ",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.orange,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),  // Ajustez l'espacement vertical si nécessaire

              CustomFlatButton(
                width: screenSize.width - 48,
                text: 'Créer votre carte manuellement',
                color: Theme.of(context).secondaryHeaderColor,
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateSection(
                        sectionNames: widget.sectionNames,
                      ),
                    ),
                  );
                   },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
