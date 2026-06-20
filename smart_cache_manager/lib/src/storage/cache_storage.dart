/// Abstract storage layer for cache persistence.
abstract class CacheStorage {
  /// Saves data to storage.
  Future<void> save(String key, dynamic value);

  /// Reads cached data by key.
  Future<dynamic> read(String key);

  /// Deletes a cached item.
  Future<void> delete(String key);

  /// Clears all cached data.
  Future<void> clear();
}
