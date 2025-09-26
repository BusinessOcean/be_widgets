import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'BeIconShapeBorder', path: '/', type: BeIconShapeBorder)
Widget renderBeIconShapeBorderWidget(final BuildContext context) {
  final borderType = context.knobs.object.dropdown(
    label: 'Border Type',
    options: BeIconAlignment.values,
    labelBuilder: (value) => value.toString().split('.').last,
  );
  final iconSize = context.knobs.double
      .slider(label: 'Icon Size', initialValue: 32, min: 16, max: 64);
  final borderRadius = context.knobs.double
      .slider(label: 'Border Radius', initialValue: 16, min: 0, max: 32);
  final borderColor = context.knobs.object.dropdown(
    label: 'Border Color',
    options: [
      Colors.blue,
      Colors.purple,
      Colors.green,
      Colors.orange,
      Colors.black
    ],
    labelBuilder: (value) {
      if (value == Colors.blue) return 'Blue';
      if (value == Colors.purple) return 'Purple';
      if (value == Colors.green) return 'Green';
      if (value == Colors.orange) return 'Orange';
      if (value == Colors.black) return 'Black';
      return 'Color';
    },
  );

  final childSized =
      context.knobs.boolean(label: 'Static Example', initialValue: false);

  if (childSized) return const BeIconShapeBorderUseCase();

  return Center(
    child: Container(
      width: 120,
      height: 120,
      decoration: ShapeDecoration(
        color: Colors.blue[50],
        shape: BeIconShapeBorder(
          icon: Icons.star,
          alignment: borderType,
          size: iconSize,
          radius: borderRadius,
          color: borderColor,
          width: 3.0,
        ),
      ),
      child: Icon(Icons.star, color: Colors.red, size: iconSize),
    ),
  );
}

class BeIconShapeBorderUseCase extends StatelessWidget {
  const BeIconShapeBorderUseCase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BeIconShapeBorder Use Case'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example 1: Success Icon with Green Border
            Container(
              width: 100,
              height: 100,
              decoration: const ShapeDecoration(
                shape: BeIconShapeBorder(
                  icon: Icons.check,
                  color: Colors.green,
                  radius: 12,
                  width: 3,
                  alignment: BeIconAlignment.center,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Example 2: Warning Icon with Orange Border
            Container(
              width: 100,
              height: 100,
              decoration: const ShapeDecoration(
                shape: BeIconShapeBorder(
                  icon: Icons.warning,
                  color: Colors.orange,
                  radius: 12,
                  width: 3,
                  alignment: BeIconAlignment.center,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Example 3: Error Icon with Red Border
            Container(
              width: 100,
              height: 100,
              decoration: const ShapeDecoration(
                shape: BeIconShapeBorder(
                  icon: Icons.error,
                  color: Colors.red,
                  radius: 12,
                  width: 3,
                  alignment: BeIconAlignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BeIconShapeBorderUseCase(),
  ));
}
