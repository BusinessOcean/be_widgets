import 'dart:math' as math;

import 'package:flutter/material.dart';

extension FlexColorExtensions on Color {
  Color getRandomColor() {
    final random = math.Random();
    return Color.fromARGB(
      255, // Fully opaque
      random.nextInt(256), // Red (0-255)
      random.nextInt(256), // Green (0-255)
      random.nextInt(256), // Blue (0-255)
    );
  }
}
