import 'package:flutter/material.dart';

class AppConstants {
  final appColor = const Color(0xFF652D90);
  final appPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 10);

  // Gradient
  final greenBlueGradient = const LinearGradient(colors: [
    Color.fromARGB(255, 33, 176, 76),
    Color.fromARGB(255, 23, 82, 163),
  ]);

  // box shadow
  final boxShadow = const BoxShadow(
    color: Color.fromARGB(64, 0, 0, 0),
    offset: Offset(0, 3),
    blurRadius: 10,
    blurStyle: BlurStyle.inner,
  );
}
