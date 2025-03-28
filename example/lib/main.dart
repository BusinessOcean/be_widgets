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
          child: Column(
            children: [
              // BeTextMore(
              //   text:
              //       'Culpa tempor laborum eu quis est laborum qui dolor laborum '
              //       'dolor consectetur culpa. Dolore ea pariatur mollit ipsum'
              //       ' exercitation excepteur et. Dolore duis id in voluptate laboris'
              //       ' commodo qui fugiat quis. Sunt mollit do minim reprehenderit pariatur '
              //       'deserunt quis. Anim duis laboris pariatur incididunt ex velit cupidatat '
              //       'cillum qui. Amet pariatur laboris occaecat nostrud aliqua dolor aliqua. '
              //       'Enim ex consequat dolor elit. Aliquip ipsum do ad in pariatur deserunt'
              //       ' consequat commodo magna sint. Ex et excepteur magna laboris ad consequat'
              //       ' ex reprehenderit magna ullamco veniam. Elit Lorem voluptate ut culpa aliquip '
              //       'irure reprehenderit incididunt magna culpa. Consequat proident nulla id magna'
              //       ' cillum voluptate exercitation quis dolore eu. Reprehenderit non aliqua laborum'
              //       ' consectetur pariatur tempor cupidatat incididunt enim.',
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Colors.grey.shade200,
              //   ),
              //   maxLines: 3,
              // )
              // Row(
              //   children: [
              //     Container(
              //       width: 200,
              //       height: 200,
              //       decoration: const BeBoxDecoration(
              //         color: Colors.white,
              //         shape: BoxShape.circle,
              //         boxShadow: [
              //           BeBoxShadow(
              //             color: Colors.black26,
              //             offset: Offset(4, 4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: false,
              //           ),
              //           BeBoxShadow(
              //             color: Colors.white24,
              //             offset: Offset(-4, -4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: true,
              //           ),
              //         ],
              //       ),
              //       child: const Center(
              //         child: Text(
              //           'Hello, BeBox!',
              //           style: TextStyle(color: Colors.black, fontSize: 18),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: 200,
              //       height: 200,
              //       decoration: const BeBoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         boxShadow: [
              //           BeBoxShadow(
              //             color: Colors.black26,
              //             offset: Offset(4, 4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: false,
              //           ),
              //           BeBoxShadow(
              //             color: Colors.white24,
              //             offset: Offset(-4, -4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: true,
              //           ),
              //         ],
              //       ),
              //       child: const Center(
              //         child: Text(
              //           'Hello, BeBox!',
              //           style: TextStyle(color: Colors.black, fontSize: 18),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: 200,
              //       height: 200,
              //       decoration: BeBoxDecoration(
              //         color: Colors.white,
              //         borderRadius: const BorderRadius.all(Radius.circular(20)),
              //         boxShadow: [
              //           const BeBoxShadow(
              //             color: Colors.blue,
              //             offset: Offset(4, 4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //           ),
              //           BeBoxShadow(
              //             color: Colors.red.shade200,
              //             offset: const Offset(-4, -4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //           ),
              //           BeBoxShadow(
              //             color: Colors.yellow.shade200,
              //             offset: const Offset(0, -4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //           ),
              //         ],
              //       ),
              //       child: const Center(
              //         child: Text(
              //           'Hello, BeBox!',
              //           style: TextStyle(color: Colors.black, fontSize: 18),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Container(
              //       width: 200,
              //       height: 200,
              //       decoration: const BeBoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         boxShadow: [
              //           BeBoxShadow(
              //             color: Colors.black26,
              //             offset: Offset(4, 4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: false,
              //           ),
              //           BeBoxShadow(
              //             color: Colors.red,
              //             offset: Offset(-4, -4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: true,
              //           ),
              //         ],
              //       ),
              //       child: const Center(
              //         child: Padding(
              //           padding: EdgeInsets.all(8.0),
              //           child: Text(
              //             'Hello, BeBox! with inset shadow',
              //             style: TextStyle(color: Colors.black, fontSize: 18),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Container(
              //       width: 200,
              //       height: 200,
              //       decoration: const BeBoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         boxShadow: [
              //           BeBoxShadow(
              //             color: Colors.black26,
              //             offset: Offset(4, 4),
              //             blurRadius: 10,
              //             spreadRadius: 2,
              //             inset: false,
              //           ),
              //           BeBoxShadow(
              //             color: Colors.black12,
              //             offset: Offset(4, 4),
              //             blurRadius: 10,
              //             spreadRadius: 20,
              //           ),
              //         ],
              //       ),
              //       child: const Center(
              //         child: Padding(
              //           padding: EdgeInsets.all(8.0),
              //           child: Text(
              //             'Shadow with donest disturb other layout width',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(color: Colors.black, fontSize: 18),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              ...BeIconAlignment.values.map(
                (v) => Container(
                  width: 400,
                  height: 200,
                  decoration: ShapeDecoration(
                    shape: BeIconShapeBorder(
                      icon: Icons.add_box,
                      size: 46,
                      radius: 8,
                      color: Colors.grey,
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
    );
  }
}
