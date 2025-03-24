import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final MaterialColor customColor = MaterialColor(
  0xFFAABBFF,
  <int, Color>{
    50: Color(0xFFD3DCFF),
    100: Color(0xFFAABBFF),
    200: Color(0xFF80A7FF),
    300: Color(0xFF4D87FF),
    400: Color(0xFF266EFF),
    500: Color(0xFF3353CD),
    600: Color(0xFF1A4FBB),
    700: Color(0xFF153D99),
    800: Color(0xFF0F2B77),
    900: Color(0xFF0A1855),
  },
);

final ThemeData appTheme = ThemeData(
  primarySwatch: customColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.poppinsTextTheme(),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFAABBFF),
    textTheme: ButtonTextTheme.primary,
  ),
  scaffoldBackgroundColor: Color(0xFFD3DCFF),
);