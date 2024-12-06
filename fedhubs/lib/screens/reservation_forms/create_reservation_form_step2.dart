import 'package:fedhubs_pro/widgets/bottoms_dialog/bottom_dialog_event.dart';
import 'package:fedhubs_pro/widgets/bottoms_dialog/bottom_dialog_reservation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';
import '../../widgets/send_messages_widgets/text_form_tile.dart';

class CreateReservationFormStep2 extends StatefulWidget {
  const CreateReservationFormStep2({Key? key}) : super(key: key);

  @override
  State<CreateReservationFormStep2> createState() =>
      CreateReservationFormStep2State();
}

class CreateReservationFormStep2State
    extends State<CreateReservationFormStep2> {
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
                    'Créer une réservation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Text(
                    'Récapitulatif de la réservation',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
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
              const SizedBox(
                height: 10,
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
              SizedBox(
                height: screenSize.height * 0.16,
              ),
              CustomFlatButton(
                width: realScreenSize.width,
                text: "Créer la réservation",
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
