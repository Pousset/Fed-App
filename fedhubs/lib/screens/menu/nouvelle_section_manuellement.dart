import 'package:fedhubs_pro/screens/menu/modifier_article.dart';
import 'package:fedhubs_pro/screens/menu/section_ajout%C3%A9e_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../foundation/constants.dart';
import 'article_data.dart';
import 'lien_carte.dart';

class SectioneManuelle extends StatefulWidget {
  final List<String> sectionNames;
  final List<ArticleData> addedArticles; // Add this line


  const SectioneManuelle({
    Key? key,
    required this.sectionNames,
    required this.addedArticles, // Add this line

  }) : super(key: key);

  @override
  State<SectioneManuelle> createState() => _SectioneManuelleState();
}

class _SectioneManuelleState extends State<SectioneManuelle> {

  String nomCarte = '';
  String lienSection = '';
  int nombreDeCartesEnregistrees = 0;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0; // État pour suivre la sélection du ToggleSwitch
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
                      'Nouvelle section',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.delete_outline_outlined,color: Colors.orange,),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                  labels: ['Manuelle', 'Lien externe'],
                  radiusStyle: true,
                  onToggle: (index) {
                    if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LienCarte(
                            sectionNames: widget.sectionNames, // Passez la liste ici
                          ),
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
              _selectedIndex == 1
                  ?  Text('Contenu pour Manuelle')
                  : Column(
                children:[Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), // Ajustez les marges si nécessaire
                child: Row(
                  children: [
                    Text(
                      'La section',
                      style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8), // Ajoutez un border radius ici
                            ),
                            contentPadding: EdgeInsets.only(top: 26, left: 8,bottom: 20), // Ajoutez un padding à gauche

                          ),
                          onChanged: (value) {
                            setState(() {
                              nomCarte = value;
                            });
                          },
                        ),
                        Positioned(
                          top: 6,
                          left: 8,
                          child: Text(
                            "Nom de la section:",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],

                    ),


                  ],
                ),
              ),

              SizedBox(height: 38),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10), // Adjust margins if needed
                    child: Row(
                      children: [
                        Text(
                          widget.addedArticles.isEmpty
                              ? 'Aucun article ajouté'
                              : '${widget.addedArticles.length} ${widget.addedArticles.length == 1 ? 'Article' : 'Articles'}',
                          style: TextStyle(color: widget.addedArticles.isEmpty ? Colors.black : Colors.orange, fontWeight: FontWeight.w600),
                        ),

                        SizedBox(width: 4,),
                       Icon(Icons.keyboard_arrow_down_outlined,color: Colors.orange,)
                      ],
                    ),
                  ),


               /*   ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.addedArticles.length,
                    itemBuilder: (context, index) {
                      var article = widget.addedArticles[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20), // Add margin to create spacing between articles
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nom: ${article.name}'),
                            Text('Prix: ${article.price} EUR'),
                            Text('Description: ${article.description}'),
                          ],
                        ),
                      );
                    },
                  ),
*/


                  SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                children: [
                    ElevatedButton(
                      onPressed: () {
                        var article = widget.addedArticles[_selectedIndex];

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
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Colors.orange, width: 1),
                        primary: Colors.white,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_circle_outline, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'Ajouter un article',
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 320,),
              TextButton(
                onPressed: () {
                  widget.sectionNames.add(nomCarte); // Ajouter le nom de la section à la liste
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionAjouteeMenu(
                        nomCarte: nomCarte,
                        lienSection: lienSection,
                        sectionNames: widget.sectionNames,
                        nombreDeCartesEnregistrees: nombreDeCartesEnregistrees,
                        addedArticles: [],
                      ),
                    ),
                  );
                },
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
                child: Text('Enregister' ,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
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
