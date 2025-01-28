import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  DioService() {
    _dio.options.baseUrl = 'https://api.example.com';
  }

  Future<Response> getRequest(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Response> postRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<Response> putRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<Response> deleteRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}