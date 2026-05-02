import 'dart:math' as math;

import 'package:flutter/material.dart';

class FeloProgressRing extends StatelessWidget {
  const FeloProgressRing({
    required this.progress,
    required this.label,
    super.key,
    this.size = 88,
    this.strokeWidth = 8,
  });

  final double progress;
  final String label;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      value: '${(progress.clamp(0, 1) * 100).round()}%',
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _FeloProgressRingPainter(
            progress: progress.clamp(0, 1),
            color: Theme.of(context).colorScheme.primary,
            trackColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            strokeWidth: strokeWidth,
          ),
          child: Center(
            child: Text(
              '${(progress.clamp(0, 1) * 100).round()}%',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeloProgressRingPainter extends CustomPainter {
  const _FeloProgressRingPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      rect.deflate(strokeWidth / 2),
      0,
      math.pi * 2,
      false,
      trackPaint,
    );
    canvas.drawArc(
      rect.deflate(strokeWidth / 2),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _FeloProgressRingPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        color != oldDelegate.color ||
        trackColor != oldDelegate.trackColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
