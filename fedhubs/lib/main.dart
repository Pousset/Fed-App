import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Accueil',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 1: Favoris',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 2: Paramètres',
      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 233, 30, 30)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  DateTime? _selectedDate;

  void _selectFullDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    ).then((date) {
      setState(() {
        _selectedDate = date;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Example'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dehaze_rounded),
            label: 'Paramètres',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectFullDate,
        tooltip: 'Sélectionner la date',
        child: Icon(Icons.calendar_today),
      ),

      // le texte 'aucune date sélectionnée' s'affiche au milieu de l'écran
      // si aucune date n'est sélectionnée
      
      bottomSheet: _selectedDate != null
          ? Text(
              'Date sélectionnée: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
              style: TextStyle(fontSize: 18),
            )
          : null,
    );
  }
}
