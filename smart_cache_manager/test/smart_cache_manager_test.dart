import 'package:flutter_smart_cache_manager/flutter_smart_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CacheManager cache;

  setUp(() {
    cache = CacheManager(MemoryStorage());
  });

  group('Smart Cache Manager Tests', () {
    test('should fetch from API and cache result', () async {
      int apiCalls = 0;

      Future<String> fetcher() async {
        apiCalls++;
        return "hello";
      }

      final result1 = await cache.get<String>(key: 'user', fetcher: fetcher);

      final result2 = await cache.get<String>(key: 'user', fetcher: fetcher);

      expect(result1, 'hello');
      expect(result2, 'hello');
      expect(apiCalls, 1); // cached second time
    });

    test('should expire cache after ttl', () async {
      int apiCalls = 0;

      Future<String> fetcher() async {
        apiCalls++;
        return "data";
      }

      await cache.get<String>(
        key: 'product',
        ttl: const Duration(milliseconds: 100),
        fetcher: fetcher,
      );

      await Future.delayed(const Duration(milliseconds: 150));

      await cache.get<String>(
        key: 'product',
        ttl: const Duration(milliseconds: 100),
        fetcher: fetcher,
      );

      expect(apiCalls, 2);
    });

    test('should delete cache', () async {
      int apiCalls = 0;

      Future<String> fetcher() async {
        apiCalls++;
        return "value";
      }

      await cache.get<String>(key: 'settings', fetcher: fetcher);

      await cache.delete('settings');

      await cache.get<String>(key: 'settings', fetcher: fetcher);

      expect(apiCalls, 2);
    });

    test('should clear all cache', () async {
      int apiCalls = 0;

      Future<String> fetcher() async {
        apiCalls++;
        return "cached";
      }

      await cache.get(key: 'a', fetcher: fetcher);
      await cache.get(key: 'b', fetcher: fetcher);

      await cache.clear();

      await cache.get(key: 'a', fetcher: fetcher);

      expect(apiCalls, 3);
    });
  });
}
