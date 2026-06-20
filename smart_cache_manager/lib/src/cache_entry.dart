/// Represents a single cached entry.
///
/// Stores the cached data along with creation time,
/// expiration duration, and optional grouping tag.
class CacheEntry<T> {
  /// Cached data.
  final T data;

  /// Timestamp when cache entry was created.
  final DateTime createdAt;

  /// Duration after which cache becomes invalid.
  final Duration ttl;

  /// Optional tag for grouping cache entries.
  final String? tag;

  /// Creates a cache entry.
  CacheEntry({
    required this.data,
    required this.createdAt,
    required this.ttl,
    this.tag,
  });

  /// Returns true if cache entry has expired.
  bool get isExpired {
    return DateTime.now().difference(createdAt) > ttl;
  }
}
