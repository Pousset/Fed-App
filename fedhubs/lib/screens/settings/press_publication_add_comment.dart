import 'dart:io';
import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_white_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import 'package:image_picker/image_picker.dart';

class PressPublicationAddComment extends StatefulWidget {
  const PressPublicationAddComment({Key? key}) : super(key: key);

  @override
  State<PressPublicationAddComment> createState() =>
      _PressPublicationAddCommentState();
}

class _PressPublicationAddCommentState
    extends State<PressPublicationAddComment> {
  File? _selectedImage;
  bool _isImageSelected = false; // Add this boolean flag
  @override
  Widget build(BuildContext context) {

    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 20),
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
                'Publication de presse',
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: const [
                Text(
                  "Mettez en avant les publications élogieuses sur votre établissement.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Votre demande seras pris en compte sous 2 à 3 jours. Il sera posté directement sur votre profil si l’équipe valide votre demande. En cas d’echec, vous serez notifié.",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: _addPicture(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 0.4,
              left: 2,
              right: 10,
              bottom: 8,
            ),
            child: Text(
              "Ajouter le commentaire de l'article",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black87
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          const TextField(
            //textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: "Commentaire",
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 2,
          ),
          SizedBox(height: 100), // Add some space below the TextField
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Your logic for the button action goes here
              });
            },
            child: Text(
              'Envoyer ma demande',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: _isImageSelected ? Colors.white : Colors.black, // Change the text color dynamically based on the flag
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              side: BorderSide(color: Colors.black87, width: 1),
              primary: _isImageSelected ? Colors.black87 : Colors.white, // Change the background color dynamically based on the flag
              minimumSize: Size(150, 50), // Définir la taille minimale du bouton ici (hauteur: 50, largeur: 150)

            ),
          ),

          SizedBox(height: 20), // Add some space below the button
        ],
      ),
    );

  }

  Widget _addPicture() {
    return Wrap(
      children: [
        Container(
          width: 400,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 50,
              right: 50,
              bottom: 20,
            ),
            child: Column(
              children: [
                const Text(
                  'Ajouter une photo de la marque du magazine ou site web qui a publié l’article',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: _pickImageFromGallery,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: _selectedImage == null ? BoxShape.circle : BoxShape.rectangle,
                      borderRadius: _selectedImage == null ? null : BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(246, 136, 93, 1),
                      ),
                    ),
                    child: Stack(
                      children: [
                        if (_selectedImage != null)
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        if (_selectedImage == null)
                          Center(
                            child: Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromRGBO(246, 136, 93, 1),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }






  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _isImageSelected = true; // Set the flag to true when an image is selected
      });
    }
  }




}
