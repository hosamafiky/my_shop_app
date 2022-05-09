import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    String? lang,
    String? token,
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.post(
      endPoint,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> getData({
    String? lang,
    required String token,
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.get(
      endPoint,
      queryParameters: query,
    );
  }
}
