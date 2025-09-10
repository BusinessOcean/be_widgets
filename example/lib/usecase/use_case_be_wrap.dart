import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeWrap', path: '/', type: BeWrap)
Widget renderBeWrapWidget(final BuildContext context) {
  final spacing = context.knobs.double
      .slider(label: 'Spacing', initialValue: 12, min: -30, max: 32);
  final tagCount = context.knobs.int
      .slider(label: 'Tag Count', initialValue: 6, min: 3, max: 12);
  final tagColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal
  ];
  final tags = [
    'Flutter',
    'Dart',
    'UI',
    'Responsive',
    'Widget',
    'Mobile',
    'Web',
    'Desktop',
    'Open Source',
    'Community',
    'Performance',
    'Design'
  ];

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tag Cloud',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87)),
            const SizedBox(height: 12),
            BeWrap(
              spacing: spacing,
              children: List.generate(
                tagCount,
                (i) => Chip(
                  label: Text(tags[i % tags.length]),
                  backgroundColor:
                      tagColors[i % tagColors.length].withValues(alpha: 0.8),
                  labelStyle: TextStyle(color: Colors.grey[800]),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
