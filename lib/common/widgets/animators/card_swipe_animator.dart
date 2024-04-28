import 'dart:math';

import 'package:flutter/material.dart';

class CardSwipeAnimator extends StatelessWidget {
  const CardSwipeAnimator({
    super.key,
    required this.child,
    required this.position,
    this.isDragging = false,
    required this.angle,
  });

  final Widget child;
  final double angle;
  final Offset position;
  final bool isDragging;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final milliseconds = isDragging ? 0 : 200;

      final center = constraints.smallest.center(Offset.zero);
      final childAngle = angle * pi / 180;
      final matrix = Matrix4.identity()
        ..translate(center.dx, center.dy)
        ..rotateZ(childAngle)
        ..translate(-center.dx, -center.dy);

      return AnimatedContainer(
        duration: Duration(milliseconds: milliseconds),
        curve: Curves.easeInOut,
        transform: matrix
          ..translate(
            position.dx,
            position.dy,
          ),
        child: child,
      );
    });
  }
}
