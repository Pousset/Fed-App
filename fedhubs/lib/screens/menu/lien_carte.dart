import 'package:fedhubs_pro/screens/menu/section_ajout%C3%A9e.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../widgets/buttons/custom_flat_button.dart';
import 'nouvelle_section_manuellement.dart'; // Assurez-vous d'importer le package du ToggleSwitch

class LienCarte extends StatefulWidget {
  final List<String> sectionNames; // Ajoutez le paramètre ici

  const LienCarte({
    Key? key,
    required this.sectionNames, // Assurez-vous d'ajouter le paramètre ici
  }) : super(key: key);

  @override
  State<LienCarte> createState() => _LienCarteState();
}

class _LienCarteState extends State<LienCarte> {
  List<String> sectionNames = [];
  bool showMinimumSectionText = false; // Indique si le texte "(2 section minimum)" doit être affiché
  int sectionCount = 0; // Compteur de sections
  String sectionHeaderText = "Vos sections"; // Texte d'en-tête initial
  int _selectedIndex = 1; // État pour suivre la sélection du ToggleSwitch
  bool _showSectionFields = false;
  List<Widget> sectionFields = [];
  String nomCarte = '';
  String lienSection = '';
  int nombreDeCartesEnregistrees = 0;



  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
    Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    void _enregistrerSections() {
      // ... (votre code pour enregistrer les sections)
      sectionNames.add(nomCarte);

      // Mettez à jour la liste sectionNames avec les noms des cartes enregistrées
      // Mettez à jour le nombre de cartes enregistrées
      setState(() {
        nombreDeCartesEnregistrees = sectionNames.length;

      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SectionAjoutee(
            nomCarte: nomCarte,
            lienSection: lienSection,
            sectionNames: sectionNames,
            nombreDeCartesEnregistrees: nombreDeCartesEnregistrees,
          ),
        ),
      );
    }

    print('nombre: $nombreDeCartesEnregistrees');
    print('liiiiiaaste: $sectionNames');

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
                      'Lien de la carte',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2), // Ajoutez ici la bordure noire
                  borderRadius: BorderRadius.circular(30), // Ajustez le rayon de la bordure
                ),
                child: ToggleSwitch(
                  minWidth: 170.0,
                  cornerRadius: 20.0,
                  activeBgColors: [
                    [Colors.black!],
                    [Colors.black!],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: _selectedIndex,
                  totalSwitches: 2,
                  labels: ['Manuelle', 'Liens externes'],
                  radiusStyle: true,
                  onToggle: (index) {
                    if (index == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SectioneManuelle(
                            sectionNames: sectionNames, addedArticles: []),
                        ),
                      );
                    } else {
                      setState(() {
                        _selectedIndex = index!;
                      });
                    }
                  },
                ),
              ),


              SizedBox(height: 20), // Ajustez l'espacement vertical si nécessaire
              // Afficher le contenu en fonction de la sélection
              _selectedIndex == 0
                  ?  Text('Contenu pour Manuelle')

              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                    child: Wrap(
                      children: [
                        Text(
                          "Vous pouvez proposer plusieurs sections à votre carte afin de catégoriser vos différents plats et menus.",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          sectionHeaderText,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        if (showMinimumSectionText)
                          Text(
                            "(2 section minimum)",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),


                  // Afficher tous les groupes de TextFormField ajoutés
                  ...sectionFields,

                  SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Action à effectuer lors du clic sur le bouton
                            setState(() {
                              if (!_showSectionFields) {
                                // Ajouter deux nouveaux ensembles de TextFormField à la liste
                                sectionFields.addAll([
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          TextFormField(
                                            style: TextStyle(
                                                color: Colors.black, fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: "Entrez le nom de la carte ici..",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Ajoutez un border radius ici
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top: 26, left: 8, bottom: 22),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                nomCarte = value;
                                              });
                                            },
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 8,
                                            child: Text(
                                              "Nom de la section",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          TextFormField(
                                            style: TextStyle(
                                                color: Colors.black, fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: "Entrez le lien ici..",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Ajoutez un border radius ici
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top: 26, left: 8, bottom: 22),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                lienSection = value;
                                              });
                                            },
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 8,
                                            child: Text(
                                              "Lien vers la section",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4,),
                                      Row(
                                        children: [
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (sectionFields.length >= 1) {
                                                  sectionFields.removeRange(sectionFields.length - 1, sectionFields.length); // Supprimer les deux derniers champs de texte
                                                  sectionCount -= 1; // Décrémenter le nombre de sections
                                                  sectionHeaderText = "Vos sections ($sectionCount)"; // Mettre à jour le texte d'en-tête
                                                  if (sectionCount <= 2) {
                                                    showMinimumSectionText = true;
                                                  }
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_outline_sharp, color: Colors.orange),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Supprimer la section',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                        SizedBox(height: 20,),
                              Container(
                              height: 1,
                              color: Colors.orange,
                              ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          TextFormField(
                                            style: TextStyle(
                                                color: Colors.black, fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: "Entrez le nom de la carte ici..",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Ajoutez un border radius ici
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top: 26, left: 8, bottom: 22),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                nomCarte = value;
                                              });
                                            },
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 8,
                                            child: Text(
                                              "Nom de la section",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          TextFormField(
                                            style: TextStyle(
                                                color: Colors.black, fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: "Entrez le lien ici..",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Ajoutez un border radius ici
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top: 26, left: 8, bottom: 22),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                lienSection = value;
                                              });
                                            },
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 8,
                                            child: Text(
                                              "Lien vers la section",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4,),
                                      Row(
                                        children: [
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (sectionFields.length >= 1) {
                                                  sectionFields.removeRange(sectionFields.length - 1, sectionFields.length); // Supprimer les deux derniers champs de texte
                                                  sectionCount -= 1; // Décrémenter le nombre de sections
                                                  sectionHeaderText = "Vos sections ($sectionCount)"; // Mettre à jour le texte d'en-tête
                                                  if (sectionCount <= 2) {
                                                    showMinimumSectionText = true;
                                                  }
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_outline_sharp, color: Colors.orange),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Supprimer la section',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),



                                    ],

                                  ),

                                ]);
                                sectionNames.add(nomCarte);




                                if (!showMinimumSectionText) {
                                  showMinimumSectionText = true;
                                  sectionHeaderText = "Vos sections (2)"; // Mettre à jour le texte d'en-tête

                                }
                                sectionCount+=2; // Incrémenter le compteur de sections
                                sectionHeaderText = "Vos sections ($sectionCount)"; // Mettre à jour le texte d'en-tête


                              } else {
                                // Ajouter un seul ensemble de TextFormField à la liste
                                sectionFields.add(

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 1,
                                        color: Colors.orange,
                                        // margin: EdgeInsets.only(left: 64), // Pour décaler le divider vers la gauche jusqu'au début du texte
                                      ),
                                      SizedBox(height: 20,),

                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          TextFormField(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: "Entrez le nom de la carte ici..",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Ajoutez un border radius ici
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top: 26, left: 8, bottom: 22),

                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                nomCarte = value;
                                              });
                                            },
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 8,
                                            child: Text(
                                              "Nom de la section",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Stack(
                                        alignment: Alignment.centerLeft,
                                        children: [
                                          TextFormField(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: "Entrez le lien ici..",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                    8), // Ajoutez un border radius ici
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  top: 26, left: 8, bottom: 22),
                                            ),
                                          ),
                                          Positioned(
                                            top: 2,
                                            left: 8,
                                            child: Text(
                                              "Lien vers la section",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4,),
                                      Row(
                                        children: [
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (sectionFields.length >= 2) {
                                                  sectionFields.removeRange(sectionFields.length - 1, sectionFields.length); // Supprimer les deux derniers champs de texte
                                                  sectionCount -= 1; // Décrémenter le nombre de sections
                                                  sectionHeaderText = "Vos sections ($sectionCount)"; // Mettre à jour le texte d'en-tête
                                                  if (sectionCount <= 2) {
                                                    showMinimumSectionText = true;
                                                  }
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_outline_sharp, color: Colors.orange),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Supprimer la section',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),


                                      SizedBox(height: 20,),
                                      Container(
                                        height: 1,
                                        color: Colors.orange,
                                        // margin: EdgeInsets.only(left: 64), // Pour décaler le divider vers la gauche jusqu'au début du texte
                                      ),
                                    ],
                                  ),
                                );
                                sectionCount+=1; // Incrémenter le compteur de sections
                                sectionHeaderText = "Vos sections ($sectionCount)"; // Mettre à jour le texte d'en-tête
                                sectionNames.add(nomCarte);

                              }

                              // Bascule de la variable booléenne pour afficher/masquer le TextField
                              _showSectionFields = !_showSectionFields;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(color: Colors.black, width: 1),
                            primary: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_circle_outline, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Ajouter une section',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: 320,),
                  CustomFlatButton(
                    width: screenSize.width - 48,
                    text: 'Enregister',
                    color: Theme.of(context).secondaryHeaderColor,
                    onPressed: _enregistrerSections

    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
