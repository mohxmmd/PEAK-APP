import 'package:flutter/material.dart';

class CustomNotificationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomNotificationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF6E7C2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.notifications_none,
          color: Color(0xFF1E252D),
          size: 24,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    );
  }
}
