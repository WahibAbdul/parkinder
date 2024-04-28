import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/common/networking/services/parking_lot_service.dart';
import 'package:parkinder/features/home/enums/decision.dart';

final parkingLotsNotifierProvider =
    StateNotifierProvider.autoDispose<ParkingLotsStateNotifier, AsyncValue<List<ParkingLot>>>(
  (ref) {
    return ParkingLotsStateNotifier(
      service: ref.watch(parkingLotServiceProvider),
    );
  },
);

/// Fetches parking lots from server, maintain state of decisions and manage pagination
class ParkingLotsStateNotifier extends StateNotifier<AsyncValue<List<ParkingLot>>> {
  final ParkingLotService _service;
  final _limit = 5;
  var _offset = 0;
  var _canLoadMore = true;

  ParkingLotsStateNotifier({required ParkingLotService service})
      : _service = service,
        super(const AsyncLoading()) {
    fetchData();
  }

  void fetchData() async {
    try {
      final lots = await _service.getParkingLots(limit: _limit, offset: _offset);
      if (lots.isEmpty) _canLoadMore = false;
      state = AsyncData([
        ...lots.reversed,
        ...?state.value,
      ]);
      state.value?.forEach((element) {
        log(element.name);
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      log(e.toString());
    }
  }

  void setDecision(int index, Decision decision) {
    state = AsyncData([
      ...?state.value?.sublist(0, index),
      state.value![index].copyWith(decision: decision),
      ...?state.value?.sublist(index + 1),
    ]);
  }

  void loadMore() {
    if (!_canLoadMore) return;
    _offset += _limit + 1;
    fetchData();
  }
}
