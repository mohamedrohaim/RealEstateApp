import 'package:dio/dio.dart';

class MyApiClient {
  static final Dio _dio = Dio();
  static final Map<String, String> headers = {
    'Cookie': 'ARRAffinity=4a6bcf805311a2b473ad4cc81aaf102012766d358e9d9ece2fd92ef8a4d85836; ARRAffinitySameSite=4a6bcf805311a2b473ad4cc81aaf102012766d358e9d9ece2fd92ef8a4d85836'
  };

  static Future<Response> fetchData(int id, int userId) async {
    try {
      final response = await _dio.request(
        'http://realestateegv1.runasp.net/api/Unit/$id?userId=$userId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      return response;
    } catch (e) {
      // Handle error
      throw Exception('Failed to fetch data: $e');
    }
  }
    static Future<Response> getFavoirt( int userId) async {
    try {
      final response = await _dio.request(
        'http://realestateegv1.runasp.net/api/Unit/favorite-list?userId=$userId',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      return response;
    } catch (e) {
      // Handle error
      throw Exception('Failed to fetch data: $e');
    }
  }
}