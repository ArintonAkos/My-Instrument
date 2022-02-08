import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class BaseCacheManager {
  /// This key must be unique
  final String key;
  late final CacheManager instance;

  BaseCacheManager({
    required this.key
  }) {
    instance = CacheManager(
      Config(
        key,
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 15,
        repo: JsonCacheInfoRepository(databaseName: key),
      )
    );
  }

  Future<void> clearCache() async {
    await instance.emptyCache();
  }
}