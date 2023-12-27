import 'package:example/example/single_example.dart';
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
      body: const SingleExample(),
      // body: Container(
      //   margin: const EdgeInsets.symmetric(vertical: 45, horizontal: 100),
      //   child: ListView(
      //     children: const [
      //       InputLabel(),
      //       boxGap,
      //       InputLabelInnerRight(),
      //       boxGap,
      //       InputLabelRounded(),
      //       boxGap,
      //       InputLabelRoundedRegular()
      //     ],
      //   ),
      // ),
    );
  }
}

const SizedBox boxGap = SizedBox(
  height: 24,
);
