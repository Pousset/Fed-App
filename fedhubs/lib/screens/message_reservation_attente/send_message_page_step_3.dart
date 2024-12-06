import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/others/theme.dart';
import '../../widgets/send_messages_widgets/text_form_tile.dart';

class SendMessageStep3 extends StatefulWidget {
  const SendMessageStep3({Key? key}) : super(key: key);

  @override
  State<SendMessageStep3> createState() => _SendMessageStep3State();
}

class _SendMessageStep3State extends State<SendMessageStep3> {
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
                    Icons.timer_outlined,
                    color: CustomThemeData.color,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(
                    'En attente de confirmation',
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
                    'Réservation',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TextFormTile(
                    title: 'Date',
                    subject: "Mercredi 28 Juillet",
                    icon: Icon(Icons.calendar_month_outlined),
                  ),
                  const TextFormTile(
                    title: 'Horaire',
                    subject: "12H30",
                    icon: Icon(Icons.lock_clock_outlined),
                  ),
                  const TextFormTile(
                    title: 'Nb de pers',
                    subject: "2",
                    icon: Icon(Icons.people_outline),
                  ),
                  const TextFormTile(
                    title: 'Prenom',
                    subject: "Bob ",
                    icon: Icon(Icons.person_outline),
                  ),
                  const TextFormTile(
                    title: 'Nom',
                    subject: "Dylan ",
                    icon: Icon(Icons.sentiment_very_dissatisfied_rounded),
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: TextFormTile(
                          title: 'Telephone',
                          subject: "+33 734223879 ",
                          icon: Icon(Icons.phone),
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(246, 136, 93, 1),
                        ),
                        icon: const Icon(
                          Icons.phone,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: TextFormTile(
                          subject: "samir@gmail.com",
                          title: "Mail",
                          icon: Icon(Icons.mail_outline),
                        ),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(246, 136, 93, 1),
                        ),
                        icon: const Icon(
                          Icons.mail,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextFormTile(
                    title: 'Commentaire',
                    subject: "Bonjour, nous avons que 30 min pour manger",
                    icon: Icon(Icons.comment_outlined),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.send),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "Lorem ipsum dolor sit amet,consectetur adipiscing elit ut aliquam, purus si t amet luctus venenatis, lectus magna fringilla urna, porttitor",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
