import 'package:flutter/material.dart';

class ProfileStatusCard extends StatelessWidget {
  final String title;
  final String status;
  final String iconImage;
  final Color iconColor;

  const ProfileStatusCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.status,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 66,
            height: 66,
            child: Image.asset(
              iconImage,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontFamily: 'Urbanist',
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontFamily: 'Urbanist',
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}
