import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';
import 'article_data.dart';
import 'la_carte.dart';

class ModifierArticle extends StatefulWidget {
  final List<String> sectionNames;
  final ArticleData articleData;

  const ModifierArticle({Key? key, required this.sectionNames, required this.articleData})
      : super(key: key);

  @override
  State<ModifierArticle> createState() => _ModifierArticleState();
}

class _ModifierArticleState extends State<ModifierArticle> {
  String selectedSection = '';
  late List<String> listItem;
  late String valuechoose;
  late ImagePicker _imagePicker;
  File? _selectedImage;
  List<ArticleData> addedArticles = [];

  late String _articleName;
  late String _articlePrice;
  late String _articleDescription;





  @override
  void initState() {
    super.initState();
    listItem = ['Nom de section', ...widget.sectionNames];
    valuechoose = listItem[0]; // Initialiser avec la première valeur de la liste
    _imagePicker = ImagePicker();    // Initialisez les champs avec les données de l'article
    _articleName = widget.articleData.name;
    _articlePrice = widget.articleData.price;
    _articleDescription = widget.articleData.description;
    _selectedImage = widget.articleData.selectedImage;
    selectedSection = widget.articleData.sectionName;

  }

  Future<void> _selectImage() async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _deleteArticle() {
    // Supprimez l'article de la liste addedArticles en utilisant widget.articleData comme référence
    addedArticles.remove(widget.articleData);

    // Naviguez vers la page précédente
    Navigator.pop(context, addedArticles);
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
                      "Modification de l'article",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: _deleteArticle,
                      child: Icon(Icons.delete_outline_outlined, color: Colors.black),
                    ),
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
                    SizedBox(width: 12), // Ajoutez un espacement entre le DropdownButton et le Text
                    Text(
                      selectedSection, // Utilisez la variable selectedSection
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
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
                          initialValue: _articleName,
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
                          initialValue: _articlePrice,
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
                          initialValue: _articleDescription,
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
              Stack(
                children: [
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
                  Positioned(
                    top: 8,
                    left: 8,
                    child: GestureDetector(
                      onTap: _selectImage, // Vous pouvez appeler la même fonction pour ouvrir la galerie
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.black,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Modifier',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 240,),
              CustomFlatButton(
                width: screenSize.width - 48,
                text: 'Enregistrer',
                color: Theme.of(context).secondaryHeaderColor,
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

              ),


            ],
          ),
        ),
      ),
    );
  }
}
