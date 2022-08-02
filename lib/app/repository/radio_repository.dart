import 'dart:convert';
import 'package:radiao/app/helpers/cache_helper.dart';
import 'package:radiao/app/helpers/http_cached_helper.dart';
import 'package:radiao/app/models/station.dart';

class RadioRepository {
  static const String baseUrl = "http://all.api.radio-browser.info/json/stations";

  final httpBase = HttpCached(CacheHelper(CacheOptions(const Duration(minutes: 5))));

  Future<Station> fetchById(String stationuuid) async {
    final stations = await fetchByIds([stationuuid]);
    return stations[0];
  }

  Future<List<Station>> fetchByIds(List<String> stationuuids) async {
    final commaUuids = stationuuids.reduce((value, element) => "$value,$element");
    final response = await httpBase.get(Uri.parse("$baseUrl/byuuid?uuids=$commaUuids"));
    
    if (response.statusCode != 200) throw Exception("Algo deu errado: ${response.statusCode} - ${response.reasonPhrase}");

    return convertMapList(jsonDecode(response.body))
      .map<Station>((e) => Station.fromJson(e))
      .toList();
  }

  Future<List<Station>> fetchTrending() async {
    final response = await httpBase.get(Uri.parse("$baseUrl/topclick?limit=20&hidebroken=true"));
    
    if (response.statusCode != 200) throw Exception("Algo deu errado: ${response.statusCode} - ${response.reasonPhrase}");

    return convertMapList(jsonDecode(response.body))
      .map<Station>((e) => Station.fromJson(e))
      .toList();
  }

  Future<List<Station>> fetchPopular() async {
    final response = await httpBase.get(Uri.parse("$baseUrl/topvote?limit=20&hidebroken=true"));
    
    if (response.statusCode != 200) throw Exception("Algo deu errado: ${response.statusCode} - ${response.reasonPhrase}");

    return convertMapList(jsonDecode(response.body))
      .map<Station>((e) => Station.fromJson(e))
      .toList();
  }

  Future<List<Station>> searchStations(String stationName) async {
    final response = await httpBase.get(Uri.parse("$baseUrl/search?limit=20&hidebroken=true&name=$stationName"), cached: false);
    
    if (response.statusCode != 200) throw Exception("Algo deu errado: ${response.statusCode} - ${response.reasonPhrase}");

    return convertMapList(jsonDecode(response.body))
      .map<Station>((e) => Station.fromJson(e))
      .toList();
  }

  Future<List<Station>> fetchByTag(String tagname) async {
    final response = await httpBase.get(Uri.parse("$baseUrl/search?limit=20&hidebroken=true&tag=$tagname"));
    
    if (response.statusCode != 200) throw Exception("Algo deu errado: ${response.statusCode} - ${response.reasonPhrase}");

    return convertMapList(jsonDecode(response.body))
      .map<Station>((e) => Station.fromJson(e))
      .toList();
  }  

  Future<List<Station>> fetchListeningNow() async {
    final response = await httpBase.get(Uri.parse("$baseUrl/lastclick/5"));
    
    if (response.statusCode != 200) throw Exception("Algo deu errado: ${response.statusCode} - ${response.reasonPhrase}");

    return convertMapList(jsonDecode(response.body))
      .map<Station>((e) => Station.fromJson(e))
      .toList();
  }

  List<Map<String, dynamic>> convertMapList(List<dynamic> obj) {
    return obj.map((e) => e as Map<String, dynamic>).toList();
  }
}