import 'package:flutter/material.dart';
import 'package:where_sylwester/features/countdown/countdown_banner.dart';
import 'package:where_sylwester/features/wheel/wheel_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where Sylwester?',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Where Sylwester?'),
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
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            CountdownBanner(),
            Expanded(child: Stack(children: [AnimatedWheel()])),
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Row(
                children: [
                  Expanded(child: TextField()),
                  SizedBox(width: 12),
                  //ElevatedButton(onPressed: set, child: child)
                ],
              ),
            ),
            SizedBox(height: 24),
            Text("Hello"),
          ],
        ),
      ),
    );
  }
}
