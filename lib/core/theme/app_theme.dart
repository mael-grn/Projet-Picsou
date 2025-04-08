import 'package:flutter/material.dart';

/// The colors used in the app.
/*
final Color primaryColor = Color(0xFF63B995);
final Color primaryLightColor = Color(0xFF86DEB7);
final Color primaryDarkColor = Color(0xFF12402C);
final Color darkColor = Color(0xFF0B251A);
final Color backgroundColor = Color(0xFF000000);
final Color foregroundColor = Color(0xFFFFFFFF);
 */

final Color secondaryColor = Color(0xFF87DFBA);
final Color primaryColor = Color(0xFF58AC88);
final Color backgroundColor = Color(0xFFFFFFFF);
final Color backgroundVariantColor = Color(0xFFC6D1D0);
final Color foregroundColor = Color(0xFF000000);
final Color foregroundVariantColor = Color(0xFF282E28);

final MaterialColor customColor = MaterialColor(
  0xFFAABBFF,
  <int, Color>{
    50: foregroundColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: backgroundColor,
  },
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
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
  scaffoldBackgroundColor: backgroundColor,
);