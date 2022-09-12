import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor:Colors.black,
 // primaryColor: Color(0xFFEF7822),
  secondaryHeaderColor: Color(0xFF1ED7AA),
  disabledColor: Color(0xFFBABFC4),
  backgroundColor: Color(0xFFF3F3F3),
  errorColor: Colors.red,
  //errorColor: Color(0xFFE84D4),
  brightness: Brightness.light,
  hintColor: Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: ColorScheme.light(primary: Colors.black, secondary: Colors.black),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Colors.black)),
  // colorScheme: ColorScheme.light(primary: Color(0xFFEF7822), secondary: Color(0xFFEF7822)),
  // textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: Color(0xFFEF7822))),

);