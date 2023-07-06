import 'package:flutter/material.dart';
import 'package:svg_clip/svg_clip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Svg Mask'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgClip(
                asset: ClipAsset.local(path: _getAssetPath(1)),
                child: const _ColoredBox(
                    color: Colors.green, width: 300, height: 100)),
            const SizedBox(
              height: 50,
            ),
            SvgClip(
                asset: ClipAsset.local(path: _getAssetPath(2)),
                child: const _ColoredBox(
                    color: Color(0xFF5A9098), width: 300, height: 200)),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  static String _getAssetPath(int clip) => "assets/images/clip$clip.svg";
}

class _ColoredBox extends StatelessWidget {
  final Widget? child;
  final Color color;
  final double width;
  final double height;

  const _ColoredBox(
      {super.key,
      this.child,
      required this.color,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }
}
