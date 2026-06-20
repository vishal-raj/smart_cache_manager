/// Defines how cached data should be fetched.
enum CachePolicy {
  /// Always fetch fresh data from network.
  networkOnly,

  /// Return only cached data.
  cacheOnly,

  /// Return cache first, otherwise network.
  cacheFirst,

  /// Try network first, fallback to cache.
  networkFirst,

  /// Return cache immediately and refresh in background.
  staleWhileRevalidate,
}
