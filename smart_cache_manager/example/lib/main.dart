import 'package:flutter/material.dart';
import 'package:flutter_smart_cache_manager/flutter_smart_cache_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CacheDemo());
  }
}

class CacheDemo extends StatefulWidget {
  @override
  State<CacheDemo> createState() => _CacheDemoState();
}

class _CacheDemoState extends State<CacheDemo> {
  String text = "Loading...";

  final cache = CacheManager(MemoryStorage());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await cache.get<String>(
      key: "user",
      ttl: Duration(minutes: 5),
      fetcher: () async {
        await Future.delayed(Duration(seconds: 2));
        print("API CALLED");
        return "Hello Vishal";
      },
    );

    setState(() {
      text = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(text)),
      floatingActionButton: FloatingActionButton(
        onPressed: loadData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
