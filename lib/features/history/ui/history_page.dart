import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/features/history/ui/widgets/history_cards_view.dart';
import 'package:parkinder/features/home/providers/filtered_parking_lots_provider.dart';
import 'package:parkinder/features/home/enums/parking_lot_filter.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decidedParkingLots = ref.watch(
      filteredParkingLotsProvider(ParkingLotFilter.decided).select((value) => value.value ?? []),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: SafeArea(
        child: decidedParkingLots.isEmpty
            // NO DATA VIEW
            ? Center(
                child: Text(
                "Swipe your favorite parking lots\n😀",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ))
            // GRID VIEW OF CARDS
            : Center(
                child: HistoryCardsView(
                  parkingLots: decidedParkingLots,
                ),
              ),
      ),
    );
  }
}
