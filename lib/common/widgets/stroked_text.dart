import 'package:flutter/material.dart';

class StrokedText extends StatelessWidget {
  const StrokedText({
    super.key,
    required this.text,
    required this.textColor,
    required this.strokeColor,
    required this.style,
    this.strokeWidth = 1.0,
  });
  final String text;
  final Color textColor;
  final Color strokeColor;
  final TextStyle style;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
              foreground: Paint()
                ..strokeWidth = strokeWidth
                ..color = strokeColor
                ..style = PaintingStyle.stroke),
        ),
        Text(
          text,
          style: style.copyWith(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
