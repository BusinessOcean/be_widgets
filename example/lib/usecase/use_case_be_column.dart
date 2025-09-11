import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeColumn', path: '/', type: BeColumn)
Widget renderBeColumnWidget(final BuildContext context) {
  final cardCount = context.knobs.int
      .slider(label: 'Card Count', initialValue: 2, min: 1, max: 4);
  final spacing = context.knobs.double
      .slider(label: 'Row Spacing', initialValue: 16, min: 0, max: 32);
  final xs =
      context.knobs.int.slider(label: 'xs', initialValue: 12, min: 1, max: 12);
  final sm =
      context.knobs.int.slider(label: 'sm', initialValue: 6, min: 1, max: 12);
  final md =
      context.knobs.int.slider(label: 'md', initialValue: 4, min: 1, max: 12);
  final lg =
      context.knobs.int.slider(label: 'lg', initialValue: 3, min: 1, max: 12);
  final xl =
      context.knobs.int.slider(label: 'xl', initialValue: 2, min: 1, max: 12);
  final xl2 =
      context.knobs.int.slider(label: 'xl2', initialValue: 1, min: 1, max: 12);
  final offset = context.knobs.int
      .slider(label: 'Offset', initialValue: 0, min: 0, max: 6);
  final order =
      context.knobs.int.slider(label: 'Order', initialValue: 1, min: 1, max: 6);

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: BeRow(
      spacing: spacing,
      children: List.generate(
        cardCount,
        (i) => BeColumn(
          xs: xs,
          sm: sm,
          md: md,
          lg: lg,
          xl: xl,
          xl2: xl2,
          offset: offset,
          order: order + i,
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.dashboard, size: 32, color: Colors.blue[700]),
                  const SizedBox(height: 12),
                  Text('Dashboard Card ${i + 1}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Order: ${order + i}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                      'xs:$xs sm:$sm md:$md lg:$lg xl:$xl xl2:$xl2 offset:$offset',
                      style: const TextStyle(fontSize: 10)),
                  const SizedBox(height: 8),
                  const Text(
                      'This card layout is responsive and customizable.'),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
