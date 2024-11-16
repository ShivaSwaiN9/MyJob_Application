import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppColors {
  static const brightBackground = Color(0xfff8f8f8);
  static const darkBackground = Color(0xff3e3e3e);
  static const borderColor = Color(0xffcdcdcd);

  static const MaterialColor brightPrimary =
      MaterialColor(brightPrimaryValue, <int, Color>{
    50: Color(0xFFE5F1FF),
    100: Color(0xFFBEDCFF),
    200: Color(0xFF93C5FF),
    300: Color(0xFF67ADFF),
    400: Color(0xFF479CFF),
    500: Color(brightPrimaryValue),
    600: Color(0xFF2282FF),
    700: Color(0xFF1C77FF),
    800: Color(0xFF176DFF),
    900: Color(0xFF0D5AFF),
  });
  static const int brightPrimaryValue = 0xFF268AFF;
}
