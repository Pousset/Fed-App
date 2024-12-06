import 'dart:io';
import 'dart:math';

import 'package:fedhubs_pro/screens/settings/press_publication_page.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart'; // Pour utiliser la galerie

import '../../foundation/constants.dart';

class PressPublicationAddPicture extends StatefulWidget {
  const PressPublicationAddPicture({Key? key}) : super(key: key);

  @override
  State<PressPublicationAddPicture> createState() =>
      _PressPublicationAddPictureState();
}

class _PressPublicationAddPictureState
    extends State<PressPublicationAddPicture> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    const changingSavedSnackbar = SnackBar(
      content: Text("Changement enregistré"),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(screenSize.height, 668),
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 10),

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
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Mettez en avant les publications élogieuses sur votre établissement.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                _addPicture(),
                const SizedBox(
                  height: 50,
                ),
                _suggestText(),
                const Expanded(
                  child: SizedBox(),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFlatButton(
                  width: screenSize.width - 48,
                  text: 'Enregistrer',
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    // _linkConfirmation();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             const PressePublicationPage1()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addPicture() {
    Future<void> _pickImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _pickedImage = File(pickedFile.path);
        });
      }
    }

    return Container(
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
              'Photo Suggérée',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 14,
            ),
            // Utilize a Stack to superimpose the circle and the pencil icon
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: _pickedImage != null
                      ? Colors.transparent
                      : Theme.of(context).primaryColorDark,
                  backgroundImage: _pickedImage != null
                      ? FileImage(_pickedImage!)
                      : null,
                  child: _pickedImage == null
                      ? Image.asset(
                  'assets/icon/icon.png'
                  )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      _pickImage();
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _suggestText() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                children: [
                  Text(
                    "Texte suggéré",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50, // Height of the TextField
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          maxLines: null, // Set this to allow the TextField to expand vertically
                          decoration: InputDecoration(
                            hintText: "Le meilleur burger de Paris !",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }



}
