import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeTextMore', path: '/', type: BeTextMore)
Widget renderBeTextMoreWidget(final BuildContext context) {
  final description = context.knobs.string(
    label: 'Product Description',
    initialValue:
        'This is a premium product with many features. It is designed for modern users who value quality, reliability, and style. The product comes with a 2-year warranty and 24/7 customer support. You can use it in various environments and it adapts to your needs. For more details, expand this section.',
  );
  final trimLines = context.knobs.int
      .slider(label: 'Trim Lines', initialValue: 3, min: 1, max: 6);
  final fontSize = context.knobs.double
      .slider(label: 'Font Size', initialValue: 16, min: 12, max: 24);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Product Description',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            BeTextMore(
              text: description,
              trimLines: trimLines,
              trimExpandedText: 'Show less',
              trimCollapsedText: 'Show more',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    ),
  );
}
