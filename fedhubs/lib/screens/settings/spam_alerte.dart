import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundation/constants.dart';
import '../../widgets/buttons/custom_flat_button.dart';

class Spam extends StatefulWidget {
  const Spam({Key? key}) : super(key: key);

  @override
  State<Spam> createState() => _SpamState();
}

class _SpamState extends State<Spam> {
  @override
  Widget build(BuildContext context) {
    Size realScreenSize = MediaQuery.of(context).size;
    Size screenSize =
    Size(kIsWeb ? 600 : realScreenSize.width, realScreenSize.height);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
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
                       onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      'Signaler',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        // Mettez ici la logique pour fermer l'alerte sans rien faire
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                child: Divider(
                  color: Colors.orangeAccent,
                  height: 1,
                  thickness: 1,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text("Spam",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),)
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Row(
                  children: [
                    Text("Nous n'autorisons pas :",
                  style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 6,
                    ),
                    const SizedBox(
                      width: 4,
                    ),

                    Text("Le harcèlement, la vente ou le don de",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                  ],
                ),

              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Row(
                  children: [

                    const SizedBox(
                      width: 4,
                    ),

                    Text("comptes,de roles ou d'autorisation",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                  ],
                ),

              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 6,
                    ),
                    const SizedBox(
                      width: 4,
                    ),

                    Text("L'incitation, via une fausse execuse, a  ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                  ],
                ),

              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Row(
                  children: [

                    const SizedBox(
                      width: 4,
                    ),

                    Text("intergir avec du contenu",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                  ],
                ),

              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.grey,
                      size: 6,
                    ),
                    const SizedBox(
                      width: 4,
                    ),

                    Text("La redirection en dehors de Fedhubs via une",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                  ],
                ),

              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Row(
                  children: [

                    const SizedBox(
                      width: 4,
                    ),

                    Text("utilisation trompeuses des liens",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                  ],
                ),

              ),
              const SizedBox(
                height: 40,
              ),
              CustomFlatButton(
                width: screenSize.width - 48,
                text: 'Envoyer',
                color: Theme.of(context).secondaryHeaderColor,
                onPressed: () {
                  // _linkConfirmation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
