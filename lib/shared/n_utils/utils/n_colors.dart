import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color customShade(double shade) {
    final formattedShade = (shade / 100) * -1;
    assert(shade >= -900 && shade <= 900, 'Should be between -900 and 900');
    final hslColor = HSLColor.fromColor(this);
    final double lightnessAdjustment = formattedShade * 0.1;
    final newLightness =
        (hslColor.lightness + lightnessAdjustment).clamp(0.0, 1.0);
    return hslColor.withLightness(newLightness).toColor();
  }

  Color withMix(Color other, double percentage) {
    final r = (red * (1 - percentage) + other.red * percentage).round();
    final g = (green * (1 - percentage) + other.green * percentage).round();
    final b = (blue * (1 - percentage) + other.blue * percentage).round();
    final a = (alpha * (1 - percentage) + other.alpha * percentage).round();
    return Color.fromRGBO(r, g, b, a / 255);
  }
}
