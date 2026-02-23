import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/models/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final FlutterSecureStorage _storage;
  final AppDatabase _database;

  AuthRepositoryImpl(this._remoteDataSource, this._storage, this._database);

  @override
  Future<void> login(String email, String password) async {
    final response = await _remoteDataSource.login(email, password);
    final token = response['token'];
    if (token != null) {
      await _storage.write(key: 'auth_token', value: token);
    }
  }

  @override
  Future<void> signup(Map<String, dynamic> data) async {
    final response = await _remoteDataSource.signup(data);
    final token = response['token'];
    if (token != null) {
      await _storage.write(key: 'auth_token', value: token);
    }
  }

  @override
  Future<void> googleLogin({String? idToken, String? accessToken}) async {
    final response = await _remoteDataSource.googleLogin(
      idToken: idToken,
      accessToken: accessToken,
    );
    final token = response['token'];
    if (token != null) {
      await _storage.write(key: 'auth_token', value: token);
    }
  }

  @override
  Future<void> logout() async {
    // Safety check: verify no pending changes before clearing data
    try {
      final hasPending =
          await (_database.select(_database.products)
                ..where((t) => t.syncStatus.equals(1))
                ..limit(1))
              .get();

      if (hasPending.isNotEmpty) {
        print('⚠️ WARNING: Pending changes detected during logout!');
        print('   This may indicate sync failed. Data will be lost.');
      }
    } catch (e) {
      print('Error checking pending changes during logout: $e');
    }

    // Clear all local data from the database
    await _database.clearAllData();

    // Delete the authentication token
    await _storage.delete(key: 'auth_token');
  }

  @override
  Future<bool> checkAuthStatus() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final responseMap = await _remoteDataSource.getCurrentUser();
      if (responseMap.containsKey('employee')) {
        return User.fromJson(responseMap['employee']);
      }
      // Fallback if the response is flat (unlikely given backend code, but safe)
      return User.fromJson(responseMap);
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  @override
  Future<void> verifyEmail(String token) async {
    await _remoteDataSource.verifyEmail(token);
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _remoteDataSource.forgotPassword(email);
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    await _remoteDataSource.resetPassword(token, newPassword);
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    await _remoteDataSource.resendVerificationEmail(email);
  }
}
