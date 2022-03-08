import 'dart:convert';
import 'package:hive/hive.dart';

class CacheHelper {
  final CacheOptions cacheOptions;

  CacheHelper(this.cacheOptions);

  Future addCache(String url, dynamic object) async {
    final isExists = await _HiveService.isExists(url);
    if (isExists) await removeCache(url);

    await _HiveService.addCache(_Cache(url, object, DateTime.now()));
  }

  Future removeCache(String url) async {
    await _HiveService.removeCache(url);
  }

  Future<Map<String, dynamic>> getCache(String url) async {
    final cache = await _HiveService.getCache(url);
    if (cache == null) return <String, dynamic>{};

    return _validate(cache) ? cache.toMap() : <String, dynamic>{};
  }

  bool _validate(_Cache cache) {
    if (_cacheDateIsValid(cache.date)) return true;

    _HiveService.removeCache(cache.key);
    return false;
  }

  bool _cacheDateIsValid(DateTime? date) {
    if (date == null) return false;
    return DateTime.now().isBefore(date.add(cacheOptions.duration));
  }
}

class CacheOptions {
  final Duration duration;

  CacheOptions(this.duration);
}

class _Cache {
  final String key;
  final dynamic object;
  final DateTime date;

  _Cache(this.key, this.object, this.date);

  factory _Cache.fromMap(Map<String, dynamic> map) {
    return _Cache(map["key"], map["object"], DateTime.fromMillisecondsSinceEpoch(map["date"]));
  }

  Map<String, dynamic> toMap() {
    return {"key": key, "object": object, "date": date.millisecondsSinceEpoch};
  }
}

class _HiveService {
  static const String boxName = "cache";

  static Future<bool> isExists(String key) async {
    final openBox = await _getBox();
    return openBox.get(key) != null;
  }

  static addCache(_Cache cache) async {
    final openBox = await _getBox();
    openBox.put(cache.key, jsonEncode(cache.toMap()));
  }

  static Future removeCache(String key) async {
    final openBox = await _getBox();
    await openBox.delete(key);
  }

  static Future<_Cache?> getCache(String key) async {
    final openBox = await _getBox();

    final element = openBox.get(key);
    if(element == null) return null;

    return _Cache.fromMap(jsonDecode(element));
  }

  static Future<Box> _getBox() async {
    return await Hive.openBox(boxName);
  }
}