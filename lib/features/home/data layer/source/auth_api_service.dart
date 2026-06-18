import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://72.61.245.150/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Response> loginAsPlatform({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/platform/auth/login',
        data: {'email': email, 'password': password},
      );
      print(response.data);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> getPlatformMe({required String token}) async {
    try {
      return await _dio.get(
        '/platform/auth/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> loginAsTenant({
    required String identifier,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/tenant/auth/login',
        data: {'identifier': identifier, 'password': password},
      );
      log(response.data.toString());
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Response> getTenantMe({required String token}) async {
    try {
      return await _dio.get(
        '/tenant/auth/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
     
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      return e.response?.data['message'] ?? 'Invalid credentials.';
    }
    return 'Please try again.';
  }
}
