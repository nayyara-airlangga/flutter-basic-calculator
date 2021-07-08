import 'package:flutter/material.dart';

ThemeData lightThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.grey.shade200,
  backgroundColor: Colors.grey[700],
  primaryColorLight: Colors.black,
  primaryColorDark: Colors.grey.withOpacity(0.1),
  accentColor: Colors.grey.withOpacity(0.7),
  splashColor: Colors.black,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontSize: 32,
    ),
  ),
);

ThemeData darkThemeData = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black54,
  primaryColor: Colors.grey.withOpacity(0.2),
  primaryColorLight: Colors.grey.withOpacity(0.6),
  primaryColorDark: Colors.grey.withOpacity(0.1),
  accentColor: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 32,
    ),
  ),
);
