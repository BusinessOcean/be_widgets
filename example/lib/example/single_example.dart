import 'dart:math' as math;

import 'package:be_widgets/be_widgets.dart';
import 'package:example/utils.dart';
import 'package:flutter/material.dart';

const textStyle = TextStyle(color: Colors.white, fontSize: 12);

class SingleExample extends StatelessWidget {
  const SingleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BeLabel(
              label: Text(
                'Woman',
                style: TextStyle(color: textColorFromBackground(Colors.green)),
              ).prettyWrap(padding: 4, color: Colors.blue.shade800),
              child: Text(
                "I label as woman",
                style: TextStyle(
                    color: textColorFromBackground(Colors.green),
                    fontWeight: FontWeight.bold),
              ).prettyWrap(color: Colors.green),
            ),
            const SizedBox(height: 45),
            BeBadge(
              badge: const Text('Woman').prettyWrap(padding: 4),
              child: const Text(
                "I Have been badged as woman",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prettyWrap(),
            ),
            const SizedBox(height: 45),
            BeMultiLabel(
              labels: [
                const BeLabelChild(
                  position: BeMultiLabelPosition.rightBottom,
                  offset: Offset(-30, 0),
                  child: Card(
                    color: Colors.orange,
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Woman elevated',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                BeLabelChild(
                  position: BeMultiLabelPosition.leftCenter,
                  child: const Text(
                    'Are you\n Woman',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ).prettyWrap(padding: 1),
                ),
                BeLabelChild(
                  position: BeMultiLabelPosition.topCenter,
                  offset: const Offset(0, 8),
                  child: const Text(
                    'Maybe woman 50/50',
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                        color: Colors.white),
                  ).prettyWrap(padding: 2),
                )
              ],
              child: const Text(
                "To many people label me as woman\n and big and small all around me",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prettyWrap(),
            ),
            const SizedBox(height: 45),
            BeMultiBadge(
              labels: [
                BeBadgeChild(
                  position: BeMultiBadgePosition.topLeft,
                  child: Card(
                    elevation: 8,
                    child: const Text(
                      'Left Woman',
                      style: TextStyle(color: Colors.white),
                    ).prettyWrap(padding: 4),
                  ),
                ),
                BeBadgeChild(
                  position: BeMultiBadgePosition.topRight,
                  child: FloatingActionButton.small(
                      onPressed: () {},
                      child: const Icon(Icons.pregnant_woman_outlined)),
                ),
                BeBadgeChild(
                  position: BeMultiBadgePosition.bottomRight,
                  child: Row(
                    children: [
                      const Card(
                          color: Colors.orange,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.rowing_sharp),
                          )),
                      const Text(
                        'Lets Live\n as Human',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                            fontSize: 12),
                      ).prettyWrap(padding: 2),
                    ],
                  ),
                )
              ],
              child: const Text(
                "Badging around me \nleft right corner as women",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ).prettyWrap(),
            ),
          ]),
    );
  }
}

extension _Widget on Widget {
  Widget prettyWrap({
    double padding = 16,
    double radius = 8,
    double margin = 0,
    Color? color,
  }) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.symmetric(
          vertical: padding, horizontal: padding * 1.2 + 2),
      decoration: BoxDecoration(
          color: color ?? randomColor().darken(10),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: this,
    );
  }
}

Color randomColor() =>
    Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withAlpha(150);
