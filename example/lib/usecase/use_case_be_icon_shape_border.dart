import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
    name: 'BeIconShapeBorder', path: '/', type: BeIconShapeBorder)
Widget renderBeIconShapeBorderWidget(final BuildContext context) {
  final borderType = context.knobs.list(
    label: 'Border Type',
    options: BeIconAlignment.values,
    labelBuilder: (value) => value.toString().split('.').last,
  );
  final iconSize = context.knobs.double
      .slider(label: 'Icon Size', initialValue: 32, min: 16, max: 64);
  final borderRadius = context.knobs.double
      .slider(label: 'Border Radius', initialValue: 16, min: 0, max: 32);
  final borderColor = context.knobs.list(
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
      child: Icon(Icons.star, color: Colors.blue, size: iconSize),
    ),
  );
}
