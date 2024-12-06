import 'package:fedhubs_pro/widgets/gestionquipe/profile_widget.dart';
import 'package:fedhubs_pro/widgets/gestionquipe/profile_widget_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class GestionEquipeChangeProfile extends StatefulWidget {
  const GestionEquipeChangeProfile({Key? key}) : super(key: key);

  @override
  State<GestionEquipeChangeProfile> createState() =>
      _GestionEquipeChangeProfileState();
}

class _GestionEquipeChangeProfileState
    extends State<GestionEquipeChangeProfile> {
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
        child: Column(
          children: [
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
                  child: const Icon(Icons.delete_outline),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Stack(
                alignment: Alignment.bottomCenter,
                // fit: StackFit.loose,
                clipBehavior: Clip.none,
                children: const [
                  Positioned(
                    top: 70,
                    child: GestionEquipeCustomProfile(),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://imgr.cineserie.com/2022/12/301333.jpg?imgeng=/f_jpg/cmpr_0/w_212/h_318/m_cropbox&ver=1",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
