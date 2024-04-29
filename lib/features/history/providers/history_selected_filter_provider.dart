import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/features/history/enum/history_filter_type.dart';

final historySelectedFilterProvider = StateProvider.autoDispose<HistoryFilterType>(
  (ref) => HistoryFilterType.all,
);
