import 'package:flutter/material.dart';

class TeamMonitorColor {
  static Color get primaryColor1 => const Color(0xff274FB5);
  static Color get primaryColor2 => const Color(0xff74CAD6);

  static Color get secondaryColor1 => const Color(0xffEFADEC);
  static Color get secondaryColor2 => const Color(0xff7F30BC);

  static List<Color> get primaryG => [primaryColor2, primaryColor1];
  static List<Color> get secondaryG => [secondaryColor2, secondaryColor1];

  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xFF7D8888);

  static Color get white => Colors.white;
  static Color get mediumGray => const Color.fromARGB(255, 221, 234, 234);

  static Color get lightGray => const Color(0xffF7F8F8);

  static Color borderColor = const Color.fromARGB(255, 218, 209, 210);
  static Color borderColor1 = const Color.fromRGBO(248, 244, 245, 0.322);
  static Color blackColor = Colors.black;
}
