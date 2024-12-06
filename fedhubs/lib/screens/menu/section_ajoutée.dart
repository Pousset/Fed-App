import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';
import 'lien_carte.dart';

class SectionAjoutee extends StatefulWidget {
  final String nomCarte;
  final String lienSection;
  final List<String> sectionNames;
  final int nombreDeCartesEnregistrees; // Ajoutez ce paramètre

  SectionAjoutee({
    required this.nomCarte,
    required this.lienSection,
    required this.sectionNames,
    required this.nombreDeCartesEnregistrees,
  });

  @override
  State<SectionAjoutee> createState() => _SectionAjouteeState();
}

class _SectionAjouteeState extends State<SectionAjoutee> {


  @override
  Widget build(BuildContext context) {
    int selectedButtonIndex = -1;

    print('liste des nom des cartes: ${widget.sectionNames}');
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
    Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Column(
        children: [

       Expanded(


        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Ajustement de l'alignement
              children: [
                const SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ajustement de l'alignement
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
                      SizedBox(width: 4,),
                      Text(
                        'Votre carte',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                            },
                          style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.black, width: 1),
                          primary: Colors.white,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.edit, color: Colors.black),
                            SizedBox(width: 4),
                            Text(
                              'Modifier le section',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 24),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 8,
                    children: [
                      for (int i = 0; i < widget.nombreDeCartesEnregistrees; i++)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButtonIndex = selectedButtonIndex == i ? -1 : i; // Toggle la sélection du bouton
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(
                              color: selectedButtonIndex == i ? Colors.orange : Colors.grey,
                              width: 1,
                            ),
                            primary: selectedButtonIndex == i ? Colors.orange : Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Text(
                              widget.sectionNames[i],
                              style: TextStyle(
                                fontSize: 18,
                                color: selectedButtonIndex == i ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Gérer le bouton ici
                        },
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(color: Colors.grey.shade400, width: 1),
                          primary: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle_outline, color: Colors.grey.shade400),
                              SizedBox(width: 4),
                              Text(
                                "Ajouter",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  children: [
                    Text("Menu/ La Taverne De ZHAO",style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.w900,fontSize: 23,
                    ),)
                  ],
                ),
              ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 110.0),
                  child: Row(
                    children: [
                      Text("Liste allergènes",style: TextStyle(
                        color: Colors.grey.shade600,fontWeight: FontWeight.w700,fontSize: 14,
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "MO",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "RIZ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "DESSERT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "THE ET BOISSON",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 16), // Espacement vertical entre les groupes de conteneurs
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "MO",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "LIANG PI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "ENTREE CHAUDE ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 16), // Espacement vertical entre les groupes de conteneurs
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "MO",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "ENTREE FROIDE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 4,),
                        Container(
                          padding: EdgeInsets.all(12), // Ajoutez du padding pour l'apparence
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Text(
                            "POT EN TERRE ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                    // Ajoutez d'autres groupes de conteneurs si nécessaire
                  ],
                ),
                SizedBox(height: 14,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2),
                 child: Container(
                   width: 450,
                   height: 240,
                   decoration: BoxDecoration(
                     color: Colors.red.shade900,
                     borderRadius: BorderRadius.circular(2),
                   ),
                   child: Center(
                     child: Text(
                       "ENTREE FROIDE",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 23,
                         fontWeight: FontWeight.w800,
                       ),
                     ),
                   ),
                 ),
                ),
                SizedBox(height: 14,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    width: 450,
                    height: 240,
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(2),
                    ),

                      child: Image.asset(
                        "assets/pizza.jpeg",
                        fit: BoxFit.cover, // Ajustez l'image pour couvrir le contenu du conteneur
                      ),

                  ),
                ),

                SizedBox(height: 8,),

                CustomFlatButton(
                    width: screenSize.width - 48,
                    text: 'Modifier le lien',
                    color: Theme.of(context).secondaryHeaderColor,
                    onPressed: (){ Navigator.pop(context);}

                ),

                // Autres widgets...
              ],
            ),
          ),

        ),
      ),


        ],
      ),
    );


  }
}
