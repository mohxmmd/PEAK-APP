import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final List<String> options;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomDropdownField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    required this.options,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
        DropdownButtonFormField<String>(
          value: options.contains(controller?.text) ? controller?.text : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF252C34)),
            hintText: hintText,
            hintStyle: hintStyle,
            filled: true,
            fillColor: const Color.fromARGB(0, 211, 6, 6),
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
          ),
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF252C34)),
          style: const TextStyle(
              color: Color(0xFF252C34),
              fontSize: 14,
              fontWeight: FontWeight.bold),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option,
                  style: const TextStyle(color: Color(0xFF252C34))),
            );
          }).toList(),
          validator: validator,
          onChanged: (String? newValue) {
            if (controller != null) {
              controller!.text = newValue ?? '';
            }
          },
        ),
      ],
    );
  }
}
