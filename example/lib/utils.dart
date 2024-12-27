import 'dart:math' as math;

import 'package:flutter/material.dart';

extension FlexColorExtensions on Color {
  /// Brightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color brighten([int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    final color = Color.fromARGB(
      a.toInt(),
      math.max(0, math.min(255, r - (255 * -(amount / 100)).round()).toInt()),
      math.max(0, math.min(255, g - (255 * -(amount / 100)).round()).toInt()),
      math.max(0, math.min(255, b - (255 * -(amount / 100)).round()).toInt()),
    );
    return color;
  }

  /// Lightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color lighten([int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    // HSLColor returns saturation 1 for black, we want 0 instead to be able
    // lighten black color up along the grey scale from black.
    final hsl = this == const Color(0xFF000000)
        ? HSLColor.fromColor(this).withSaturation(0)
        : HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness + amount / 100)))
        .toColor();
  }

  /// Darkens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color darken([int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.black;
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness - amount / 100)))
        .toColor();
  }
}

/// Gets the text color based on a background color brightness
Color textColorFromBackground(Color background) =>
    getBrightness(background) == Brightness.light
        ? Colors.blueGrey.shade800
        : Colors.grey.shade100;

/// Gets brightness of a color (dark/light)
Brightness getBrightness(Color color) {
  final relativeLuminance = color.computeLuminance();
  const kThreshold = 0.15;
  return ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold)
      ? Brightness.light
      : Brightness.dark;
}

Color getRandomColor() {
  final random = math.Random();
  return Color.fromARGB(
    255, // Fully opaque
    random.nextInt(256), // Red (0-255)
    random.nextInt(256), // Green (0-255)
    random.nextInt(256), // Blue (0-255)
  );
}
