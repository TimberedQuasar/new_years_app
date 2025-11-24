import 'package:flutter/material.dart';

class AnimatedWheel extends StatelessWidget {
  const AnimatedWheel({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
        alignment: Alignment.center,
        child: const Text(
          'Wheel',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
