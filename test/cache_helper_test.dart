
import 'package:hive_flutter/hive_flutter.dart';
import 'package:radiao/app/helpers/cache_helper.dart';
import 'package:radiao/app/helpers/http_cached_helper.dart';
import 'package:test/test.dart';

void main() {

  Hive.initFlutter();

  final cache = CacheHelper(CacheOptions(const Duration(minutes: 5)));

  Map<String, Object> _getData() {
    return {
      "id": 1,
      "name": "teste"
    };
  }

  test("add cache", () async {
    await cache.addCache("url", _getData());
  });

  test("get cache", () async {
    final res = await cache.getCache("url");
    print(res["object"]);
  });

  test("remove cache", () async {
    await cache.removeCache("url");
  });

  test("get httpcached", () async {
    final http = HttpCached(CacheHelper(CacheOptions(const Duration(seconds: 20))));
     final response = await http.get(Uri.parse("http://all.api.radio-browser.info/json/stations/topclick?limit=20&hidebroken=true"));
     print(response);
  });
}