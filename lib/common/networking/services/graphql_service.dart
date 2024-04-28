import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';
import 'package:parkinder/common/networking/graphql/graphql_config_provider.dart';

final graphQLServiceProvider = Provider(
  (ref) => GraphQLService(
    client: ref.watch(graphQLClientProvider),
  ),
);

class GraphQLService {
  final GraphQLClient _client;

  GraphQLService({required GraphQLClient client}) : _client = client;

  Future<Map<String, dynamic>> query(String query, Map<String, dynamic> variables) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
    );

    log("Loading Data:\n ${options.asRequest.toString()}");

    final result = await _client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return result.data!;
  }
}
