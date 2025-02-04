import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isDropdown;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.isDropdown = false,
    this.controller,
    this.validator,
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
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: isDropdown,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white),
            hintText: hintText,
            hintStyle: hintStyle,
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(46, 255, 255, 255),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(59, 255, 255, 255),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color.fromARGB(79, 255, 255, 255),
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
              controller!.text =
                  value; 
            }
          },
        ),
      ],
    );
  }
}
