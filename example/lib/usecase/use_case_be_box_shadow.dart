import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeBoxShadow', path: '/', type: BeBoxShadow)
Widget renderBeBoxShadowWidget(final BuildContext context) {
  final shadowColor = context.knobs.object.dropdown(
    label: 'Shadow Color',
    options: [
      Colors.grey,
      Colors.blue,
      Colors.purple,
      Colors.black26,
      Colors.black,
    ],
    labelBuilder: (value) {
      if (value == Colors.grey) return 'Grey';
      if (value == Colors.blue) return 'Blue';
      if (value == Colors.purple) return 'Purple';
      if (value == Colors.black26) return 'Black';
      if (value == Colors.black) return 'Primary';
      return 'Color';
    },
  );

  final blurRadius = context.knobs.doubleOrNull
      .slider(label: 'Blur Radius', min: 0, max: 40, initialValue: 12);
  final yOffset = context.knobs.doubleOrNull
      .slider(label: 'Y Offset', min: -20, max: 40, initialValue: 6);
  final xOffset = context.knobs.doubleOrNull
      .slider(label: 'X Offset', min: -20, max: 20, initialValue: 0);
  final spreadRadius = context.knobs.doubleOrNull
      .slider(label: 'Spread Radius', min: -10, max: 20, initialValue: 0);
  final insetShadow =
      context.knobs.boolean(label: 'Inset Shadow', initialValue: false);

  return Center(
    child: Container(
      width: 200,
      height: 120,
      decoration: BeBoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BeBoxShadow(
            color: shadowColor.withAlpha((0.3 * 255).toInt()),
            offset: Offset(xOffset ?? 0, yOffset ?? 6),
            blurRadius: blurRadius ?? 12,
            spreadRadius: spreadRadius ?? 0,
            inset: insetShadow,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'BeBoxShadow Example',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
