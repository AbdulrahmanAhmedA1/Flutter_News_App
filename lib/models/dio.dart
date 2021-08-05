import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://newsapi.org/', receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(
      {String url, Map<String, dynamic> queryParameters}) async {
    return await dio.get(url, queryParameters: queryParameters);
  }
}
