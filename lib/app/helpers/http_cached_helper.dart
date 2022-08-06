import 'package:http/http.dart' as http;
import 'package:tune_radio/app/helpers/cache_helper.dart';

class HttpCached extends http.BaseClient {
  final CacheHelper _cacheHelper;

  HttpCached(this._cacheHelper);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return request.send();
  }

  @override
  Future<http.Response> get(Uri url,
      {Map<String, String>? headers, bool cached = true}) async {
    final cachedResponse = await _cacheHelper.getCache(url.toString());
    if (cachedResponse.isNotEmpty && cached) {
      return _ResponseExtensions.fromMap(cachedResponse["object"]);
    }

    final response = await super.get(url, headers: headers);
    _cacheHelper.addCache(url.toString(), response.toMap());

    return response;
  }
}

extension _ResponseExtensions on http.Response {
  Map<String, dynamic> toMap() {
    return {
      "body": body,
      "statuscode": statusCode,
      "headers": headers,
    };
  }

  static http.Response fromMap(Map<String, dynamic> map) {
    return http.Response(map["body"], map["statuscode"],
        headers: Map.from(map["headers"]));
  }
}
