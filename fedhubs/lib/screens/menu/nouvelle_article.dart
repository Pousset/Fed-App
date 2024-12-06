import 'dart:io';

import 'package:fedhubs_pro/screens/menu/section_ajout%C3%A9e_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../foundation/constants.dart';
import 'article_data.dart';
import 'la_carte.dart';
import 'modification_article.dart';
import 'nouvelle_section_manuellement.dart';

class NouvelleArticle extends StatefulWidget {
  final List<String> sectionNames;
  final List<ArticleData> addedArticles; // Add this line

  const NouvelleArticle({Key? key, required this.sectionNames, required this.addedArticles}) : super(key: key);

  @override
  State<NouvelleArticle> createState() => _NouvelleArticleState();
}

class _NouvelleArticleState extends State<NouvelleArticle> {
  String selectedSection = '';

  late List<String> listItem;
  late String valuechoose;
  late ImagePicker _imagePicker;
  File? _selectedImage;
  List<ArticleData> addedArticles = [];
  String _articleName = '';
  String _articlePrice = '';
  String _articleDescription = '';
  @override
  void initState() {
    super.initState();
    listItem = ['Nom de section', ...widget.sectionNames];
    valuechoose = 'Nom de section'; // Définissez la valeur initiale sur le hint
    _imagePicker = ImagePicker();

  }

  Future<void> _selectImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize = Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
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
                      'Nouvelle article',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.delete_outline_outlined, color: Colors.black),
                  ],
                ),
              ),
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    Text(
                      'Section de article',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 4, top: 4),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          contentPadding: EdgeInsets.only(top: 26, left: 10, bottom: 26),
                        ),

                      ),

                    ),
                    Positioned(
                      top: 13,
                      left: 8,
                      child: Text(
                        "Nom de section",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24, // Ajustez la valeur selon l'espacement désiré
                      left: 8,
                      right: 0,
                      child: DropdownButton<String>(
                        // hint: Text("Nom de section"),
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        value: valuechoose,
                        onChanged: (newValue) {
                          setState(() {
                            valuechoose = newValue!;
                          });
                        },
                        items: listItem.map((valueItem) {
                          return DropdownMenuItem<String>(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11.0),
                child: Row(
                  children: [
                    Text(
                      'Article au menu',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),                  ],
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
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14), // Ajoutez un border radius ici
                            ),
                            contentPadding: EdgeInsets.only(top: 20, left: 8,bottom: 33), // Ajoutez un padding à gauche

                          ),
                          onChanged: (value) {
                            setState(() {
                              _articleName = value;
                            });
                          },
                        ),
                        Positioned(
                          top: 6,
                          left: 8,
                          child: Text(
                            "Nom de l'article",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],

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
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14), // Ajoutez un border radius ici
                            ),
                            contentPadding: EdgeInsets.only(top: 20, left: 8,bottom: 33), // Ajoutez un padding à gauche

                          ),
                          onChanged: (value) {
                            setState(() {
                              _articlePrice = value;
                            });
                          },
                        ),
                        Positioned(
                          top: 6,
                          left: 8,
                          child: Text(
                            "Prix de l'article (EUR)",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],

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
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14), // Ajoutez un border radius ici
                            ),
                            contentPadding: EdgeInsets.only(top: 20, left: 8,bottom: 33), // Ajoutez un padding à gauche

                          ),
                      maxLines: null,
                          onChanged: (value) {
                            setState(() {
                              _articleDescription = value;
                            });
                          },
                        ),
                        Positioned(
                          top: 6,
                          left: 8,
                          child: Text(
                            "Description de l'article",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],

                    ),


                  ],
                ),
              ),

              SizedBox(height: 12,),
              GestureDetector(
                onTap: _selectImage,
                child: Container(
                  width: 331,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    image: _selectedImage != null
                        ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: _selectedImage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 48,
                        color: Colors.orange.shade400,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Sélectionner une photo',
                        style: TextStyle(
                          color: Colors.orange.shade400,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                      : null,
                ),
              ),
              SizedBox(height: 240,),
              TextButton(
                onPressed: () {
                  ArticleData newArticle = ArticleData(
                    name: _articleName,
                    price: _articlePrice,
                    description: _articleDescription,
                    selectedImage: _selectedImage,
                    sectionName: selectedSection
                    // Add other properties like _selectedImage
                  );
                  setState(() {
                    addedArticles.add(newArticle);
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Carte(
                        sectionNames: widget.sectionNames,
                        addedArticles: addedArticles, nomCarte: '',lienSection: '',nombreDeCartesEnregistrees: 0,
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
        ),
      ),
    );
  }
}
