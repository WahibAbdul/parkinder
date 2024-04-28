import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/dimens.dart';
import 'package:parkinder/common/widgets/stroked_text.dart';

class DecisionStamp extends StatelessWidget {
  const DecisionStamp({
    super.key,
    required this.isLike,
    required this.child,
    this.isMini = false,
    this.show = true,
  });
  final bool isLike;
  final Widget child;
  final bool isMini;
  final bool show;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = isMini ? theme.textTheme.displaySmall : theme.textTheme.displayLarge;
    return Stack(
      children: [
        child,
        if (show)
          Positioned(
            top: 20,
            left: isLike ? 10 : null,
            right: isLike ? null : 10,
            child: Transform.rotate(
                angle: isLike ? 50 : -50,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.marginMedium, vertical: Dimens.marginSmall),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: (isLike ? Colors.green : Colors.red).withAlpha(150),
                        width: 4.0,
                      )),
                  child: StrokedText(
                    text: isLike ? "Like" : "Nope",
                    textColor: isLike ? Colors.green : Colors.red,
                    strokeColor: Colors.black,
                    strokeWidth: 3.0,
                    style: textStyle!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
      ],
    );
  }
}
