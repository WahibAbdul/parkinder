import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/dimens.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/features/home/enums/decision.dart';
import 'package:parkinder/features/home/ui/widgets/decision_stamp.dart';
import 'package:parkinder/features/home/ui/widgets/parking_lot_card.dart';

class HistoryCardsView extends StatelessWidget {
  const HistoryCardsView({
    super.key,
    required this.parkingLots,
  });
  final List<ParkingLot> parkingLots;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    bool isWideScreen = screenSize.width > 480;
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isWideScreen ? 3 : 2,
          mainAxisSpacing: Dimens.margin,
          crossAxisSpacing: Dimens.margin,
          mainAxisExtent: 280,
        ),
        padding: const EdgeInsets.all(Dimens.margin),
        itemCount: parkingLots.length,
        itemBuilder: (context, index) {
          final parkingLot = parkingLots[index];
          return DecisionStamp(
            isGood: parkingLot.decision == Decision.good,
            isMini: true,
            child: ParkingLotCard(
              width: double.infinity,
              parkingLot: parkingLot,
              style: ParkingLotCardStyle.mini,
            ),
          );
        });
  }
}
