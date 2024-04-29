import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/dimens.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/common/extensions/string_extension.dart';
import 'package:parkinder/features/history/enum/history_filter_type.dart';

class HistoryFilterView extends StatelessWidget {
  const HistoryFilterView({super.key, required this.selectedFilter, this.onFilterChanged});
  final HistoryFilterType selectedFilter;
  final Function(HistoryFilterType)? onFilterChanged;

  @override
  Widget build(BuildContext context) {
    const filters = HistoryFilterType.values;
    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.margin),
        itemCount: filters.length,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => Spacing.hMedium,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return ChoiceChip(
            label: Text(filter.name.capitalized()),
            selected: selectedFilter == filter,
            onSelected: (selected) => onFilterChanged?.call(filter),
          );
        },
      ),
    );
  }
}
