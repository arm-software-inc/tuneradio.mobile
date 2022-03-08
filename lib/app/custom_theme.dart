import 'package:flutter/material.dart';

class CustomTheme {
  static List<Color> get buttomGradient => [
    const Color(0xAA4D1ABC).withOpacity(.5),
    Colors.purpleAccent.withOpacity(.5),
    Colors.purpleAccent,
  ];

  static Color get stationBackground => Colors.purpleAccent.withOpacity(.05);
}