import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkinder/common/models/parking_lot.dart';
import 'package:parkinder/common/networking/services/graphql_service.dart';

final parkingLotServiceProvider = Provider(
  (ref) => ParkingLotService(
    gqlService: ref.watch(graphQLServiceProvider),
  ),
);

class ParkingLotService {
  final GraphQLService _gqlService;

  ParkingLotService({required GraphQLService gqlService}) : _gqlService = gqlService;

  Future<List<ParkingLot>> getParkingLots({int limit = 5, int offset = 0}) async {
    const String query = r'''
  query GetAllParkingLots($limit: Int!, $offset: Int!) {
    getAllParkingLots(limit: $limit, offset: $offset) {
        id
        name
        address
        status        
        type
        size
        image
    }
}
''';

    final result = await _gqlService.query(query, {'limit': limit, 'offset': offset});
    final data = result['getAllParkingLots'] as List;
    final lots = data
        .map<ParkingLot>(
          (e) => ParkingLot.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return lots;
  }
}
