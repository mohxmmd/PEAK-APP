import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final ImageProvider image;
  final String label;
  final Function()? onTap;

  const CustomIconButton({
    super.key,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            // padding:
            //     const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(51, 255, 255, 255),
                width: .7,
              ),
              borderRadius: BorderRadius.circular(16),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Color.fromRGBO(50, 50, 93, 0.25),
              //     blurRadius: 27,
              //     spreadRadius: -5,
              //     offset: Offset(
              //       0,
              //       13,
              //     ),
              //   ),
              //   BoxShadow(
              //     color: Color.fromRGBO(0, 0, 0, 0.3),
              //     blurRadius: 16,
              //     spreadRadius: -8,
              //     offset: Offset(
              //       0,
              //       8,
              //     ),
              //   ),
              // ],
            ),
            child: Image(
              image: image,
              width: 73,
              height: 73,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xFF1e252d),
              fontWeight: FontWeight.w500,
              fontFamily: 'Urbanist',
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
