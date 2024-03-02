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
      // body: const SingleExample(),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            children: [
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 150,
                child: const Text(
                  "I Got drawn first so I am behind\n I am regular container with height 150 like other",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              BeOffset(
                offset: const Offset(-50, -100),
                child: Container(
                  color: Colors.blue,
                  height: 150,
                  child: InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('BeOffset Got clicked!!!1'),
                        ),
                      );
                    },
                    child: const Center(
                      child: Text(
                        "Child with offset by BeOffset\n I am also size of Orange and Black Tile\n in column with offset: const Offset(-50, -100)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.orange,
                height: 150,
                child: const Center(
                  child: Text(
                    "I regular container but adjusted with offset \n Also blue container push me down if const Offset( 0, 100),\n Imagine you have build this with existing widget\n give it a try",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const BeTextMore(
                  'Culpa tempor laborum eu quis est laborum qui dolor laborum dolor consectetur culpa. Dolore ea pariatur mollit ipsum exercitation excepteur et. Dolore duis id in voluptate laboris commodo qui fugiat quis. Sunt mollit do minim reprehenderit pariatur deserunt quis. Anim duis laboris pariatur incididunt ex velit cupidatat cillum qui. Amet pariatur laboris occaecat nostrud aliqua dolor aliqua. Enim ex consequat dolor elit. Aliquip ipsum do ad in pariatur deserunt consequat commodo magna sint. Ex et excepteur magna laboris ad consequat ex reprehenderit magna ullamco veniam. Elit Lorem voluptate ut culpa aliquip irure reprehenderit incididunt magna culpa. Consequat proident nulla id magna cillum voluptate exercitation quis dolore eu. Reprehenderit non aliqua laborum consectetur pariatur tempor cupidatat incididunt enim.'),
              // Container(
              //   color: Colors.red,
              //   height: 50,
              //   child: const Center(
              //     child: Text(
              //       "LAST ITEM IN COLUMN",
              //       textAlign: TextAlign.center,
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 14,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),

      // body: Container(
      //   margin: const EdgeInsets.symmetric(vertical: 45, horizontal: 100),
      //   child: ListView(
      //     children: [
      //       BeBadge(
      //         badge: FloatingActionButton.small(
      //           backgroundColor: Colors.green,
      //           onPressed: () {},
      //           child: const Icon(
      //             Icons.notifications_active,
      //             color: Colors.white,
      //           ),
      //         ),
      //         child: ElevatedButton(
      //             onPressed: () {},
      //             style: const ButtonStyle(
      //                 shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.all(Radius.circular(8)))),
      //                 backgroundColor: MaterialStatePropertyAll(Colors.black)),
      //             child: const Padding(
      //               padding: EdgeInsets.all(18.0),
      //               child: Text("Button Widget",
      //                   style: TextStyle(color: Colors.white)),
      //             )),
      //       ),
      //       boxGap,
      //       const InputLabel(),
      //       boxGap,
      //       const InputLabelInnerRight(),
      //       boxGap,
      //       const InputLabelRounded(),
      //       boxGap,
      //       const InputLabelRoundedRegular(),
      //     ],
      //   ),
      // ),
    );
  }
}

const SizedBox boxGap = SizedBox(
  height: 24,
);
