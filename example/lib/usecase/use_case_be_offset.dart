import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeOffset', path: '/', type: BeOffset)
Widget renderBeOffsetWidget(final BuildContext context) {
  final offsetX = context.knobs.double
      .slider(label: 'Offset X', initialValue: 0, min: -150, max: 150);
  final offsetY = context.knobs.double
      .slider(label: 'Offset Y', initialValue: -80, min: -150, max: 150);
  final showBanner =
      context.knobs.boolean(label: 'Show Notification', initialValue: true);

  return Stack(
    children: [
      Center(
        child:
            Text('Main Content', style: Theme.of(context).textTheme.titleLarge),
      ),
      if (showBanner)
        BeOffset(
          offset: Offset(offsetX, offsetY),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 280,
              margin: const EdgeInsets.only(top: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Your changes have been saved!',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    ],
  );
}
