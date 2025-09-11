import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeContainer', path: '/', type: BeContainer)
Widget renderBeContainerWidget(final BuildContext context) {
  final padding = context.knobs.double
      .slider(label: 'Padding', initialValue: 24, min: 0, max: 64);
  final alignment = context.knobs.object.dropdown<Alignment>(
    label: 'Alignment',
    options: [
      Alignment.center,
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ],
    labelBuilder: (value) {
      if (value == Alignment.center) return 'Center';
      if (value == Alignment.topLeft) return 'Top Left';
      if (value == Alignment.topRight) return 'Top Right';
      if (value == Alignment.bottomLeft) return 'Bottom Left';
      if (value == Alignment.bottomRight) return 'Bottom Right';
      return 'Alignment';
    },
  );

  return Center(
    child: BeContainer(
      alignment: alignment,
      padding: EdgeInsets.all(padding),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.inbox, size: 48, color: Colors.blue),
              SizedBox(height: 16),
              Text('BeContainer Example',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('This card is wrapped in a responsive BeContainer.'),
            ],
          ),
        ),
      ),
    ),
  );
}
