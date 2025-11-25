import 'package:flutter/material.dart';
import 'package:where_sylwester/data/city_validator.dart';
import 'package:where_sylwester/data/local_store.dart';
import 'package:where_sylwester/features/countdown/countdown_banner.dart';
import 'package:where_sylwester/features/input/location_input.dart';
import 'package:where_sylwester/features/notifications/winner_is.dart';
import 'package:where_sylwester/features/wheel/wheel_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Where Sylwester?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
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
  final _store = LocalStore();
  final _cityValidator = CityValidator();
  List<String> _locations = [];
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final loaded = await _store.loadLocations();
    setState(() => _locations = loaded);
  }

  Future<bool> _addLocation(String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;

    if (!_cityValidator.isFormatValid(trimmed)) {
      setState(() {
        _errorText =
            'Niepoprawna nazwa. Użyj liter (PL), spacji lub myślnika.';
      });
      return false;
    }

    final exists = await _cityValidator.existsInPoland(trimmed);
    if (!exists) {
      setState(() {
        _errorText = 'Miasto nie znalezione w Polsce.';
      });
      return false;
    }

    await _store.addLocation(trimmed);
    final updated = await _store.loadLocations();
    setState(() {
      _locations = updated;
      _errorText = null;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CountdownBanner(),
              const SizedBox(height: 20),
              Expanded(
                child: Center(
                  child: AnimatedWheel(items: _locations, size: 320),
                ),
              ),
              const SizedBox(height: 12),
              LocationInput(
                enabled: true, // ustaw na false po deadlinie
                onSubmit: _addLocation,
                errorText: _errorText,
              ),
              const SizedBox(height: 24),
              const WinnerIs(),
            ],
          ),
        ),
      ),
    );
  }
}
