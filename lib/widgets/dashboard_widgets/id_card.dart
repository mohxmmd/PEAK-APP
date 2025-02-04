import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String userName;
  final String userJob;
  final String userImage;
  final String expirationDate;
  final TextStyle idName;
  final TextStyle idTextBold;
  final TextStyle idText;

  const ProfileCard({
    super.key,
    required this.userName,
    required this.userJob,
    required this.userImage,
    required this.expirationDate,
    required this.idName,
    required this.idTextBold,
    required this.idText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF42A018), // First color: #42A018
            Color(0xFFE2E654), // Second color: #E2E654
          ],
          stops: [0.2, 1.0], // Stops at 0% and 100%
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromRGBO(50, 50, 93, 0.2),
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
      child: Stack(
        children: [
          // Main content of the card
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, style: idName),
                  Text(userJob, style: idText),
                  const SizedBox(height: 70),
                  Text("Expiration:", style: idTextBold),
                  Text(expirationDate, style: idText),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 72),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    userImage,
                    width: 100,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/user_dummy.png',
                        width: 100,
                        height: 110,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Logo in the top right corner
          Container(
            width: double.infinity, // Set the width of the container
            height: 150, // Set an appropriate height for the Stack
            child: Stack(
              children: [
                // Positioned oval-shaped white box
                Positioned(
                  top: 0, // Adjust the position to match the logo
                  right: 0, // Align the box with the logo
                  child: Container(
                    width: 75, // Adjust width for the oval shape
                    height: 35, // Adjust height for the oval shape
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(206, 255, 255, 255),
                      borderRadius:
                          BorderRadius.circular(12), // White color for the box
                    ),
                  ),
                ),
                // Positioned logo
                Positioned(
                  top: -15, // Adjust the position of the logo
                  right: 5, // Align the logo
                  child: Image.asset(
                    'assets/images/peak_logo.png',
                    width: 65, // Adjust the size as needed
                    height: 65, // Adjust the size as needed
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
