class CacheMissException implements Exception {}

class NetworkFetchException implements Exception {
  final String message;

  NetworkFetchException(this.message);
}
