import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomProfileButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(8, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.person_outline_rounded,
          color: Colors.white,
          size: 24,
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ),
    );
  }
}
