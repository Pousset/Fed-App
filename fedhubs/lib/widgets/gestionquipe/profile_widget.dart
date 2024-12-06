import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/buttons/custom_white_flat_button.dart';
import 'package:flutter/material.dart';

class GestionEquipeProfilWidget extends StatefulWidget {
  const GestionEquipeProfilWidget({Key? key}) : super(key: key);

  @override
  State<GestionEquipeProfilWidget> createState() =>
      _GestionEquipeProfilWidgetState();
}

class _GestionEquipeProfilWidgetState extends State<GestionEquipeProfilWidget> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;

    return Container(
      width: realScreenSize.width * 0.80,
      child: Material(
        color: Colors.white,
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Stéphane Jacquet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Text('Rôle'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Éditeur',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('Date'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '07/07/2022',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Numéro de téléphone'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '+33 (0)7 32 97 51 34',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.phone_outlined,
                    color: Color.fromRGBO(245, 136, 93, 100),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Email'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'stephanejaquet@test.com',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.mail_outline,
                    color: Color.fromRGBO(245, 136, 93, 100),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomWhiteFlatButton(
                    width: realScreenSize.height - 48,
                    text: "Modifier le rôle",
                    color: Colors.red),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomFlatButton(
                    width: realScreenSize.width,
                    text: "Supprimer",
                    onPressed: () {},
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
