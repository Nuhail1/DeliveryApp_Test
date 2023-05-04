import 'package:flutter/material.dart';

class AppConstants {
  static const MaterialColor themeSwatch = MaterialColor(
    0xFF25343C,
    <int, Color>{
      50: themeColor,
      100: themeColor,
      200: themeColor,
      300: themeColor,
      400: themeColor,
      500: themeColor,
      600: themeColor,
      700: themeColor,
      800: themeColor,
      900: themeColor
    },
  );
  static const Color themeColor = Color(0xFF25343C);
  static const Color backgroundColor = Color(0xFFEEEEEE);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);

  static const defSpace = SizedBox(height: 12, width: 12);
  static const secSpace = SizedBox(height: 24, width: 24);
  static const loginVerSpace = SizedBox(height: 32);

}
