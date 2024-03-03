import 'dart:math';

import 'package:eatpencil/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingCircle extends ConsumerStatefulWidget {
  const LoadingCircle({super.key});

  @override
  ConsumerState<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends ConsumerState<LoadingCircle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
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
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: CustomPaint(
          size: const Size(40, 40),
          painter: _LoadingCirclePainter(
            ref: ref,
          ),
        ),
      ),
    );
  }
}

class _LoadingCirclePainter extends CustomPainter {
  final WidgetRef ref;

  _LoadingCirclePainter({required this.ref});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = theme(ref).accentedBg
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    double startAngle = -pi / 4;
    double sweepAngle = pi / 2;

    Paint coloredPaint = Paint()
      ..color = theme(ref).accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ),
      startAngle,
      sweepAngle,
      false,
      coloredPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
