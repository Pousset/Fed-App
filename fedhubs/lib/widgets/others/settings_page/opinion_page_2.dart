import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../foundation/constants.dart';

class OpinionAnswerPage extends StatefulWidget {
  const OpinionAnswerPage({Key? key}) : super(key: key);

  @override
  State<OpinionAnswerPage> createState() => _OpinionAnswerPageState();
}

class _OpinionAnswerPageState extends State<OpinionAnswerPage> {
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
              _buildOpinionCard()
            ],
          ),
        ),
      ),
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
        Text(
          '22 rue Rambuteau, 75003 Paris',
          style: Theme.of(context).textTheme.labelMedium,
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

  Widget _buildOpinionCard() {
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
                    Text(
                      'Amanda W',
                      style: Theme.of(context).textTheme.displaySmall,
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
                        Icon(Icons.star, size: 15),
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
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _commentSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _commentSection() {
    return Column(
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
              children: const [
                Text(
                  "Vegan-Burger",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Proprietaire",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
                ),
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const TextField(
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              hintText: 'Votre réponse...',
              hintStyle: TextStyle(
                fontSize: 14,
              )),
          keyboardType: TextInputType.multiline,
          maxLines: 3,
        ),
      ],
    );
  }
}
