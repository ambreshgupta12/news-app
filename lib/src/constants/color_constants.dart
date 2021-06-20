import 'package:flutter/material.dart';

// You can also just let this float around in the file without encapsulating
// in a class. Then you'll have to make sure that system wide you don't have
// duplicate variable names.
class KColors {


  // color - blue (primary)
  static const Color blue900 = Color(0xFF004ca1);
  static const Color blue800 = Color(0xFF016AC0);
  static const Color blue700 = Color(0xFF087bd2);

// color - grey (secondary)
  static const Color grey900 = Color(0xFF181818);
  static const Color grey800 = Color(0xFF383838);
  static const Color grey200 = Color(0xFFe7e7e7);
  static const Color grey = Colors.grey;

// Color Scheme

  static const Color primary = blue800;
  static const Color primaryVariant = blue700;
  static const Color secondary = grey200;
  static const Color white = Colors.white;
  static const Color pink = Colors.pink;

  static const Color summerSky = Color(0xFFEFF5F5);
  static const Color pigeonPostColor = Color(0xFFBBCDDC);
}
