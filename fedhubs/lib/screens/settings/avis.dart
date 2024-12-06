import 'dart:math';

import 'package:fedhubs_pro/screens/settings/spam_alerte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmore/readmore.dart';

import 'package:flutter/material.dart';

import '../etablissement_forms/etablissement_informations.dart';
import '../sign_in/login_page.dart';
import 'autre_alerte.dart';

class Avis extends StatefulWidget {
  const Avis({Key? key}) : super(key: key);

  @override
  State<Avis> createState() => _AvisState();
}

class _AvisState extends State<Avis> {
  int selectedButtonIndex = -1;
  List<bool> isButtonSelectedList = [false, false, false,false];
  bool showFullText = false;
  bool showReplyTextField = false;

  @override
  Widget build(BuildContext context) {
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
                      'Avis',
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
              _buildInfoEntreprise(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildInfoEntreprise() {

String content = 'hbjnbhvgcgffdxcvbnbnvbcb,b,vcbbn,;bvcxn,bvvbn,bvcnvbvcvhbhjgfdgfhjgfdsghjjbvcxv bbvcbcbbvn,bvcxcvbn,bvcxvbn,;bvcxn,bvcxcvhgcgvccvnj;hjgfdxfcghvbjknhgfdswfgfghvjklhgfdsfwfxcvbnhbvgfdsgvbxsgfdfvhjsgfdxhhjsgfsdrtjhjhghxvcgss';
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Text(
                  'Vegan-Burger',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              '22 rue Rambuteau, 75001 Paris',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Row(
              children: const [
                Text(
                  'Burger',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 6,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  '4,8',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  '(121 avis)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.black,
                  size: 6,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  '€€',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Text(
              'Avis de la presse et des internautes',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.3, vertical: 0.5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 200,
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Petit Futé',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '4.6/5',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '32 votes',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: 200,
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Restaurant ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '4.7/5',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '456 votes',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: 200,
                    height: 120,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0.1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Pages Jaunes',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.orange,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '4.6/5',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '344 votes',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Trier les avis',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isButtonSelectedList = [true, false, false,false];
                    });
                  },
                  child: Text('Les meilleurs'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(color: Colors.grey, width: 1) ,
                    primary: isButtonSelectedList[0] ? Colors.orange : Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isButtonSelectedList = [false, true, false,false];
                    });
                  },
                  child: Text('Les moins bons'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(color: Colors.grey, width: 1) ,
                    primary: isButtonSelectedList[1] ? Colors.orange : Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isButtonSelectedList = [false, false, true,false];
                    });
                  },
                  child: Text('Plus récent'),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: BorderSide(color: Colors.grey, width: 1) ,
                    primary: isButtonSelectedList[2] ? Colors.orange : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isButtonSelectedList = [false, false, false,true];
                  });
                },
                child: Text('Plus ancien'),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: BorderSide(color: Colors.grey, width: 1) ,
                  primary: isButtonSelectedList[3] ? Colors.orange : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
           // child: Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images.jpeg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amanda W',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '11/07/2023',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),

                    Row(
                      children: [
                        Text(
                          'Avis',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Image.asset(
                          'assets/icon-google.png',
                          width: 60,
                          height: 90,
                        ),
                      ],
                    ),


                ],
              ),

          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadMoreText(
                  content,
                  trimLines: 3,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "Plus",
                  trimExpandedText: "  Moins",
                  lessStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  moreStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                  style: TextStyle(
                    // Définir l'espacement entre les lignes ici
                    height: 2, // Augmentez cette valeur pour augmenter l'espacement
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8, // 80% de la largeur de l'écran
                                  height: 700, // Personnalisez la hauteur ici selon vos besoins
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Votre contenu d'alerte ici...
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10),
                                            child: Center(
                                              child: Text(
                                                "Signaler",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          InkWell(
                                            onTap: () {
                                              // Mettez ici la logique pour fermer l'alerte sans rien faire
                                              Navigator.of(context).pop();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Divider(
                                        color: Colors.orangeAccent,
                                        height: 1,
                                        thickness: 1,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Veuillez sélectionner une raison",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Veuillez indiquer la raison de votre signalement",
                                                softWrap: true, // Permet au texte de passer à la ligne si nécessaire
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      buildListItem("Spam", Colors.black, context),
                                      buildListItem("Discours haineux", Colors.black, context),
                                      buildListItem("Vente non autorisées", Colors.black, context),
                                      buildListItem("Fausses informations", Colors.black, context),
                                      buildListItem("Harcèlement", Colors.black, context),
                                      buildListItem("Violence", Colors.black, context),
                                      buildListItem("Autre chose", Colors.black, context),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          "Signaler",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          // Bascule de la variable booléenne pour afficher/masquer le TextField
                          showReplyTextField = !showReplyTextField;
                        });
                      },
                      child: Text(
                        "Répondre",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                if (showReplyTextField) ...[
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 100, // Hauteur du TextField de réponse
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10), // Bordure arrondie orange
                              border: Border.all(color: Colors.orange, width: 1), // Bordure orange
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextField(
                                // Propriétés supplémentaires pour le TextField de réponse
                                decoration: InputDecoration(
                                  hintText: "Votre réponse...",
                                  border: InputBorder.none, // Pas de bordure pour le TextField
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Espacement entre le TextField et l'image
                      InkWell(
                        onTap: () {
                          // Implémentez votre logique lorsque l'utilisateur clique sur l'image
                          setState(() {
                            showReplyTextField = false;
                          });
                        },
                        child: Image.asset(
                          'assets/icon/envoyer.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],



              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SingleChildScrollView(
            // child: Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images.jpeg',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Paul B',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '11/07/2023',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                Row(
                  children: [
                    Text(
                      'Avis',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Image.asset(
                      'assets/facebook.png',
                      width: 60,
                      height: 90,
                    ),
                  ],
                ),


              ],
            ),

          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReadMoreText(
                  content,
                  trimLines: 3,
                  textAlign: TextAlign.justify,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: "Plus",
                  trimExpandedText: "  Moins",
                  lessStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  moreStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                  style: TextStyle(
                    // Définir l'espacement entre les lignes ici
                    height: 2, // Augmentez cette valeur pour augmenter l'espacement
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: [
                InkWell(
                  child: Text("Signaler",style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]
                  ),),
                  onTap: (){
                  },
                ),
                const SizedBox(
                  width: 26,
                ),
                Text("Répondre",style:   TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                ),),



              ],
            ),
          ),



        ],
      ),

    );
  }
  Widget buildListItem(String text, Color textColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.1),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              switch (text) {
                case "Spam":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Spam()),
                  );
                  break;
                case "Discours haineux":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case "Vente non autorisées":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case "Fausses informations":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case "Harcèlement":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case "Violence":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  break;
                case "Autre chose":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Autre()),
                  );
                  break;

                default:
                // If the item doesn't match any specific case, do nothing.
                  break;
              }
            },
            child: ListTile(
              title: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: textColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Divider(
            color: Colors.black54,
            thickness: 1,
          ),
        ],
      ),
    );
  }


}
