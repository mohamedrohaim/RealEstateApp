import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:realestate/core/network/api_constatn.dart';

class APIHelper {
  static final Dio _dio = Dio();
  static void addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Do something before request is sent
        debugPrint("Request sent: ${options.uri}");
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        // Do something with the response data
        debugPrint("Response received: ${response.data}");
        return handler.next(response); // continue
      },
      onError: (DioError error, handler) {
        // Do something with the error
        debugPrint("Request failed: $error");
        return handler.next(error); // continue
      },
    ));
  }

  APIHelper();
  static Future<List<dynamic>> getData({String? url, dynamic param}) async {
    try {
      var response =
          await _dio.get(APIConstant.baseUrl + url!, queryParameters: param);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        // debugPrint(response.data.toString());
        return response.data;
      } else {
        debugPrint("Request Faild with status code:${response.statusCode}");
        throw Exception(
            "Request Faild with status code:${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error:$error");
      throw Exception("Error:$error");
    }

    //return response.data;
  }
  static Future<List<dynamic>> filterSearch({String? url, dynamic data}) async {
    try {
      var response = await _dio.post(APIConstant.baseUrl + url!, data: data);
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        // debugPrint(response.data.toString());
        log(response.data.toString());
        return response.data;
      } else {
        debugPrint("Request Faild with status code:${response.statusCode}");
        throw Exception(
            "Request Faild with status code:${response.statusCode}");
      }
    } catch (error) {
      debugPrint("Error:$error");
      throw Exception("Error:$error");
    }

    //return response.data;
  }
  static Future<Response> fetchData(int id, String userId) async {
    try {
      final response = await _dio.request(
          'http://realestateegv1.runasp.net/api/Unit/$id?userId=$userId',
          options: Options(method: "GET"));
      return response;
    } catch (e) {
      // Handle error
      throw Exception('Failed to fetch data: $e');
    }
  }
  static Future<List<dynamic>> getScheduleAppointment( String userId) async {
    try {
      final response = await _dio.request(
          'http://realestateegv1.runasp.net/api/ScheduleAppointment/user/$userId',
          options: Options(method: "GET"));
            pritnt(response.data.toString());
      return response.data;
    } catch (e) {
      // Handle error
      log(e.toString());
      throw Exception('Failed to fetch data: $e');
    }
  }
  static Future<Response> aiPredict(Map<String, dynamic> data) async {
    try {
      final response = await _dio.request(
          "http://mohamedrohaim.pythonanywhere.com/predict_price",
          options: Options(method: "POST"),
          data: data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  static Future<Response> postData(Map<String, dynamic> data,String url) async {
    try {
      final response = await _dio.request(
         url,
          options: Options(method: "POST"),
         // data: data
         queryParameters: data
          );
      return response;
    } catch (e) {
      throw e;
    }
  }
  static Future<Response> pustOTPforgetPassowrd(
      Map<String, dynamic> data,String url) async {
    try {
      final response = await _dio.post(url,data: data);
      return response;
    } catch (e) {
      throw e;
    }
  }
   static Future<Response> resetForgetPassword(
      Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(APIConstant.baseUrl+APIConstant.resetPassword,data: data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  
  static void pritnt(String string) {}
}
