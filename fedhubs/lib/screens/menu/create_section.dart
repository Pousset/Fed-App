import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nouvelle_section_manuellement.dart';

class CreateSection extends StatefulWidget {
  final List<String> sectionNames; // Ajoutez le paramètre ici

  const CreateSection({
    Key? key,
    required this.sectionNames, // Assurez-vous d'ajouter le paramètre ici
  }) : super(key: key);


  @override
  State<CreateSection> createState() => _CreateSectionState();
}

class _CreateSectionState extends State<CreateSection> {
  List<String> sectionNames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             const SizedBox(height: 46),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                     // onTap: isLoading ? null : () => Navigator.of(context).pop(),
                   ),
                   const SizedBox(
                     width: 18,
                   ),
                   Text(
                     'Menu',
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                     ),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 22,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0),
               child: Row(
                 children: [
                   ElevatedButton(
                     onPressed: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) => SectioneManuelle(  sectionNames: sectionNames, addedArticles: []),
                         ),
                       );
                     },
                     style: ElevatedButton.styleFrom(
                       shape: StadiumBorder(),
                       side: BorderSide(color: Colors.grey, width: 1),
                       primary: Colors.white,
                     ),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Icon(Icons.add_circle_outline, color: Colors.grey.shade400),
                         SizedBox(width: 8),
                         Text(
                           'Ajouter une section',
                           style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.w600),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 80),  // Ajustez l'espacement vertical si nécessaire
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8), // Ajustez les marges si nécessaire
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center, // Centrez l'icône horizontalement
                 children: [
                   Container(
                     width: 240, // Ajustez la largeur du conteneur selon vos besoins
                     height: 120, // Ajustez la hauteur du conteneur selon vos besoins
                     child: Icon(
                       Icons.edit_outlined,
                       size: 120, // Ajustez la taille de l'icône selon vos besoins
                       color: Colors.orange[200],
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 18),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 40),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left: 22),
                     child: Text("Votre carte est vide. Commencer à",
                       style: TextStyle(
                         fontWeight: FontWeight.w600,
                         color: Colors.grey[800],
                       ),),
                   ),
                   SizedBox(height: 8),
                   Row(
                     children: [

                       Expanded(
                         child: RichText(
                           text: TextSpan(

                             children: [
                               TextSpan(
                                 text: "       la remplir en ",
                                 style: TextStyle(
                                   fontWeight: FontWeight.w600,
                                   color: Colors.grey[800],
                                 ),
                               ),
                               TextSpan(
                                 text: "ajoutant une section. ",
                                 style: TextStyle(
                                   color: Colors.orange,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),

                 ],
               ),
             ),




           ],
          ),
        ),
      ),
    );
  }
}
