import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeMultiLabel', path: '/', type: BeMultiLabel)
Widget renderBeMultiLabelWidget(final BuildContext context) {
  final labelCount = context.knobs.int.slider(
      label: 'Label Count',
      initialValue: 2,
      min: 1,
      max: BeMultiLabelPosition.values.length);

  final labelColors = [Colors.blue, Colors.green, Colors.orange, Colors.purple];

  return Center(
    child: BeMultiLabel(
      labels: List.generate(
        labelCount,
        (i) => BeLabelChild(
          position: BeMultiLabelPosition
              .values[i % BeMultiLabelPosition.values.length],
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: labelColors[i % labelColors.length],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              i == 0
                  ? 'New'
                  : i == 1
                      ? 'Sale'
                      : 'L${i + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(16),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, size: 32, color: Colors.blue),
              SizedBox(height: 8),
              Text('Product', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    ),
  );
}
