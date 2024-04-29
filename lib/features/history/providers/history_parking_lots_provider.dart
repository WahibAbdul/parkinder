import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/features/history/enum/history_filter_type.dart';
import 'package:parkinder/features/home/enums/decision.dart';
import 'package:parkinder/features/home/enums/parking_lot_filter.dart';
import 'package:parkinder/features/home/providers/filtered_parking_lots_provider.dart';

final historyParkingLotsProvider = Provider.family.autoDispose<List<ParkingLot>, HistoryFilterType>((ref, filter) {
  return ref.watch(filteredParkingLotsProvider(ParkingLotFilter.decided).select((data) {
    final list = data.value ?? [];
    if (filter == HistoryFilterType.good) {
      return list.where((element) => element.decision == Decision.good).toList();
    } else if (filter == HistoryFilterType.bad) {
      return list.where((element) => element.decision == Decision.bad).toList();
    }
    return list;
  }));
});
