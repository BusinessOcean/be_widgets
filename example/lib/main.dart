import 'package:be_widgets/be_widgets.dart';
import 'package:example/example/input_label.dart';
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
      // body: const SingleExample(),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 45, horizontal: 100),
        child: ListView(
          children: [
            BeBadge(
              badge: FloatingActionButton.small(
                backgroundColor: Colors.green,
                onPressed: () {},
                child: const Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                ),
              ),
              child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                      backgroundColor: MaterialStatePropertyAll(Colors.black)),
                  child: const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text("Button Widget",
                        style: TextStyle(color: Colors.white)),
                  )),
            ),
            boxGap,
            const InputLabel(),
            boxGap,
            const InputLabelInnerRight(),
            boxGap,
            const InputLabelRounded(),
            boxGap,
            const InputLabelRoundedRegular()
          ],
        ),
      ),
    );
  }
}

const SizedBox boxGap = SizedBox(
  height: 24,
);
