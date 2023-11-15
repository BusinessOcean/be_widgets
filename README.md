<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

1.Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features


2.List what your package can do. Maybe include images, gifs, or videos.

## Screenshot
  ![Alt text](./screenshots/screen-shot-1.png")

## Getting started

3.List prerequisites and provide or point to information on how to
start using the package.

## Usage

4.Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart

import 'dart:math' as math;

import 'package:be_widgets/be_widgets.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BeLabel(
                label: const Text('Woman').prityWrap(padding: 4),
                child: const Text(
                  "I am label as woman",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ).prityWrap(),
              ),
              const SizedBox(height: 45),
              BeBadge(
                badge: const Text('Woman').prityWrap(padding: 4),
                child: const Text(
                  "I am label as woman",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ).prityWrap(padding: 1),
                  ),
                  BeLabelChild(
                    position: BeMultiLabelPosition.topCenter,
                    child: const Text(
                      'Woman',
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                    ).prityWrap(padding: 2),
                  )
                ],
                child: const Text(
                  "I am label as woman",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ).prityWrap(padding: 1),
                  ),
                  BeBadgeChild(
                    position: BeMultiBadgePosition.topCenter,
                    child: const Text(
                      'Woman',
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                    ).prityWrap(padding: 2),
                  )
                ],
                child: const Text(
                  "I am label as woman",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ).prityWrap(),
              ),
            ]),
      ),
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



```

## Additional information

5..Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
