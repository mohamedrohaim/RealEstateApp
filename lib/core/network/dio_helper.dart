// import 'package:dio/dio.dart';
// import 'package:realestate/core/network/api_constatn.dart';

// class DioHelper {
//   static late Dio dio;

//   static init() {
//     dio = Dio(BaseOptions(
//       baseUrl: APIConstant.baseUrl,
//       headers: {'Content-Type': 'application/json'},
//     ));
//     dio.interceptors.add(
//         LogInterceptor(requestBody: true, error: true, responseBody: true));
//   }

//   static Future<Response> getData({
//     required String url,
//     Map<String, dynamic>? query,
//     String? token,
//   }) async {
//     dio.options.headers = {
//       'Authorization': token ?? '',
//     };
//     return await dio.get(
//       url,
//       queryParameters: query,
//     );
//   }

//   static Future<Response> postData({
//     required String url,
//     required Map<String, dynamic> data,
//     Map<String, dynamic>? query,
//     bool isFormData = false,
//   }) async {
//     return await dio.post(
//       url,
//       queryParameters: {'ln': 'en'},
//       data: isFormData ? FormData.fromMap(data) : data,
//     );
//   }

//   static Future<Response> putData({
//     required String url,
//     Map<String, dynamic>? query,
//     required Map<String, dynamic> data,
//     String? token,
//   }) async {
//     dio.options.headers = {
//       'Authorization': token ?? '',
//     };
//     return dio.put(
//       url,
//       queryParameters: query,
//       data: data,
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:realestate/core/network/api_constatn.dart';

class DioHelper {
  //  static Dio dio=Dio(
  //   BaseOptions(
  //     baseUrl:AppConstant.basUrl,
  //     headers: {"Content-Type": 'application/json'}
  //   )
  // );
  static late Dio dio;
  static initDio() {
    dio = Dio(BaseOptions(
        baseUrl: APIConstant.baseUrl,
        headers: {
          "Content-Type": 'application/json',
          "Accept-Language": "ar",
        },
        receiveDataWhenStatusError: true));
  }

  static Future<Response> postUser(
      {required String url,
       Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    return await dio.post(url, data: data, queryParameters: query);
  }

  //   static Future<Response> getData(
  //     {required String url, Map<String, dynamic>? query}) async {
  //   return await dio.get(url, queryParameters: query);
  // }
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(url,
          queryParameters: query, options: Options(headers: headers));
      return response;
    } catch (e) {
      throw e;
    }
    // return await dio.get(url, queryParameters: query);
  }
}
