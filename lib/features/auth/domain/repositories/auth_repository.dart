import '../../../../core/models/user.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> signup(Map<String, dynamic> data);
  Future<void> googleLogin({String? idToken, String? accessToken});
  Future<void> logout();
  Future<bool> checkAuthStatus();
  Future<User?> getCurrentUser();
  Future<void> verifyEmail(String token);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
  Future<void> resendVerificationEmail(String email);
}
