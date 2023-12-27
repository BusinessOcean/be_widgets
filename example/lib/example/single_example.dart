import 'dart:math' as math;

import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';

class SingleExample extends StatelessWidget {
  const SingleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BeLabel(
              label: const Text('Woman').prityWrap(padding: 4),
              child: const Text(
                "I am label as woman",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prityWrap(),
            ),
            const SizedBox(height: 45),
            BeBadge(
              badge: const Text('Woman').prityWrap(padding: 4),
              child: const Text(
                "I am label as woman",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prityWrap(),
            ),
            const SizedBox(height: 45),
            BeMultiLabel(
              labels: [
                BeLabelChild(
                  position: BeMultiLabelPosition.rightBottom,
                  child: const Text('Woman').prityWrap(padding: 4),
                ),
                BeLabelChild(
                  position: BeMultiLabelPosition.leftBottom,
                  child: const Text(
                    'Woman',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ).prityWrap(padding: 1),
                ),
                BeLabelChild(
                  position: BeMultiLabelPosition.topCenter,
                  child: const Text(
                    'Woman',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  ).prityWrap(padding: 2),
                )
              ],
              child: const Text(
                "I am label as woman",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prityWrap(),
            ),
            const SizedBox(height: 45),
            BeMultiBadge(
              labels: [
                BeBadgeChild(
                  position: BeMultiBadgePosition.topLeft,
                  child: const Text('Woman').prityWrap(padding: 4),
                ),
                BeBadgeChild(
                  position: BeMultiBadgePosition.topRight,
                  child: const Text(
                    'Woman',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ).prityWrap(padding: 1),
                ),
                BeBadgeChild(
                  position: BeMultiBadgePosition.topCenter,
                  child: const Text(
                    'Woman',
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                  ).prityWrap(padding: 2),
                )
              ],
              child: const Text(
                "I am label as woman",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prityWrap(),
            ),
          ]),
    );
  }
}

extension _Widget on Widget {
  Widget prityWrap({
    double padding = 16,
    double radius = 8,
    double margin = 0,
    Color? color,
  }) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          color: color ?? randomColor(),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: this,
    );
  }
}

Color randomColor() =>
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
