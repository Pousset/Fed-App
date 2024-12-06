import 'package:flutter/material.dart';

class CustomThemeData {
  static const color = Color(0x99000000);

  static get data => ThemeData(
        fontFamily: 'Montserrat',
        primaryColorLight: const Color.fromRGBO(255, 245, 241, 1),
        primaryColor: Colors.white,
        secondaryHeaderColor: color,
        primaryColorDark: const Color.fromRGBO(33, 15, 33, 1),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedLabelStyle: const TextStyle(color: color),
          unselectedLabelStyle: TextStyle(
            color: color.withOpacity(0.6),
          ),
        ),
        textTheme: const TextTheme(
            displaySmall: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            headlineMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0x99000000),
            ),
            headlineSmall: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            titleLarge: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0x99000000),
            ),
            labelMedium: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0x99000000),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )),
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            fontSize: 17,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          actionTextColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: color,
          secondary: color,
          onPrimary: const Color(0x99000000),
          onSurface: const Color(0x99000000),
          background: Colors.white,
          error: Colors.red.shade800,
        ),
      );
}
