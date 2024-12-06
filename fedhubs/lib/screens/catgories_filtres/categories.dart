import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // Initialiser _currentIndex à 0 pour afficher "Accueil" en orange au début.
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Container(
            width: double.infinity, // Take up full width
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
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

                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                    _buildNavBar(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: _buildBody(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    // Contenu de la page principale en fonction de l'onglet sélectionné.
    if (_currentIndex == 0) {
      return Center(
        child: Text('Contenu de l\'onglet 1'),
      );
    } else if (_currentIndex == 1) {
      return Center(
        child: Text('Contenu de l\'onglet 2'),
      );
    } else {
      return Container(); // Cas par défaut, vous pouvez le personnaliser selon vos besoins.
    }
  }

  Widget _buildNavBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 18), // Add space above the item
            child: _buildNavItem("Catégories et filtres", 0),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18), // Add space above the item
            child: _buildNavItem("Hashtags", 1),
          ),
        ],
      ),
    );
  }


  Widget _buildNavItem(String label, int index) {
    return InkWell(
      onTap: () => _onTabTapped(index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: _currentIndex == index ? Colors.amber[800] : Colors.grey[600],fontSize: 16,fontWeight: FontWeight.w600),
          ),

  Expanded(
    child: SizedBox(

      height: 16,

    ),
  ),

       SizedBox(
              height: 2, // Height of the orange line
              width: 80, // Width of the orange line
              child: Container(
                color: _currentIndex == index ? Colors.orange : Colors.transparent,
              ),
            ),

        ],
      ),
    );
  }
}
