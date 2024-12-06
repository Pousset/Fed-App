import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';

class Autre extends StatefulWidget {
  const Autre({Key? key}) : super(key: key);

  @override
  State<Autre> createState() => _AutreState();
}

class _AutreState extends State<Autre> {
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
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Text(
                        'Signaler',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  child: Divider(
                    color: Colors.orangeAccent,
                    height: 1,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Text("Indiquer la raison de votre signalement",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Veuillez indiquer le motif de votre signalement si dessus.",
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
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),
                      hintText: "Entrer votre motif",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Ajustez ces valeurs selon vos besoins
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomFlatButton(
                  width: screenSize.width - 48,
                  text: 'Envoyer',
                  color: Theme.of(context).secondaryHeaderColor,
                  onPressed: () {
                    // _linkConfirmation();
                  },
                ),
              ],
            ),
          ),
        ),

    );
  }
}
