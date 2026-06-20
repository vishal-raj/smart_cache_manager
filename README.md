# Smart Cache Manager

A powerful and lightweight Flutter caching library with TTL support, cache policies, offline fallback, and background refresh.

## Features

* Automatic caching
* Time-to-live (TTL) expiration
* Multiple cache policies
* Offline fallback support
* Background refresh (stale-while-revalidate)
* Lightweight and easy to integrate

---

## Installation

Add dependency:

```yaml
dependencies:
  smart_cache_manager: ^0.0.1
```

Install packages:

```bash
flutter pub get
```

---

## Import

```dart
import 'package:smart_cache_manager/smart_cache_manager.dart';
```

---

## Quick Start

Create cache manager:

```dart
final cache = CacheManager(
  MemoryStorage(),
);
```

Fetch data with caching:

```dart
final data = await cache.get<String>(
  key: "user_profile",
  fetcher: () async {
    await Future.delayed(Duration(seconds: 2));
    return "Vishal Raj";
  },
);
```

First request fetches from network.
Next requests return cached response instantly.

---

## Cache Policies

Available policies:

```dart
CachePolicy.networkOnly
CachePolicy.cacheOnly
CachePolicy.cacheFirst
CachePolicy.networkFirst
CachePolicy.staleWhileRevalidate
```

Example:

```dart
await cache.get(
  key: "products",
  policy: CachePolicy.cacheFirst,
  fetcher: api.getProducts,
);
```

---

## TTL (Time To Live)

Cache automatically expires after TTL.

```dart
await cache.get(
  key: "user",
  ttl: Duration(minutes: 30),
  fetcher: api.fetchUser,
);
```

After 30 minutes, fresh data will be fetched.

---

## Delete Cache

Delete specific key:

```dart
await cache.delete("user");
```

Clear all cache:

```dart
await cache.clear();
```

---

## Example

```dart
final cache = CacheManager(MemoryStorage());

final users = await cache.get<List<String>>(
  key: "users",
  ttl: Duration(minutes: 10),
  fetcher: () async {
    return ["Alice", "Bob"];
  },
);

print(users);
```

---

## Running Tests

```bash
flutter test
```

---

## Roadmap

* Hive storage support
* Isar support
* Dio interceptor
* Cache analytics
* Encryption
* Disk persistence

---

## Contributing

Contributions, issues, and feature requests are welcome.

---

## License

MIT License
