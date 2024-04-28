import 'package:flutter/material.dart';
import 'package:parkinder/common/widgets/animators/card_swipe_animator.dart';

enum Direction { right, left, none }

/// `CardSwipeHandler` is a stateful widget that handles swipe gestures on a card.
///
/// It takes four parameters:
///
/// * `builder`: A function that builds the card. It takes the direction of the swipe as a parameter.
/// * `onSwiped`: A function that gets called when the card is swiped. It takes the index of the swiped card
///   and the direction of the swipe as parameters. This parameter is optional.
///
class CardSwipeHandler extends StatefulWidget {
  const CardSwipeHandler({super.key, required this.builder, this.onSwiped});

  final Widget Function(Direction) builder;
  final Function(Direction)? onSwiped;

  @override
  State<CardSwipeHandler> createState() => CardSwipeHandlerState();
}

class CardSwipeHandlerState extends State<CardSwipeHandler> {
  Offset _position = Offset.zero;
  bool _isDragging = false;
  double _angle = 0;
  Direction _direction = Direction.none;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return GestureDetector(
      onPanStart: _startPosition,
      onPanUpdate: (details) => _updatePosition(details, screenSize),
      onPanEnd: (details) => _endPosition(details, screenSize),
      child: CardSwipeAnimator(
        angle: _angle,
        position: _position,
        isDragging: _isDragging,
        child: widget.builder(_direction),
      ),
    );
  }

  void _startPosition(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _updatePosition(DragUpdateDetails details, Size screenSize) {
    setState(() {
      _position += details.delta;
      final x = _position.dx;
      _angle = 15 * x / screenSize.width;

      if (_position.dx > 5) {
        _direction = Direction.left;
      } else if (_position.dx < -5) {
        _direction = Direction.right;
      } else {
        _direction = Direction.none;
      }
    });
  }

  void _endPosition(DragEndDetails details, Size screenSize) {
    setState(() {
      _isDragging = false;

      if (_position.dx >= 200) {
        _angle = 20;
        _position += Offset(screenSize.width * 2, 0);
        Future.delayed(const Duration(milliseconds: 200), () {
          widget.onSwiped?.call(Direction.right);
        });
      } else if (_position.dx <= -200) {
        _angle = -20;
        _position += Offset(-screenSize.width * 2, 0);
        Future.delayed(const Duration(milliseconds: 200), () {
          widget.onSwiped?.call(Direction.left);
        });
      } else {
        _resetPosition();
      }
    });
  }

  void _resetPosition() {
    _position = Offset.zero;
    _angle = 0;
    _direction = Direction.none;
  }
}
