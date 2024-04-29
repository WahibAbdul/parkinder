import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/features/history/enum/history_filter_type.dart';
import 'package:parkinder/features/home/enums/decision.dart';
import 'package:parkinder/features/home/enums/parking_lot_filter.dart';
import 'package:parkinder/features/home/providers/filtered_parking_lots_provider.dart';

import 'history_selected_filter_provider.dart';

final historyParkingLotsProvider = Provider.autoDispose<List<ParkingLot>>((ref) {
  final filter = ref.watch(historySelectedFilterProvider);

  return ref.watch(filteredParkingLotsProvider(ParkingLotFilter.decided).select((data) {
    final list = data.value ?? [];
    if (filter == HistoryFilterType.good) {
      return list.where((element) => element.decision == Decision.good).toList();
    } else if (filter == HistoryFilterType.bad) {
      return list.where((element) => element.decision == Decision.bad).toList();
    } else if (filter == HistoryFilterType.hotel) {
      return list.where((element) => element.isHotel).toList();
    } else if (filter == HistoryFilterType.store) {
      return list.where((element) => element.isStore).toList();
    }
    return list;
  }));
});
