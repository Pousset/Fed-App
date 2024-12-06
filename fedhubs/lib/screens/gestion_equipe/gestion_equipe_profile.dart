import 'package:fedhubs_pro/foundation/constants.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/gestionquipe/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestionEquipeProfile extends StatefulWidget {
  const GestionEquipeProfile({Key? key}) : super(key: key);

  @override
  State<GestionEquipeProfile> createState() => _GestionEquipeProfileState();
}

class _GestionEquipeProfileState extends State<GestionEquipeProfile> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Stack(
                    children: [
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
                    ],
                  ),
                ),
                // _addTeamMember(context),
                GestureDetector(
                  child: const Icon(
                    Icons.delete_outline,
                    size: 30,
                    color: Color.fromRGBO(246, 136, 93, 1),
                  ),
                  onTap: () {
                    _deleteMemberDialog(context);
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              // fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: const [
                Positioned(
                  top: 70,
                  child: GestionEquipeProfilWidget(),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://imgr.cineserie.com/2022/12/301333.jpg?imgeng=/f_jpg/cmpr_0/w_212/h_318/m_cropbox&ver=1",
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _deleteMemberDialog(context) {
    Dialog dialog = Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 25, right: 10, left: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Supprimer cette personne ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15),
                  child: Text(
                    "La suppression de cette personne sera définitive",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: const Text(
                        'ANNULER',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: const Text(
                        "SUPPRIMER",
                        style: TextStyle(
                          color: Color.fromRGBO(246, 136, 93, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
    showDialog(context: context, builder: (context) => dialog);
  }
}
