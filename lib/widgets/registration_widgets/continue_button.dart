import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final TextStyle? labelStyle;

  const ReusableButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(label, style: labelStyle),
        ),
      ),
    );
  }
}
