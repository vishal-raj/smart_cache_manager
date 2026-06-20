import 'cache_storage.dart';

class MemoryStorage implements CacheStorage {
  final Map<String, dynamic> _cache = {};

  @override
  Future<void> save(String key, dynamic value) async {
    _cache[key] = value;
  }

  @override
  Future<dynamic> read(String key) async {
    return _cache[key];
  }

  @override
  Future<void> delete(String key) async {
    _cache.remove(key);
  }

  @override
  Future<void> clear() async {
    _cache.clear();
  }
}
