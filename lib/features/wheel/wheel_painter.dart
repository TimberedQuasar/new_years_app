import 'dart:math';
import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  WheelPainter({required this.items, this.highlightIndex});

  final List<String> items;
  final int? highlightIndex;

  static const _palette = <Color>[
    Color(0xFF7E57C2),
    Color(0xFF26A69A),
    Color(0xFFFF7043),
    Color(0xFF42A5F5),
    Color(0xFF66BB6A),
    Color(0xFFFFCA28),
    Color(0xFFEF5350),
    Color(0xFFAB47BC),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    if (items.isEmpty) {
      final paint = Paint()
        ..color = Colors.deepPurple.withOpacity(0.15)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(center, radius, paint);
      return;
    }

    final sweep = 2 * pi / items.length;
    final labelRadius = radius * 0.65;
    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
    );
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16, // większa czcionka nazw miast
      fontWeight: FontWeight.w600,
    );
    var start = -pi / 2; // start at top
    for (var i = 0; i < items.length; i++) {
      final paint = Paint()
        ..color = _palette[i % _palette.length]
        ..style = PaintingStyle.fill;
      canvas.drawArc(rect, start, sweep, true, paint);

      if (highlightIndex == i) {
        final border = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4;
        canvas.drawArc(rect.deflate(2), start, sweep, true, border);
      }

      // Draw label along the radius (center -> outside).
      final midAngle = start + sweep / 2;
      textPainter.text = TextSpan(text: items[i], style: textStyle);
      textPainter.layout(maxWidth: radius);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(midAngle);
      textPainter.paint(
        canvas,
        Offset(labelRadius - textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();

      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) {
    return oldDelegate.items != items ||
        oldDelegate.highlightIndex != highlightIndex;
  }
}
