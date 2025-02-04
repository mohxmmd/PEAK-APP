import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isDropdown;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isNumeric; // Add this to indicate numeric input

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.isDropdown = false,
    this.controller,
    this.validator,
    this.isNumeric = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = Theme.of(context).textTheme.displayMedium!;
    TextStyle hintStyle = Theme.of(context).textTheme.bodyLarge!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Color(0xFF252C34),
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: isDropdown,
          validator: validator,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters:
              isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF252C34)),
            hintText: hintText,
            hintStyle: hintStyle,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(45, 0, 0, 0),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(58, 0, 0, 0),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(79, 0, 0, 0),
                width: 1,
              ),
            ),
            suffixIcon: isDropdown
                ? const Icon(Icons.arrow_drop_down, color: Colors.white)
                : null,
          ),
          style: labelStyle,
          onChanged: (value) {
            if (controller != null) {
              controller!.text = value;
            }
          },
        ),
      ],
    );
  }
}
