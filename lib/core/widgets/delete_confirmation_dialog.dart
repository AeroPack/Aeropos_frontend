import 'package:flutter/material.dart';

/// A reusable delete confirmation dialog widget
/// 
/// Shows a confirmation dialog before deleting an item.
/// Returns true if the user confirmed deletion, false otherwise.
class DeleteConfirmationDialog extends StatelessWidget {
  final String itemName;
  final String itemType;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    super.key,
    required this.itemName,
    required this.itemType,
    required this.onConfirm,
  });

  /// Shows the delete confirmation dialog
  /// 
  /// Usage:
  /// ```dart
  /// await DeleteConfirmationDialog.show(
  ///   context: context,
  ///   itemName: product.name,
  ///   itemType: 'Product',
  ///   onConfirm: () async {
  ///     await viewModel.deleteProduct(product.id);
  ///   },
  /// );
  /// ```
  static Future<void> show({
    required BuildContext context,
    required String itemName,
    required String itemType,
    required Future<void> Function() onConfirm,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete $itemType "$itemName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await onConfirm();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$itemType "$itemName" deleted successfully')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete $itemType: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: Text('Are you sure you want to delete $itemType "$itemName"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
