import 'dart:math';

import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/send_messages_widgets/text_form_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/others/theme.dart';

class ChangeReservationFormStep2 extends StatefulWidget {
  const ChangeReservationFormStep2({Key? key}) : super(key: key);

  @override
  State<ChangeReservationFormStep2> createState() =>
      _ChangeReservationFormStep2State();
}

class _ChangeReservationFormStep2State
    extends State<ChangeReservationFormStep2> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
        Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    const modificationSavedSnackBar = SnackBar(
      content: Text("Réservation  modifiée"),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: max(screenSize.height, 668),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text(
                      'Mr Bob Dylan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.check,
                      color: CustomThemeData.color,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Text(
                      'Confirmé',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(246, 136, 93, 1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: const [
                    Text(
                      'Récapitulatif des changements',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextFormTile(
                  subject: "Mercredi 27 Juillet",
                  title: "Date",
                  icon: Icon(Icons.date_range_outlined),
                ),
                const TextFormTile(
                  subject: "13h",
                  title: "Horraire",
                  icon: Icon(Icons.timer_outlined),
                ),
                const TextFormTile(
                  subject: "3",
                  title: "Nb pers",
                  icon: Icon(Icons.people_alt_outlined),
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextFormTile(
                  subject: "Bob",
                  title: "Prénom",
                  icon: Icon(Icons.person_outline),
                ),
                const TextFormTile(
                  subject: "Dylan",
                  title: "Nom",
                  icon: Icon(Icons.person),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: TextFormTile(
                        title: 'Telephone',
                        subject: "+33 734223879 ",
                        icon: Icon(Icons.phone_outlined),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color.fromRGBO(246, 136, 93, 1),
                      ),
                      child: const Icon(
                        Icons.phone_outlined,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      child: TextFormTile(
                        title: 'Mail',
                        subject: "jackson@gmail.com",
                        icon: Icon(Icons.mail_outline),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color.fromRGBO(246, 136, 93, 1),
                      ),
                      child: const Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Message envoyé au client',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Bonjour monsieur, Le restaurant Vegan-Burger à bien fait les changements de dates',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                CustomFlatButton(
                    width: screenSize.width - 48,
                    text: "Confirmer la modification",
                    color: Colors.black)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
