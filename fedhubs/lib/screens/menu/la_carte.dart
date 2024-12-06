import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';
import 'ModifierSection.dart';
import 'article_data.dart';
import 'modifier_article.dart';
import 'nouvelle_article.dart';
import 'nouvelle_section_manuellement.dart';

class Carte extends StatefulWidget {
  final String nomCarte;
  final String lienSection;
  final List<String> sectionNames;
  final int nombreDeCartesEnregistrees;
  final List<ArticleData> addedArticles; // Add this line


  Carte({
    required this.nomCarte,
    required this.lienSection,
    required this.sectionNames,
    required this.nombreDeCartesEnregistrees,
    required this.addedArticles, // Add this line

  });

  @override
  State<Carte> createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  int selectedButtonIndex = -1;

  void _onButtonPressed(int index) {
    setState(() {
      selectedButtonIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {

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
                            'La carte ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ModifierSection(
                                    sectionNames: widget.sectionNames, // Passez la liste ici
                                    addedArticles: widget.addedArticles,
                                  ),
                                ),
                              );                            },
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
                      child:Wrap(
                        spacing: 8,
                        children: [
                          for (int i = 0; i < widget.sectionNames.length; i++)
                            ElevatedButton(
                              onPressed: () => _onButtonPressed(i),
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                side: BorderSide(
                                  color: selectedButtonIndex == i ? Colors.orange : Colors.grey,
                                  width: 1,
                                ),
                                primary: selectedButtonIndex == i ? Colors.red.shade50 : Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Text(
                                  widget.sectionNames[i],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: selectedButtonIndex == i ? Colors.orange : Colors.black,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () async {
                              // Ajouter une nouvelle section vide à la liste
                              //   widget.sectionNames.add('');

                              // Naviguer vers l'écran SectionAjouteeMenu
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SectioneManuelle(
                                    sectionNames: widget.sectionNames, // Passez la liste ici
                                    addedArticles: [],
                                  ),
                                ),
                              );

                              // Ici, vous pouvez rafraîchir l'écran ou effectuer d'autres actions si nécessaire
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
                    SizedBox(height: 40),
                    Text("Nos Burgers",style:TextStyle(
                        color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height: 24),

                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.addedArticles.length,
                      itemBuilder: (context, index) {
                        var article = widget.addedArticles[index];
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${article.name}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 60),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ModifierArticle(
                                              sectionNames: widget.sectionNames,
                                              articleData: article,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.mode_edit_outlined, size: 40),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      '${article.price} €',
                                      style: TextStyle(color: Colors.orange,fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 240,
                                  child: Text(
                                    '${article.description}',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 12,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Alignement à gauche
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0), // Ajustez le rayon selon vos besoins
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: SizedBox(
                                        width: 94,
                                        height: 160,
                                        child: article.selectedImage != null
                                            ? Image.file(
                                          article.selectedImage!,
                                          fit: BoxFit.cover,
                                        )
                                            : Container(), // Ou tout autre widget vide si aucune image n'est sélectionnée
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        );
                      },
                    ),




                    SizedBox(height: 600),
                    CustomFlatButton(
                      width: screenSize.width - 48,
                      text: 'Ajouter un produit',
                      color: Theme.of(context).secondaryHeaderColor,
                      onPressed: () async {
                        // Ajouter une nouvelle section vide à la liste
                        // widget.sectionNames.add('');

                        // Naviguer vers l'écran NouvelleArticle en passant la liste de noms de section
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NouvelleArticle(
                              sectionNames: widget.sectionNames,
                              addedArticles: widget.addedArticles,
                            ),
                          ),
                        );


                        // Ici, vous pouvez rafraîchir l'écran ou effectuer d'autres actions si nécessaire
                      },
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
