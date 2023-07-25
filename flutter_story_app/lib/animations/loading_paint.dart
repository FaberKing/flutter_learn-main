import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingPaint extends CustomPainter {
  final double value;

  LoadingPaint({required this.value});
  void circle(Canvas canvas, Rect rect, double value) {
    final double size = rect.width;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);

    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color animateColor = Colors.black.withOpacity(opacity);
    final Paint paint = Paint()..color = animateColor;

    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          math.sin((i / size.width * 2 * math.pi) + (value * 2 * math.pi)) *
              10);
    }
    Paint arc = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawPath(path, arc);
  }

  @override
  bool shouldRepaint(covariant LoadingPaint oldDelegate) {
    return value != oldDelegate.value;
  }
}
