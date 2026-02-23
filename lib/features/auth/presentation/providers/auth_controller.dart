import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/services/sync_service.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/models/user.dart';

enum AuthStatus { authenticated, unauthenticated, loading }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final User? user;

  AuthState({required this.status, this.errorMessage, this.user});

  factory AuthState.initial() => AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated(User user) =>
      AuthState(status: AuthStatus.authenticated, user: user);
  factory AuthState.unauthenticated([String? error]) =>
      AuthState(status: AuthStatus.unauthenticated, errorMessage: error);
  factory AuthState.loading() => AuthState(status: AuthStatus.loading);
}

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SyncService _syncService;

  AuthController(this._authRepository, this._syncService)
    : super(AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = AuthState.loading();
    try {
      final isLoggedIn = await _authRepository.checkAuthStatus();
      if (isLoggedIn) {
        final user = await _authRepository.getCurrentUser();
        if (user != null) {
          state = AuthState.authenticated(user);
          // Router will handle redirect if !user.isEmailVerified
        } else {
          // Token exists but user load failed (maybe token expired or invalid)
          // Should we logout? Or just be unauthenticated?
          // For now, let's treat as unauthenticated
          await _authRepository.logout();
          state = AuthState.unauthenticated();
        }
      } else {
        state = AuthState.unauthenticated();
      }
    } catch (e) {
      state = AuthState.unauthenticated(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    state = AuthState.loading();
    try {
      // Perform login and store token
      await _authRepository.login(email, password);

      // Trigger incremental data sync after successful login
      print('Login successful, syncing data...');
      await _syncService.pull();
      print('Data sync completed');

      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        state = AuthState.authenticated(user);
        // Router will handle redirect if !user.isEmailVerified
      } else {
        throw Exception("Failed to load user profile after login");
      }
    } catch (e) {
      String message = "Login failed";
      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data['error'] != null) {
          message = e.response!.data['error'];
        } else {
          message = "Login failed: ${e.message}";
        }
      } else {
        message = "Login failed: ${e.toString()}";
      }
      state = AuthState.unauthenticated(message);
    }
  }

  Future<void> signup(Map<String, dynamic> data) async {
    state = AuthState.loading();
    try {
      await _authRepository.signup(data);

      // Trigger incremental data sync after successful signup
      print('Signup successful, syncing data...');
      await _syncService.pull();
      print('Data sync completed');

      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        state = AuthState.authenticated(user);
        // Router will handle redirect if !user.isEmailVerified (after signup)
      } else {
        throw Exception("Failed to load user profile after signup");
      }
    } catch (e) {
      String message = "Signup failed";
      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data['error'] != null) {
          message = e
              .response!
              .data['error']; // "User with this email already exists"
        } else {
          message = "Signup failed: ${e.message}";
        }
      } else {
        message = "Signup failed: ${e.toString()}";
      }
      state = AuthState.unauthenticated(message);
    }
  }

  Future<void> signInWithGoogle() async {
    state = AuthState.loading();
    try {
      // Initialize GoogleSignIn without params to ensure ID Token flow (OIDC)
      // explicit scopes trigger OAuth flow which may not return ID Token on web
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Step 1: Authenticate
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If googleUser is null, it means the user cancelled the sign-in flow.
      if (googleUser == null) {
        state = AuthState.unauthenticated();
        return;
      }

      print('Google User: ${googleUser.email}');

      // Step 2: Get Tokens
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null && googleAuth.accessToken == null) {
        print('Google Sign-In Error: Both ID Token and Access Token are null');
        throw Exception("Failed to retrieve Google Sign-In Tokens");
      }

      if (idToken != null) {
        print('Google ID Token retrieved successfully');
      } else {
        print('Google ID Token is null, falling back to Access Token');
      }

      await _authRepository.googleLogin(
        idToken: idToken,
        accessToken: googleAuth.accessToken,
      );

      // Trigger incremental data sync after successful login
      print('Google Login successful, syncing data...');
      await _syncService.pull();
      print('Data sync completed');

      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        state = AuthState.authenticated(user);
        // Router will handle redirect if !user.isEmailVerified
      } else {
        throw Exception("Failed to load user profile after login");
      }
    } catch (e) {
      String message = "Google Sign-In failed";
      print('Google Sign-In Exception: $e');

      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data['error'] != null) {
          message = e.response!.data['error'];
        } else {
          message = "Google Sign-In failed: ${e.message}";
        }
      } else {
        if (e.toString().contains("canceled")) {
          state = AuthState.unauthenticated();
          return;
        }
        message = "Google Sign-In failed: ${e.toString()}";
      }
      state = AuthState.unauthenticated(message);
    }
  }

  Future<void> logout() async {
    state = AuthState.loading();
    await _authRepository.logout();
    await GoogleSignIn().signOut();
    state = AuthState.unauthenticated();
  }

  Future<void> forgotPassword(String email) async {
    state = AuthState.loading();
    try {
      await _authRepository.forgotPassword(email);
      state = AuthState.unauthenticated(
        "Password reset link sent to your email",
      );
    } catch (e) {
      String message = "Failed to send reset link";
      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data['error'] != null) {
          message = e.response!.data['error'];
        } else {
          message = e.message ?? message;
        }
      }
      state = AuthState.unauthenticated(message);
    }
  }

  Future<void> resendVerificationEmail(String email) async {
    state = AuthState.loading();
    try {
      await _authRepository.resendVerificationEmail(email);
      state = AuthState.unauthenticated(
        "Verification email sent! Please check your inbox.",
      );
    } catch (e) {
      String message = "Failed to resend verification email";
      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data['error'] != null) {
          message = e.response!.data['error'];
        } else {
          message = e.message ?? message;
        }
      }
      state = AuthState.unauthenticated(message);
    }
  }

  Future<void> resetPassword(String token, String newPassword) async {
    state = AuthState.loading();
    try {
      await _authRepository.resetPassword(token, newPassword);
      state = AuthState.unauthenticated(
        "Password reset successfully. Please login.",
      );
    } catch (e) {
      String message = "Failed to reset password";
      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data['error'] != null) {
          message = e.response!.data['error'];
        } else {
          message = e.message ?? message;
        }
      }
      state = AuthState.unauthenticated(message);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    return AuthController(
      ServiceLocator.instance.authRepository,
      ServiceLocator.instance.syncService,
    );
  },
);
