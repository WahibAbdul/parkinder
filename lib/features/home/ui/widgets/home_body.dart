import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/features/home/providers/filtered_parking_lots_provider.dart';
import 'package:parkinder/features/home/providers/parking_lots_provider.dart';
import 'package:parkinder/features/home/enums/decision.dart';
import 'package:parkinder/features/home/enums/parking_lot_filter.dart';
import 'package:parkinder/common/widgets/handlers/card_swipe_handler.dart';
import 'package:parkinder/common/widgets/swipeable_cards_view.dart';

import 'parking_lot_card.dart';
import 'decision_stamp.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(filteredParkingLotsProvider(ParkingLotFilter.remaining));
    final parkingLots = data.hasValue ? data.value! : [];

    return data.isLoading
        // LOADER
        ? const Center(child: CircularProgressIndicator())
        : data.hasError
            // ERROR WIDGET
            ? Center(
                child: Text(
                '‼️Something went wrong!\n${data.error.toString()}',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ))
            : parkingLots.isEmpty
                // EMPTY DATA WIDGET
                ? Center(
                    child: Text(
                      "Oops! We are out of parking spaces 🙁",
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
                  )
                // CARDS VIEW
                : SwipeableCardsView(
                    itemCount: parkingLots.length,
                    itemBuilder: (context, index, dragDirection) {
                      final parkingLot = parkingLots[index];
                      return DecisionStamp(
                        isGood: dragDirection == Direction.left,
                        show: dragDirection != Direction.none,
                        child: ParkingLotCard(
                          parkingLot: parkingLot,
                        ),
                      );
                    },
                    onSwiped: (context, index, direction) {
                      ref.read(parkingLotsNotifierProvider.notifier).setDecision(
                            index,
                            fromDirection(direction),
                          );
                    },
                    loadMore: () => ref.read(parkingLotsNotifierProvider.notifier).loadMore(),
                  );
  }

  Decision fromDirection(Direction direction) {
    return direction == Direction.right
        ? Decision.good
        : direction == Direction.left
            ? Decision.bad
            : Decision.none;
  }
}
