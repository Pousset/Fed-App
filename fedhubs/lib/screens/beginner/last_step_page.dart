import 'package:fedhubs_pro/screens/beginner/add_etablissement.dart';
import 'package:fedhubs_pro/services/auth.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LastStepPage extends StatelessWidget {
  const LastStepPage({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const LastStepPage(),
      fullscreenDialog: true,
    ));
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
      SizedBox(height: screenSize.height * 0.09),
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              child: Stack(children: [
                Icon(
                  Icons.circle,
                  color: Theme.of(context).secondaryHeaderColor,
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
              ]),
              onTap: () => Navigator.of(context).pop(),
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 26.5),
                SvgPicture.asset(
                  'assets/last_step.svg',
                  width: 280,
                  height: 250,
                ),
                const SizedBox(height: 38.2),
                const Text(
                  'Ajouter un établissement',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Dernière étape',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 45.5),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0), 
                  child: const Text(
                    "Renseigner toutes les informations nécessaires pour enregistrer votre établissement",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height / 9 - 30),
                Image.asset(
                      'assets/circle.png',
                      scale: 3,
                    ),
                
              ],
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: CustomFlatButton(
              width: screenSize.width - 48,
              text: 'Suivant',
              color: Theme.of(context).secondaryHeaderColor,
              onPressed: () => AddEtablissementPage.push(context)
            ),
          ),
        ],
      ),
    );
  }
}

// onPressed: () => AddEtablissementPage.push(context,state: DownloadYourProfilePictureState.first);
//               () async {
//                 //await LocalDatabase().disableFirstOpen();
//                 final auth = Provider.of<Auth>(context, listen: false);
//                 auth.loginState.loggedIn = true;
//               },