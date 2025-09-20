import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeLabel', path: '/', type: BeLabel)
Widget renderBeLabelWidget(final BuildContext context) {
  final position = context.knobs.object
      .dropdown(label: 'Position', options: BeLabelPosition.values);
  final offsetX = context.knobs.double
      .slider(label: 'Offset X', initialValue: 0, min: -20, max: 20);
  final offsetY = context.knobs.double
      .slider(label: 'Offset Y', initialValue: 0, min: -20, max: 20);
  final childSized =
      context.knobs.boolean(label: 'Child Sized', initialValue: false);
  final innerLabel =
      context.knobs.boolean(label: 'Inner Label', initialValue: false);

  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('BeLabel Examples:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Center(
          child: BeLabel(
            position: position,
            offset: Offset(offsetX, offsetY),
            childSized: childSized,
            innerLabel: innerLabel,
            label: Container(
              width: childSized ? double.infinity : null,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Label',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            child: Container(
              width: 120,
              height: 80,
              color: Colors.blue.shade100,
              child: const Center(child: Text('Main Widget')),
            ),
          ),
        ),
        const SizedBox(height: 32),
        const Text('Practical Use Cases:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            BeLabel(
              position: BeLabelPosition.topRight,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('Online',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
              child: const Icon(Icons.person, size: 48, color: Colors.blue),
            ),
            BeLabel(
              position: BeLabelPosition.bottomLeft,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(8)),
                child: const Text('Sale',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
              child: const Icon(Icons.shopping_cart,
                  size: 48, color: Colors.orange),
            ),
            BeLabel(
              position: BeLabelPosition.topLeft,
              label: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text('New',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
              child: const Icon(Icons.message, size: 48, color: Colors.purple),
            ),
          ],
        ),
        const SizedBox(height: 32),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('All Label Positions:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: BeLabelPosition.values.map((final pos) {
                    return BeLabel(
                      position: pos,
                      label: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(pos.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 8)),
                      ),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(pos.name,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey))),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
