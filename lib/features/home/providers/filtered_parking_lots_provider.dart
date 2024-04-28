import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/features/home/enums/decision.dart';
import 'package:parkinder/features/home/enums/parking_lot_filter.dart';

import 'parking_lots_provider.dart';

/// Provide parking lots according to the filter
final filteredParkingLotsProvider =
    Provider.family.autoDispose<AsyncValue<List<ParkingLot>>, ParkingLotFilter>((ref, filter) {
  final data = ref.watch(parkingLotsNotifierProvider);
  if (data.hasValue) {
    return AsyncData(data.value!.where((element) {
      if (filter == ParkingLotFilter.remaining) {
        return element.decision == Decision.none;
      } else if (filter == ParkingLotFilter.decided) {
        return element.decision != Decision.none;
      } else {
        return true;
      }
    }).toList());
  }
  return data;
});
