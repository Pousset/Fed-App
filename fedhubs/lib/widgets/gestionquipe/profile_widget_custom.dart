import 'package:fedhubs_pro/widgets/buttons/custom_flat_button.dart';
import 'package:fedhubs_pro/widgets/gestionquipe/member_type.dart';
import 'package:flutter/material.dart';

class GestionEquipeCustomProfile extends StatefulWidget {
  const GestionEquipeCustomProfile({Key? key}) : super(key: key);

  @override
  State<GestionEquipeCustomProfile> createState() =>
      _GestionEquipeCustomProfileState();
}

class _GestionEquipeCustomProfileState
    extends State<GestionEquipeCustomProfile> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;

    return SizedBox(
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
                height: 5,
              ),
              const Text(
                'stephanejacquet@test.com',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 50,
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
                height: 50,
              ),
              const MembreTypeWidget(
                membertype: "Editeur",
              ),
              const SizedBox(
                height: 20,
              ),
              const MembreTypeWidget(
                membertype: "Administrateur",
              ),
              const SizedBox(
                height: 20,
              ),
              const MembreTypeWidget(
                membertype: "Propriétaire",
              ),
              const SizedBox(
                height: 20,
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
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.center,
                  width: realScreenSize.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Text(
                    'Modifier le rôle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomFlatButton(
                    width: realScreenSize.width,
                    text: "Supprimer",
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
