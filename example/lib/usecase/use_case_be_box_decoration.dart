import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeBoxDecoration', path: '/', type: BeBoxDecoration)
Widget renderBeBoxDecorationWidget(final BuildContext context) {
  final cardColor = context.knobs.object.dropdown(
    label: 'Card Color',
    options: [
      Colors.white,
      const Color(0xFFF5F5F5),
      Colors.blue[50]!,
      Colors.purple[50]!,
      Colors.green[50]!,
    ],
    labelBuilder: (value) {
      if (value == Colors.white) return 'White';
      if (value == const Color(0xFFF5F5F5)) return 'Light Grey';
      if (value == Colors.blue[50]) return 'Blue Tint';
      if (value == Colors.purple[50]) return 'Purple Tint';
      if (value == Colors.green[50]) return 'Green Tint';
      return 'Color';
    },
  );

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

  final borderRadius = context.knobs.doubleOrNull
      .slider(label: 'Border Radius', min: 0, max: 40, initialValue: 16);
  final blurRadius = context.knobs.doubleOrNull
      .slider(label: 'Shadow Blur', min: 0, max: 40, initialValue: 12);
  final yOffset = context.knobs.doubleOrNull
      .slider(label: 'Shadow Y Offset', min: -20, max: 40, initialValue: 6);
  final xOffset = context.knobs.doubleOrNull
      .slider(label: 'Shadow X Offset', min: -20, max: 20, initialValue: 0);
  final spreadRadius = context.knobs.doubleOrNull
      .slider(label: 'Spread Radius', min: -10, max: 20, initialValue: 0);
  final insetShadow =
      context.knobs.boolean(label: 'Inset Shadow', initialValue: false);

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(32),
        decoration: BeBoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
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
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BeBoxDecoration(
                color: Colors.blue.withAlpha((0.1 * 255).toInt()),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BeBoxShadow(
                    color: Colors.blue.withAlpha((0.2 * 255).toInt()),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Icon(Icons.palette, size: 40, color: Colors.blue),
            ),
            const SizedBox(height: 24),
            const Text('Interactive Playground',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Experiment with different shadow properties, colors, and border radius to see how BeBoxDecoration can transform your UI components.',
              textAlign: TextAlign.center,
              maxLines: 4,
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BeBoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BeBoxShadow(
                          color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          inset: true,
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.brush, color: Colors.orange, size: 24),
                        SizedBox(height: 8),
                        Text('Customizable',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BeBoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BeBoxShadow(
                          color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                          inset: true,
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.flash_on, color: Colors.purple, size: 24),
                        SizedBox(height: 8),
                        Text('Performant',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
