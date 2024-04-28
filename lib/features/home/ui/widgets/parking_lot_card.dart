import 'package:flutter/material.dart';
import 'package:parkinder/common/constants/dimens.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/features/home/ui/widgets/parking_lot_card_info_container.dart';

enum ParkingLotCardStyle {
  mini,
  normal;
}

class ParkingLotCard extends StatelessWidget {
  const ParkingLotCard({
    super.key,
    required this.parkingLot,
    this.style = ParkingLotCardStyle.normal,
    this.width,
    this.height,
  });

  final ParkingLotCardStyle style;
  final ParkingLot parkingLot;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.cardRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(parkingLot.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(Dimens.margin),
                  child: ParkingLotInfoContainer(
                    parkingLot: parkingLot,
                    style: style,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
