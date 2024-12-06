import 'package:fedhubs_pro/widgets/others/theme.dart';
import 'package:fedhubs_pro/widgets/send_messages_widgets/text_form_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({Key? key}) : super(key: key);

  @override
  State<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
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
            children: <Widget>[
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
                      color: CustomThemeData.color,
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
                children: const [
                  TextFormTile(
                    title: 'Date',
                    subject: "Mercredi 28 Juillet",
                    icon: Icon(Icons.calendar_month_outlined),
                  ),
                  TextFormTile(
                    title: 'Horaire',
                    subject: "12H30",
                    icon: Icon(Icons.lock_clock_outlined),
                  ),
                  TextFormTile(
                    title: 'Nb de pers',
                    subject: "2",
                    icon: Icon(Icons.people_outline),
                  ),
                  TextFormTile(
                    title: 'Commentaire',
                    subject: "Bonjour, nous avons que 30 min pour manger",
                    icon: Icon(Icons.comment_outlined),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.send_outlined,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          hintText:
                              'Ajouter un message personnalisée pour votre client...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          )),
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
