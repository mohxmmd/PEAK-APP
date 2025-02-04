import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle labelStyle;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.labelStyle,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Theme.of(context).primaryColor,
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 18.0,
            ),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          elevation: WidgetStateProperty.all(10),
          overlayColor: WidgetStateProperty.all(
            Colors.green.withOpacity(0.2),
          ),
          shadowColor: WidgetStateProperty.all(
            Colors.green.withOpacity(0.4),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: 'Urbanist', // Change to Urbanist font
                ),
              ),
      ),
    );
  }
}
