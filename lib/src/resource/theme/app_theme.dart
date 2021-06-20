import 'package:flutter/material.dart';
import 'package:news_app/src/constants/color_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData darkTheme = ThemeData.dark();
  static ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    primaryColor: KColors.primary,
    accentColor: KColors.secondary,
    scaffoldBackgroundColor: KColors.white,
    colorScheme: ColorScheme.light(
      secondary:
          KColors.white, // on light theme surface = Colors.white by default
    ),
    backgroundColor: KColors.white,
    // inputDecorationTheme: inputDecorationTheme(false),
    iconTheme: IconThemeData(color: KColors.grey800),
    textTheme: GoogleFonts.robotoTextTheme().copyWith(
      headline1: _h11,
      headline2: _h12,
      headline3: _h14,
      headline4: _h16,
      headline5: _h18,
      headline6: _h20,
      bodyText1: _h24,
      bodyText2: _h30,
      overline: _h32,
    ),
  );

  static TextStyle _h11 = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );

  static TextStyle _h12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );

  static TextStyle _h14 = TextStyle(
    color: KColors.grey800,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle _h16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );
  static TextStyle _h18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );
  static TextStyle _h20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );
  static TextStyle _h24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );
  static TextStyle _h30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );
  static TextStyle _h32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: KColors.grey800,
  );
}
