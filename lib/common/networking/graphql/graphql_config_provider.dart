import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql/client.dart';

/// This file contains all the configurations required to initialize GraphQL Service

final _graphQLCacheProvider = Provider(
  /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk, for real project use HIVE DB for disk caching
  (ref) => GraphQLCache(),
);

final _httpLinkProvider = Provider(
  (ref) => HttpLink(
    'https://interview-apixx07.dev.park-depot.de/',
  ),
);

final _authLinkProvider = Provider(
  (ref) => AuthLink(
    getToken: () async => '',
  ),
);

final _linkProvider = Provider(
  (ref) => ref.watch(_authLinkProvider).concat(
        ref.watch(_httpLinkProvider),
      ),
);

final graphQLClientProvider = Provider((ref) => GraphQLClient(
      cache: ref.watch(_graphQLCacheProvider),
      link: ref.watch(_linkProvider),
    ));
