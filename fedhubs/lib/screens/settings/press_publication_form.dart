import 'dart:math';

import 'package:fedhubs_pro/screens/settings/press_publication_add_comment.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class PressPublicationForm extends StatefulWidget {
  const PressPublicationForm({Key? key}) : super(key: key);

  @override
  State<PressPublicationForm> createState() => _PressPublicationFormState();
}

class _PressPublicationFormState extends State<PressPublicationForm> {
  bool _isSaved = false;
  bool _isValidLink = true;
  TextEditingController _linkController = TextEditingController();





  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  bool isValidLink(String link) {
    // Regular expression to check the link format
    final RegExp linkRegExp = RegExp(
      r'^https?:\/\/[\w-]+(\.[\w-]+)+[\w.,@?^=%&:/~+#-]*$',
      caseSensitive: false,
    );

    // Length check: Ensure the link is not empty and has a minimum length of 5 characters
    if (link == null || link.isEmpty || link.length < 22) {
      return false;
    }

    return linkRegExp.hasMatch(link);
  }



  void _handleNextButton() {
    if (_isSaved) {
      String link = _linkController.text;
      _isValidLink = isValidLink(link);
      if (_isValidLink) {
        // Navigate to another page and print 'Valide' in the console
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PressPublicationAddComment()),
        );
        print('Valide');
      } else {
        setState(() {
          _isValidLink = false;
        });
      }
    } else {
      setState(() {
        _isSaved = true;
      });
    }
  }

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
        height: max(screenSize.height, 668),
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
                    'Publication de presse',
                    style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
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
                    fontSize: 14,
                    color: Colors.black
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),


                Row(
                  children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Lien vers la publication",
                      style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,
                      ),
                ),
                  ),
                  ],
                ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _linkController,
                  maxLines: null,
                  onChanged: (_) {
                    setState(() {
                      _isValidLink = true; // Reset the link validation when the user is typing
                    });
                  },
                  style: TextStyle(
                    fontWeight: FontWeight.w600, // Mettre le texte en gras
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    hintText: "Indiquer le lien",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: _isValidLink ? Colors.grey : Colors.red,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: _isValidLink ? Colors.orange : Colors.red, // Change to orange when focused
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                ),
              ),


              if (!_isValidLink && _linkController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),

                  child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Votre lien n'est pas valide",
                      style: TextStyle(color: Colors.red,fontSize: 16,fontWeight:FontWeight.w500),

                    ),
                  ],
                  ),
                ),

              const Expanded(child: SizedBox()),
              TextButton(
                onPressed: _handleNextButton,

                style: TextButton.styleFrom(
                  backgroundColor: _isSaved ? Colors.black : Colors.white,
                  primary: _isSaved ? Colors.white : Colors.black,
                  side: BorderSide(color: Colors.black87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(screenSize.width - 48, 0),
                  padding: EdgeInsets.all(12.0),
                ),
                child: Text(
                  _isSaved ? 'Enregistrer' : 'Suivant',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: _isSaved ? Colors.white : Colors.black87,
                  ),
                ),
              ),



            ],
          ),
        ),
      )),
    );
  }


}
