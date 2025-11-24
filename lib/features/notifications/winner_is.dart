import 'package:flutter/material.dart';

class WinnerIs extends StatelessWidget {
  const WinnerIs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'AND THE WINNER IS...',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: "",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
