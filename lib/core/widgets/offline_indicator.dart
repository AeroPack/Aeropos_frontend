import 'package:flutter/material.dart';

class OfflineIndicator extends StatelessWidget {
  final bool isOffline;

  const OfflineIndicator({
    super.key,
    required this.isOffline,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOffline) return const SizedBox.shrink();

    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.cloud_off, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'Working Offline - Changes will sync when online',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
