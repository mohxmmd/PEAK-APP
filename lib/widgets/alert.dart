import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;

  const CustomAlertDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = Theme.of(context).textTheme.bodyLarge!;

    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
      contentPadding: const EdgeInsets.all(18.0),
      content: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          message,
          style: bodyStyle,
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
            textStyle: bodyStyle,
          ),
          child: Text(
            'OK',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
