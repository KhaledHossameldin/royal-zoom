import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/brand_colors.dart';

class BorderPainter extends CustomPainter {
  BorderPainter({
    required double stroke,
    required double padding,
    required double progress,
  })  : _stroke = stroke,
        _padding = padding,
        _progress = progress;

  final double _stroke;
  final double _padding;
  final double _progress;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (size.width / 2) + _padding;
    final center = Offset(size.width / 2, size.height / 2);

    final backgroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = _stroke
      ..style = PaintingStyle.stroke
      ..color = Colors.grey.shade300;

    canvas.drawCircle(center, radius, backgroundPaint);

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = _stroke
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = BrandColors.orange;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * _progress,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant BorderPainter oldDelegate) =>
      oldDelegate._progress != _progress;
}
