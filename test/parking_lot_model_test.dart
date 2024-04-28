import 'package:flutter_test/flutter_test.dart';
import 'package:parkinder/common/models/parking_lot.dart';

void main() {
  group('ParkingLot', () {
    final json = {
      'image': 'test_image',
      'name': 'test_name',
      'size': 100,
      'status': 'active',
      'type': 'test_type',
      'id': 'test_id',
      'address': 'test_address',
    };

    final parkingLot = ParkingLot.fromJson(json);
    test('should create a ParkingLot object from JSON', () {
      expect(parkingLot.image, 'test_image');
      expect(parkingLot.name, 'test_name');
      expect(parkingLot.size, 100);
      expect(parkingLot.status, 'active');
      expect(parkingLot.type, 'test_type');
      expect(parkingLot.id, 'test_id');
      expect(parkingLot.address, 'test_address');
    });

    test('should return true if the status is active', () {
      final activeParkingLot = parkingLot.copyWith(status: 'active');
      expect(activeParkingLot.isActive, true);
    });

    test('should return false if the status is not active', () {
      final inactiveParkingLot = parkingLot.copyWith(status: 'inactive');
      expect(inactiveParkingLot.isActive, false);
    });
  });
}
