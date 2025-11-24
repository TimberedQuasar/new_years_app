import 'package:flutter/material.dart';

class CountdownBanner extends StatelessWidget {
  const CountdownBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Countdown Banner',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
