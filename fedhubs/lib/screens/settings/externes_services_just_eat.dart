import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../foundation/constants.dart';

class JustEat extends StatefulWidget {
  const JustEat({Key? key}) : super(key: key);

  @override
  State<JustEat> createState() => _JustEatState();
}

class _JustEatState extends State<JustEat> {
  TextEditingController _linkController = TextEditingController();
  bool _isLinkBeingTyped = false;
  bool _isNavigationBarVisible = false;
  bool _isAlertVisible = false; // New variable to control the visibility of the alert
  bool _isActive = false;
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
        child: SizedBox(
          height: max(screenSize.height, 668),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, screenSize.height * 0.09, 20, 20),
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
                          Positioned(
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
                      width: 20,
                    ),
                    const Text(
                      'Publication de presse',
                      style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Vous pouvez indiquer le liens qui conduit directement sur votre page de livraison puis enregistrer pour que tous le monde puisse le voir. ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon/justeat.png',
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Just Eat",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Spacer(), // Add Spacer to push ElevatedButton to the right
                      if (_isActive)
                        ElevatedButton(
                          onPressed: () {
                            // Action à effectuer lorsqu'on appuie sur le bouton
                          },
                          child: Text(
                            'Actif',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            side: BorderSide(color: Colors.orange, width: 1),
                            fixedSize: Size(90, 40),
                            primary: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Lien ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isLinkBeingTyped ? Colors.orange : Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 700,
                    height: 50,
                    child: TextField(
                      controller: _linkController,
                      onChanged: (value) {
                        setState(() {
                          _isLinkBeingTyped = value.isNotEmpty;
                        });
                      },
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Indiquer le lien de votre page',
                        hintStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        border: InputBorder.none,
                        prefix: SizedBox(width: 6),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isNavigationBarVisible = !_isNavigationBarVisible;
                      _isAlertVisible = true; // Show the alert when the button is tapped
                      _isActive = true;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor:
                    _isLinkBeingTyped ? Colors.black : Colors.white,
                    side: BorderSide(color: Colors.black87),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(screenSize.width - 48, 0),
                    padding: EdgeInsets.all(12.0),
                  ),
                  child: Text(
                    'Enregistrer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: _isLinkBeingTyped ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: _isNavigationBarVisible,
        child: Container(
          height: 80,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
    topRight: Radius.circular(30), topLeft: Radius.circular(30)),
    boxShadow: [
    BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 0.2),
    ],
    ),
    child: ClipRRect(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
    ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available_outlined),
            label: 'Événements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Réservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Paramètres',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange.shade200,
        unselectedItemColor: Colors.deepOrange.shade200,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600), // Set bold text for selected item
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
    )
    ),
      ),

      floatingActionButton: _isAlertVisible
          ? GestureDetector(
        onTap: () {
          setState(() {
            _isAlertVisible = false; // Hide the alert when the container is tapped
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 66.0,horizontal:0.4),
          child: Container(
            height: 60,
            width: 400,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'Votre demande a été envoyée',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Ok',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          : null, // Set to null when the alert is not visible
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }

}
