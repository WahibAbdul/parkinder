import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/constants/dimens.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/features/history/enum/history_filter_type.dart';
import 'package:parkinder/features/history/providers/history_parking_lots_provider.dart';
import 'package:parkinder/features/history/ui/widgets/history_cards_view.dart';
import 'package:parkinder/features/history/ui/widgets/history_filter_view.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  var _selectedFilter = HistoryFilterType.all;

  @override
  Widget build(BuildContext context) {
    final decidedParkingLots = ref.watch(historyParkingLotsProvider(_selectedFilter));

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
            // BODY
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FILTER VIEW
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.margin),
                    child: HistoryFilterView(
                      selectedFilter: _selectedFilter,
                      onFilterChanged: (filter) => setState(() => _selectedFilter = filter),
                    ),
                  ),
                  Spacing.vertical,
                  // CARDS VIEW
                  Expanded(
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
