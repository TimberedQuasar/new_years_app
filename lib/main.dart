import 'package:flutter/material.dart';
import 'package:where_sylwester/features/countdown/countdown_banner.dart';
import 'package:where_sylwester/features/input/location_input.dart';
import 'package:where_sylwester/features/notifications/winner_is.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Center(child: Text(widget.title)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CountdownBanner(),
                //const SizedBox(height: 5),
                Expanded(child: Stack(children: [AnimatedWheel()])),
                //const SizedBox(height: 24),
                LocationInput(
                  enabled: true, // ustaw na false po deadlinie
                  onSubmit: (value) {
                    // TODO: dodaj do listy miejsc i odśwież koło
                  },
                ),
                SizedBox(height: 24),
                WinnerIs(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
