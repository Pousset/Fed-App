import 'package:fedhubs_pro/screens/etablissement_forms/etablissement_informations.dart';
import 'package:fedhubs_pro/services/local/local_database.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AddEtablissementPage extends StatelessWidget {
  const AddEtablissementPage({Key? key}) : super(key: key);

  static Future<void> push(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => const AddEtablissementPage(),
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.05),
                const Text(
                  'Comment ajouter un établissement ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20.75),
                _section(
                  title: "Informations importantes",
                  text: "Renseigné toutes les informations importantes concernant votre établissement",
                  svgPath: 'assets/informations.svg',
                  svgHeightReplacement: 28,
                ),
                const SizedBox(height: 28.75),
                _section(
                  title: "Emplacement",
                  text:
                      "Indiqué l’adresse de l’établissement",
                  svgPath: 'assets/emplacement.svg',
                  svgHeightReplacement: 35,
                ),
                const SizedBox(height: 28.75),
                _section(
                  title: "Photo de couverture & Logo",
                  text:"Enregristré votre photo de couverture et votre logo",
                  svgPath: 'assets/profile_pic.svg',
                  svgHeightReplacement: 30,
                ),
                const SizedBox(height: 28.75),
                _section(
                  title: "Horaires d’ouverture",
                  text:"Indiqué les horaires d’ouverture de votre établissement ",
                  svgPath: 'assets/calender.svg',
                  svgHeightReplacement: 35,
                ),
                SizedBox(height: screenSize.height / 8 - 30),
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
              onPressed: () => EtablissementInformations.push(context)
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({
    required String svgPath,
    required double svgHeightReplacement,
    required String title,
    required String text,
  }) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          SvgPicture.asset(
            svgPath,
            width: 25,
            height: svgHeightReplacement,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

