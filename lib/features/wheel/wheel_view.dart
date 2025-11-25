import 'package:flutter/material.dart';
import 'wheel_painter.dart';

class AnimatedWheel extends StatefulWidget {
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
  State<AnimatedWheel> createState() => _AnimatedWheelState();
}

class _AnimatedWheelState extends State<AnimatedWheel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = widget.items.isNotEmpty;
    final outerSize = widget.size * 1.3; // więcej miejsca na pointer z odstępem
    return SizedBox(
      width: outerSize,
      height: outerSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: RotationTransition(
                turns: _controller,
                child: CustomPaint(
                  size: Size.square(widget.size),
                  painter: WheelPainter(
                    items: widget.items,
                    highlightIndex: widget.selectedIndex,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                left: widget.size * 0.1,
              ), // mały odstęp od koła
              child: Icon(
                Icons.arrow_left,
                size:
                    48, // większy pointer, prostopadle do koła (wskazuje w lewo)
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          if (!hasItems)
            const Positioned.fill(
              child: Center(
                child: Text(
                  'Dodaj miejscowość',
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
