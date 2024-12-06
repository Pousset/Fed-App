import 'dart:io';
import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/others/settings_page/menu_settings/textfieldtile.dart';
import 'package:fedhubs_pro/widgets/send_messages_widgets/text_form_list_tile.dart';
import 'package:fedhubs_pro/widgets/send_messages_widgets/text_form_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../foundation/constants.dart';

class MenuChangesPage extends StatefulWidget {
  const MenuChangesPage({Key? key}) : super(key: key);

  @override
  State<MenuChangesPage> createState() => _MenuChangesPageState();
}

class _MenuChangesPageState extends State<MenuChangesPage> {
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    const savedSnackBar = SnackBar(
      content: Text(
        "Changement enregistré",
      ),
    );
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(screenSize.height, 668),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, screenSize.height * 0.09, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                    const Icon(
                      Icons.delete_outline,
                      color: Color.fromRGBO(246, 136, 93, 1),
                      size: 35,
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Modification menu",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Section Menu',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      hintText: "Nom de section",
                      hintStyle: TextStyle(
                        fontSize: 14,
                      )),
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Article au menu',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(child: _buildColumnField()),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),

                        child: GestureDetector(
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                          },
                          child: Container(
                              child: Column(
                            children: const [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: Color.fromRGBO(246, 136, 93, 1),
                              ),
                              Text("Séléctionner une photo")
                            ],
                          )),
                        ),
                        // child: Image.network(
                        //   "https://www.hachette.fr/sites/default/files/burger-verrecchia.jpg",
                        //   width: 150,
                        // ),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                CustomFlatButton(
                  width: screenSize.width - 48,
                  text: "Enregistrer",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(savedSnackBar);
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColumnField() {
    return Column(
      children: const [
        SimpleTextField(title: "Nom de l'article"),
        SizedBox(
          height: 10,
        ),
        SimpleTextField(title: "Prix de l'article(EUR)"),
        SizedBox(
          height: 10,
        ),
        // SimpleTextField(title: "Description de l'article"),
        TextField(
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: "Description de l'article",
              hintStyle: TextStyle(
                fontSize: 14,
              )),
          keyboardType: TextInputType.multiline,
          maxLines: 4,
        ),
      ],
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxHeight: 1024,
        maxWidth: 1024,
      );
      if (image == null) return null;
      final imageTemp = File(image.path);
      return imageTemp;
    } on PlatformException {
      rethrow;
    }
  }
}
