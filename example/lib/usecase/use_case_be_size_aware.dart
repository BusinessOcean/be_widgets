import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeSizeAware', path: '/', type: BeSizeAware)
Widget renderBeSizeAwareWidget(final BuildContext context) {
  final useConstraints =
      context.knobs.boolean(label: 'Limit Size', initialValue: false);
  final minWidth = context.knobs.double
      .slider(label: 'Min Width', initialValue: 120, min: 80, max: 300);
  final minHeight = context.knobs.double
      .slider(label: 'Min Height', initialValue: 80, min: 60, max: 200);

  return Center(
    child: BeSizeAware(
      constraints: useConstraints
          ? BoxConstraints(
              minWidth: minWidth,
              minHeight: minHeight,
              maxWidth: minWidth + 80,
              maxHeight: minHeight + 60,
            )
          : null,
      builder: (size) {
        final isCompact = size.width < 180;
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.all(16),
            child: isCompact
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag, size: 32, color: Colors.teal),
                      SizedBox(height: 8),
                      Text('Compact Product',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  )
                : const Row(
                    children: [
                      Icon(Icons.shopping_bag, size: 48, color: Colors.teal),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text('Full Product Details',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
          ),
        );
      },
    ),
  );
}
