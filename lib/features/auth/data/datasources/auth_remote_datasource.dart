import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> signup(Map<String, dynamic> data);
  Future<Map<String, dynamic>> getCurrentUser();
  Future<Map<String, dynamic>> googleLogin({
    String? idToken,
    String? accessToken,
  });
  Future<void> verifyEmail(String token);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
  Future<void> resendVerificationEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/auth/login',
        data: {'email': email, 'password': password},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/auth/signup', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> googleLogin({
    String? idToken,
    String? accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/api/auth/google',
        data: {'idToken': idToken, 'accessToken': accessToken},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _dio.get('/api/auth/me');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyEmail(String token) async {
    try {
      await _dio.get(
        '/api/auth/verify-email',
        queryParameters: {'token': token},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _dio.post('/api/auth/forgot-password', data: {'email': email});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    try {
      await _dio.post(
        '/api/auth/reset-password',
        data: {'token': token, 'newPassword': newPassword},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    try {
      await _dio.post('/api/auth/resend-verification', data: {'email': email});
    } catch (e) {
      rethrow;
    }
  }
}
