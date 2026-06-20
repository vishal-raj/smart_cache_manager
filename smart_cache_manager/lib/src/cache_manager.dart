import 'cache_entry.dart';
import 'cache_policy.dart';
import 'storage/cache_storage.dart';

/// Main cache manager responsible for caching logic.
class CacheManager {
  /// Storage backend used by cache manager.
  final CacheStorage storage;

  /// Creates a cache manager.
  CacheManager(this.storage);

  /// Fetches data using the specified cache policy.
  Future<T> get<T>({
    required String key,
    required Future<T> Function() fetcher,
    Duration ttl = const Duration(minutes: 30),
    CachePolicy policy = CachePolicy.cacheFirst,
    String? tag,
  }) async {
    final cached = await storage.read(key);

    if (cached != null && cached is CacheEntry<T>) {
      if (!cached.isExpired) {
        if (policy == CachePolicy.cacheFirst ||
            policy == CachePolicy.cacheOnly ||
            policy == CachePolicy.staleWhileRevalidate) {
          if (policy == CachePolicy.staleWhileRevalidate) {
            _refreshInBackground(key, fetcher, ttl, tag);
          }

          return cached.data;
        }
      }
    }

    if (policy == CachePolicy.cacheOnly && cached == null) {
      throw Exception("Cache miss");
    }

    return _fetchAndCache(key, fetcher, ttl, tag);
  }

  Future<T> _fetchAndCache<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    String? tag,
  ) async {
    final freshData = await fetcher();

    final entry = CacheEntry<T>(
      data: freshData,
      createdAt: DateTime.now(),
      ttl: ttl,
      tag: tag,
    );

    await storage.save(key, entry);

    return freshData;
  }

  void _refreshInBackground<T>(
    String key,
    Future<T> Function() fetcher,
    Duration ttl,
    String? tag,
  ) {
    Future(() async {
      await _fetchAndCache(key, fetcher, ttl, tag);
    });
  }

  Future<void> clear() async {
    await storage.clear();
  }

  Future<void> delete(String key) async {
    await storage.delete(key);
  }
}
