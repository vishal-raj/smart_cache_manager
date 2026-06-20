class CacheEntry<T> {
  final T data;
  final DateTime createdAt;
  final Duration ttl;
  final String? tag;

  CacheEntry({
    required this.data,
    required this.createdAt,
    required this.ttl,
    this.tag,
  });

  bool get isExpired {
    return DateTime.now().difference(createdAt) > ttl;
  }
}
