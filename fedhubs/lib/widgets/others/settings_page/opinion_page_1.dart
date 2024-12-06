import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../foundation/constants.dart';

class OpinionPage1 extends StatefulWidget {
  const OpinionPage1({Key? key}) : super(key: key);

  @override
  State<OpinionPage1> createState() => _OpinionPage1State();
}

class _OpinionPage1State extends State<OpinionPage1> {
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
        padding: EdgeInsets.fromLTRB(20, screenSize.height * 0.09, 20, 0),
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
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _buildInfoEntreprise(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Text(
                  'Avis de presse et des internautes',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _opinionCards(),
                const SizedBox(
                  width: 20,
                ),
                _opinionCards(),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            _CommentsCard(),
          ],
        ),
      )),
    );
  }

  Widget _buildInfoEntreprise() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text('Vegan-Burger', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          '22 rue Rambuteau, 75003 Paris',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: const [
            Text('4.8'),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.star,
              size: 15,
              color: Color.fromRGBO(245, 136, 93, 100),
            ),
            SizedBox(
              width: 10,
            ),
            Text('121 avis'),
          ],
        ),
      ],
    );
  }

  Widget _opinionCards() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 35,
            blurStyle: BlurStyle.outer,
            offset: const Offset(4, 0),
          )
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(right: 35, left: 35, top: 30, bottom: 20),
        child: Column(
          children: const [
            Text(
              'Petit Futé',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(245, 136, 93, 100),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '4.6/5',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '32 votes',
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget _CommentsCard() {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.all(
        Radius.circular(25),
      ),
      elevation: 10,
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    "https://imgr.cineserie.com/2022/12/301333.jpg?imgeng=/f_jpg/cmpr_0/w_212/h_318/m_cropbox&ver=1",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amanda W',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Color.fromRGBO(245, 136, 93, 100),
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Color.fromRGBO(245, 136, 93, 100),
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                          color: Color.fromRGBO(245, 136, 93, 100),
                        ),
                        Icon(
                          Icons.star,
                          size: 15,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      '24/07/2022',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 180,
                ),
                const Icon(Icons.facebook),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit amet luctus venenatis, lectus magna fringilla urna, porttitor...Plus',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.reply_outlined,
                  color: Colors.black.withOpacity(0.5),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Répondre",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Icon(
                  Icons.thumb_up_off_alt_outlined,
                  color: Colors.black.withOpacity(0.5),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "J'aime",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
