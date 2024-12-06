import 'dart:math';

import 'package:fedhubs_pro/screens/settings/externes_services_just_eat.dart';
import 'package:fedhubs_pro/screens/settings/externes_services_uber_eat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/number_symbols_data.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';

class TypesLivraison extends StatefulWidget {
  const TypesLivraison({Key? key}) : super(key: key);

  @override
  State<TypesLivraison> createState() => _TypesLivraisonState();
}

class _TypesLivraisonState extends State<TypesLivraison> {
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
            height: max(screenSize.height, 960),
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
                        'Services externes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                    child: Text(
                      "Si votre commerce propose un type de livraison,"
                          "vous pouvez le mettre sur votre profil.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                    child: Text(
                      'Il suffit de remplir les informations en cliquant sur “Ajouter un mode de livraison”',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                    child: Text(
                      "Vous pouvez consulter la liste ci-dessous des éléments déja ajoutés a votre profil.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                     child: Row(
                     children: [
                       Text(
                         "Vos modes de livraison :",
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
                  customWidget(),

                ],
              ),
            ),
          )),
    );
  }














  Widget customWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Première ligne
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UberEat()),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/icon/ubereat.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                Text(
                  "Uber Eats",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),

                ElevatedButton(
                  onPressed: () {
                    // Action à effectuer lorsqu'on appuie sur le bouton
                  },
                  child: Text(
                    'Actif',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(color: Colors.orange, width: 1),
                    fixedSize: Size(90, 40), // Ajustez la largeur et la hauteur du bouton ici
                    primary: Colors.white,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.orange),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Divider au-dessous de la Row
          Container(
            height: 1,
            color: Colors.orange[200],
            margin: EdgeInsets.only(left: 64), // Pour décaler le divider vers la gauche jusqu'au début du texte
          ),

          // Deuxième ligne
          const SizedBox(height: 30),
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JustEat()),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/icon/justeat.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                Text(
                  "Just Eat",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                Spacer(),
                Icon(Icons.arrow_forward_ios, color: Colors.orange),
              ],
            ),
          ),
          SizedBox(height: 30),

          // Divider au-dessous de la Row
          Container(
            height: 1,
            color: Colors.orange[200],
            margin: EdgeInsets.only(left: 64), // Pour décaler le divider vers la gauche jusqu'au début du texte
          ),
          // Troisième ligne
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/icon/delivero.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 22),
              Text(
                "Deliveroo",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.orange),
            ],
          ),
          SizedBox(height: 30),

          // Divider au-dessous de la Row
          Container(
            height: 1,
            color: Colors.orange[200],
            margin: EdgeInsets.only(left: 64), // Pour décaler le divider vers la gauche jusqu'au début du texte
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/icon/autre.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 22),
              Text(
                "Autre",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.orange),
            ],
          ),

        ],
      ),

    );
  }






}
