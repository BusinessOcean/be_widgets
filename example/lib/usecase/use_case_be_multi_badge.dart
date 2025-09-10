import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'BeMultiBadge', path: '/', type: BeMultiBadge)
Widget renderBeMultiBadgeWidget(final BuildContext context) {
  final badgeCount = context.knobs.int.slider(
      label: 'Badge Count',
      initialValue: 3,
      min: 1,
      max: BeMultiBadgePosition.values.length);

  final badgeColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple
  ];

  return Center(
    child: BeMultiBadge(
      labels: List.generate(
          badgeCount,
          (i) => BeBadgeChild(
                position: BeMultiBadgePosition
                    .values[i % BeMultiBadgePosition.values.length],
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: badgeColors[i % badgeColors.length],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    i == 0
                        ? 'Admin'
                        : i == 1
                            ? 'Online'
                            : 'B${i + 1}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              )),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.shade100,
          image: const DecorationImage(
            image:
                NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}
