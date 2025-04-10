import 'package:flutter/material.dart';

/// The colors used in the app.
const Color primaryColor = Color(0xFF63B995);
const Color primaryLightColor = Color(0xFF86DEB7);
const Color primaryDarkColor = Color(0xFF12402C);
const Color darkColor = Color(0xFF0B251A);
const Color backgroundColor = Color(0xFF000000);
const Color foregroundColor = Color(0xFFFFFFFF);
const Color positiveColor = Color(0x000DB34F);
const Color negativeColor = Color(0x00F44444);

final MaterialColor customColor = MaterialColor(
  0xFFAABBFF,
  <int, Color>{
    50: foregroundColor,
    100: primaryLightColor,
    200: primaryLightColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryDarkColor,
    600: primaryDarkColor,
    700: darkColor,
    800: darkColor,
    900: backgroundColor,
  },
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primarySwatch: customColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
    )
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: foregroundColor,
      textStyle: TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: 'Poppins',
        color: foregroundColor,
      ),
      backgroundColor: Colors.transparent,
    ),
  ),
  scaffoldBackgroundColor: darkColor,
);