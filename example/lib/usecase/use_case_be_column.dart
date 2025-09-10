import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeColumn', path: '/', type: BeColumn)
Widget renderBeColumnWidget(final BuildContext context) {
  final cardCount = context.knobs.int
      .slider(label: 'Card Count', initialValue: 3, min: 1, max: 6);
  final spacing = context.knobs.double
      .slider(label: 'Spacing', initialValue: 16, min: 0, max: 32);
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: BeRow(
      spacing: spacing,
      children: List.generate(
          cardCount,
          (i) => BeColumn(
                order: 2,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.widgets, size: 32, color: Colors.blue),
                        const SizedBox(height: 12),
                        Text('Card ${i + 1}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('This is a responsive card using BeColumn.'),
                      ],
                    ),
                  ),
                ),
              )),
    ),
  );
}
