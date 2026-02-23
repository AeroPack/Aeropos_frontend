import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_controller.dart';

class EmailVerificationPendingScreen extends ConsumerStatefulWidget {
  const EmailVerificationPendingScreen({super.key});

  @override
  ConsumerState<EmailVerificationPendingScreen> createState() =>
      _EmailVerificationPendingScreenState();
}

class _EmailVerificationPendingScreenState
    extends ConsumerState<EmailVerificationPendingScreen> {
  bool _resentSuccessfully = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.status == AuthStatus.loading;
    final userEmail = authState.user?.email ?? '';

    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated &&
          next.errorMessage != null) {
        if (next.errorMessage!.toLowerCase().contains('sent') ||
            next.errorMessage!.toLowerCase().contains('inbox')) {
          setState(() => _resentSuccessfully = true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _resentSuccessfully
                      ? Icons.mark_email_read_outlined
                      : Icons.mark_email_unread_outlined,
                  size: 80,
                  color: _resentSuccessfully ? Colors.green : Colors.blue,
                ),
                const SizedBox(height: 24),
                Text(
                  _resentSuccessfully ? 'Email Sent!' : 'Verify Your Email',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  _resentSuccessfully
                      ? 'A fresh verification link has been sent to $userEmail. Please check your inbox (and spam folder).'
                      : 'We sent a verification link to ${userEmail.isNotEmpty ? userEmail : 'your email'}. Click the link to activate your account.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                // Refresh status button
                ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          ref
                              .read(authControllerProvider.notifier)
                              .checkAuthStatus();
                        },
                  icon: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                  label: const Text('I have verified my email'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 12),
                // Resend button
                OutlinedButton.icon(
                  onPressed: isLoading || userEmail.isEmpty
                      ? null
                      : () {
                          setState(() => _resentSuccessfully = false);
                          ref
                              .read(authControllerProvider.notifier)
                              .resendVerificationEmail(userEmail);
                        },
                  icon: const Icon(Icons.send_outlined),
                  label: const Text('Resend Verification Email'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    ref.read(authControllerProvider.notifier).logout();
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
