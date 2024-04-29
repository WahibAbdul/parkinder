import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/features/history/providers/history_parking_lots_provider.dart';
import 'package:parkinder/features/history/providers/history_selected_filter_provider.dart';
import 'package:parkinder/features/history/ui/widgets/history_cards_view.dart';
import 'package:parkinder/features/history/ui/widgets/history_filter_view.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decidedParkingLots = ref.watch(historyParkingLotsProvider.select((value) => value));

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FILTER VIEW
            HistoryFilterView(
              selectedFilter: ref.watch(historySelectedFilterProvider),
              onFilterChanged: (filter) => ref.read(historySelectedFilterProvider.notifier).state = filter,
            ),
            Spacing.vertical,
            // CARDS VIEW
            decidedParkingLots.isEmpty
                // NO DATA VIEW
                ? Center(
                    child: Text(
                    "Swipe your favorite parking lots\n😀",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ))
                // BODY
                : Expanded(
                    child: HistoryCardsView(
                      parkingLots: decidedParkingLots,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
