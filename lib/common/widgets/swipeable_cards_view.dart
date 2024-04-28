import 'package:flutter/material.dart';
import 'package:parkinder/common/widgets/handlers/card_swipe_handler.dart';

/// It takes four parameters:
///
/// * `itemCount`: The total number of cards to be displayed.
/// * `itemBuilder`: A function that builds each card. It takes the current build context,
/// * `onSwiped`: A function that gets called when a card is swiped. It takes the current
///   This parameter is optional.
/// * `loadMore`: A function that gets called when there are only two cards left in the stack.
class SwipeableCardsView extends StatelessWidget {
  const SwipeableCardsView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.onSwiped,
    this.loadMore,
  });
  final int itemCount;
  final Function(BuildContext, int, Direction) itemBuilder;
  final Function(BuildContext, int, Direction)? onSwiped;
  final Function()? loadMore;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final index in Iterable.generate(itemCount))
          CardSwipeHandler(
            builder: (dragDirection) {
              return itemBuilder(
                context,
                index,
                dragDirection,
              );
            },
            onSwiped: (direction) {
              if (itemCount == 2) {
                loadMore?.call();
              }
              return onSwiped?.call(context, index, direction);
            },
          )
      ],
    );
  }
}
