import 'package:flutter/material.dart';

class EmptyOrderState extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onActionTap;
  final String? actionText;

  const EmptyOrderState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onActionTap,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (onActionTap != null && actionText != null) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onActionTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B7BF5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
              child: Text(
                actionText!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
