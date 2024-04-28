import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/spacing.dart';
import 'package:parkinder/common/models/parking_lot.dart';

class ParkingLotAvailability extends StatelessWidget {
  const ParkingLotAvailability({
    super.key,
    required this.parkingLot,
  });
  final ParkingLot parkingLot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: parkingLot.isActive ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Spacing.hMedium,
        Text(
          parkingLot.isActive ? 'Active' : 'Inactive',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
