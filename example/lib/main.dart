import 'dart:math';

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
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const DashboardExample(),
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
  late bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: const SingleExample(),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          // color: getRandomColor().lighten(0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                ...BeIconAlignment.values.map(
                  (v) => Container(
                    width: 400,
                    height: 200,
                    decoration: ShapeDecoration(
                      color: getRandomColor(withOpacity: true),
                      shape: BeIconShapeBorder(
                        icon: iconList[Random().nextInt(iconList.length)],
                        size: Random().nextInt(48) + 12.0,
                        radius: 8,
                        color: getRandomColor(),
                        width: 2,
                        alignment: v,
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Hello BeIconShapeBorder",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color getRandomColor({bool withOpacity = false}) {
  final random = Random();
  return Color.fromARGB(
    withOpacity ? random.nextInt(256) : 255, // Alpha
    random.nextInt(256), // Red
    random.nextInt(256), // Green
    random.nextInt(256), // Blue
  );
}

const iconList = [
  Icons.add_box,
  Icons.add_circle,
  Icons.add_circle_outline,
  Icons.add_location,
  Icons.add_location_alt,
  Icons.add_moderator,
  Icons.add_photo_alternate,
  Icons.add_reaction,
  Icons.add_road,
  Icons.add_shopping_cart,
  Icons.add_task,
  Icons.add_to_drive,
  Icons.add_to_home_screen,
];
