import 'package:flutter/material.dart';
import 'wheel_painter.dart';

class AnimatedWheel extends StatelessWidget {
  const AnimatedWheel({
    super.key,
    required this.items,
    this.selectedIndex,
    this.size = 300,
  });

  final List<String> items;
  final int? selectedIndex;
  final double size;

  @override
  Widget build(BuildContext context) {
    final hasItems = items.isNotEmpty;
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size.square(size),
          painter: WheelPainter(
            items: items,
            highlightIndex: selectedIndex,
          ),
        ),
        Positioned(
          top: 8,
          child: Icon(
            Icons.arrow_drop_down,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        if (!hasItems)
          Positioned.fill(
            child: Center(
              child: Text(
                'Dodaj miejscowość',
                style: TextStyle(
                  color: Theme.of(context).hintColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
