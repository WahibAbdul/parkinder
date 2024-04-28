import 'package:flutter/foundation.dart';
import 'package:parkinder/features/home/enums/decision.dart';

@immutable
class ParkingLot {
  final String image;
  final String name;
  final int size;
  final String status;
  final String type;
  final String id;
  final String address;
  final Decision decision;

  const ParkingLot({
    required this.image,
    required this.name,
    required this.size,
    required this.status,
    required this.type,
    required this.id,
    required this.address,
    this.decision = Decision.none,
  });

  ParkingLot copyWith({
    String? image,
    String? name,
    int? size,
    String? status,
    String? type,
    DateTime? liveDate,
    String? id,
    String? address,
    Decision? decision,
  }) =>
      ParkingLot(
        image: image ?? this.image,
        name: name ?? this.name,
        size: size ?? this.size,
        status: status ?? this.status,
        type: type ?? this.type,
        id: id ?? this.id,
        address: address ?? this.address,
        decision: decision ?? this.decision,
      );

  factory ParkingLot.fromJson(Map<String, dynamic> json) => ParkingLot(
        image: json["image"],
        name: json["name"],
        size: json["size"],
        status: json["status"],
        type: json["type"],
        id: json["id"],
        address: json["address"],
      );

  bool get isActive => status == 'active';
}
