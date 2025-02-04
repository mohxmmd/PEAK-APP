import 'package:flutter/material.dart';

class CutomSearchBar extends StatelessWidget {
  const CutomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle bodyLarge = Theme.of(context).textTheme.bodyLarge!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color.fromARGB(55, 255, 255, 255),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                hintStyle: bodyLarge,
              ),
            ),
          ),
          const Icon(Icons.filter_list, color: Color(0xFF2869FE)),
        ],
      ),
    );
  }
}
