import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/common/extensions/string_extension.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/features/home/ui/widgets/parking_lot_availability.dart';
import 'package:parkinder/features/home/ui/widgets/parking_lot_card.dart';

class ParkingLotInfoContainer extends StatelessWidget {
  const ParkingLotInfoContainer({
    super.key,
    required this.parkingLot,
    this.style = ParkingLotCardStyle.normal,
  });
  final ParkingLotCardStyle style;
  final ParkingLot parkingLot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = style == ParkingLotCardStyle.normal ? theme.textTheme.titleLarge : theme.textTheme.bodyLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          parkingLot.name,
          maxLines: 1,
          style: textStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          parkingLot.address,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        if (style == ParkingLotCardStyle.normal) ...[
          Spacing.vSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ParkingLotAvailability(
                parkingLot: parkingLot,
              ),
              Text(
                parkingLot.type.capitalized(),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}
