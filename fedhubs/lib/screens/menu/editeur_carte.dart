import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class EditeurCarte extends StatefulWidget {
  const EditeurCarte({Key? key}) : super(key: key);

  @override
  State<EditeurCarte> createState() => _EditeurCarteState();
}

class _EditeurCarteState extends State<EditeurCarte> {
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
                      'Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Action à effectuer lors du clic sur le bouton

                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.grey, width: 1),
                        primary: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_circle_outline, color: Colors.grey.shade400),
                          SizedBox(width: 8),
                          Text(
                            'Ajouter une section',
                            style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),  // Ajustez l'espacement vertical si nécessaire
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), // Ajustez les marges si nécessaire
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrez l'icône horizontalement
                  children: [
                    Container(
                      width: 120, // Ajustez la largeur du conteneur selon vos besoins
                      height: 140, // Ajustez la hauteur du conteneur selon vos besoins
                      child: Icon(
                        Icons.edit_outlined,
                        size: 120, // Ajustez la taille de l'icône selon vos besoins
                        color: Colors.orange.shade100,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),  // Ajustez l'espacement vertical si nécessaire
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text("Votre carte est vide commencé a",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),),
                    ),
                    SizedBox(height: 8),  // Ajustez l'espacement vertical si nécessaire
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
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
                                    text: "la remplir en ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  TextSpan(
                                    text: "ajoutant une section.",
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 260,),
              TextButton(
                onPressed: (){},

                style: TextButton.styleFrom(
                  backgroundColor:  Colors.white,
                  //  primary:  Colors.white,
                  side: BorderSide(color: Colors.black87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(screenSize.width - 48, 0),
                  padding: EdgeInsets.all(12.0),
                ),
                child: Text('Ajouter un produit' ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
