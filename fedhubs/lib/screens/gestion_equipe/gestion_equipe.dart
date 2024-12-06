import 'package:fedhubs_pro/widgets/gestionquipe/member_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';

class GestionEquipePage extends StatefulWidget {
  const GestionEquipePage({Key? key}) : super(key: key);

  @override
  State<GestionEquipePage> createState() => _GestionEquipePageState();
}

class _GestionEquipePageState extends State<GestionEquipePage> {
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
                  // _addTeamMember(context),
                  GestureDetector(
                    child: const Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: Color.fromRGBO(245, 136, 93, 100),
                    ),
                    onTap: () {
                      _addTeamMember(context);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    "Gestion d'équipe",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                elevation: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _PersonTeamCard(),
                      const Divider(
                        thickness: 1,
                        endIndent: 10,
                        indent: 85,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _PersonTeamCard(),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(
                        thickness: 1,
                        endIndent: 10,
                        indent: 85,
                      ),
                      _PersonTeamCard(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _PersonTeamCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              "https://imgr.cineserie.com/2022/12/301333.jpg?imgeng=/f_jpg/cmpr_0/w_212/h_318/m_cropbox&ver=1",
            ),
          ),
          // const Icon(
          //   Icons.person,
          // ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Timothy",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text("Propriétaire"),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              border: Border.all(
                color: const Color.fromRGBO(245, 136, 93, 100),
              ),
            ),
            child: const Text(
              "01/01/2023",
              style: TextStyle(
                color: Color.fromRGBO(245, 136, 93, 100),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromRGBO(245, 136, 93, 100),
          ),
        ],
      ),
    );
  }

  void _addTeamMember(context) {
    Dialog dialog = Dialog(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Wrap(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 25, right: 10, left: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ajouter des nouveaux membres",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter une adresse mail",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
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
