import 'package:flutter/material.dart';

enum ToastType { success, error, info }

class PosToast {
  static void show(BuildContext context, String message, {ToastType type = ToastType.info}) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(message: message, type: type),
    );

    overlay.insert(overlayEntry);

    // Auto dismiss after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  static void showSuccess(BuildContext context, String message) => show(context, message, type: ToastType.success);
  static void showError(BuildContext context, String message) => show(context, message, type: ToastType.error);
  static void showInfo(BuildContext context, String message) => show(context, message, type: ToastType.info);
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;

  const _ToastWidget({required this.message, required this.type});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );

    _opacity = CurveTween(curve: Curves.easeOut).animate(_controller);
    _offset = Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
        .chain(CurveTween(curve: Curves.elasticOut)) // Fixed: springOut -> elasticOut
        .animate(_controller);

    _controller.forward();

    // Start reverse animation before dismissal
    Future.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBgColor() {
    switch (widget.type) {
      case ToastType.success: return const Color(0xFF10B981); // Green
      case ToastType.error: return const Color(0xFFEF4444);   // Red
      case ToastType.info: return const Color(0xFF3B82F6);    // Blue
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success: return Icons.check_circle_outline;
      case ToastType.error: return Icons.error_outline;
      case ToastType.info: return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24, // Top margin
      right: 24, // Right margin
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offset,
          child: FadeTransition(
            opacity: _opacity,
            child: Container(
              width: 320, // Fixed width like typical toasts
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border(left: BorderSide(color: _getBgColor(), width: 4)),
              ),
              child: Row(
                children: [
                  Icon(_getIcon(), color: _getBgColor(), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
