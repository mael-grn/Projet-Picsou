import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFF63B995);
final Color primaryLightColor = Color(0xFF86DEB7);
final Color primaryDarkColor = Color(0xFF12402C);
final Color darkColor = Color(0xFF0B251A);
final Color backgroundColor = Color(0xFF000000);
final Color foregroundColor = Color(0xFFFFFFFF);

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
  textTheme: GoogleFonts.poppinsTextTheme(),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: foregroundColor, // Définit la couleur du texte pour tous les TextButton
    ),
  ),
  scaffoldBackgroundColor: darkColor,
);