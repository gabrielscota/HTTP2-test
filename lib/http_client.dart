enum Method {
  get,
  post,
}

abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required Method method,
  });
}
