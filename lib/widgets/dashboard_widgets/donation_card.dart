import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/payment_controller.dart';
import 'package:shimmer/shimmer.dart';

class DonationCard extends StatelessWidget {
  final String title;
  final String description;
  final String iconImage;
  final Color iconColor;
  final String amount;
  final int schemeId;

  const DonationCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.amount,
    required this.schemeId,
  });

  Future<Map<String, dynamic>> fetchDonationDetails() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'schemeId': schemeId,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchDonationDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return a skeleton loader when waiting
          return SingleChildScrollView(
            child: Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0), // Light Gray
              highlightColor: const Color(0xFFFFFFFF), // White
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 84,
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.circle,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16.0,
                            width: 150.0,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 14.0,
                            width: 200.0,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            height: 14.0,
                            width: 100.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 40.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          // Extract data from the snapshot
          final donationTitle = snapshot.data!['title']!;
          final donationDescription = snapshot.data!['description']!;
          final donationAmount = snapshot.data!['amount']!;
          final donationSchemeId = snapshot.data!['schemeId']!;

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color.fromARGB(
                      153, 218, 220, 206), // 60% opacity border color
                  width: 2, // Border width
                ),
                boxShadow: const [
                  BoxShadow(
                    color:
                        Color.fromARGB(13, 18, 25, 39), // 5% opacity (#121927)
                    offset: Offset(0, 6), // x = 0, y = 6
                    blurRadius: 44, // Blur = 44
                    spreadRadius: 0, // Spread = 0
                  ),
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Image.asset(
                      iconImage,
                      fit: BoxFit.cover,
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        donationTitle,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Urbanist',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        donationDescription,
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey,
                          fontFamily: 'Urbanist',
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Amount: ₹$donationAmount',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(243, 46, 44, 44),
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: () {
                    final PaymentController controller =
                        Get.put(PaymentController());
                    int parsedAmount =
                        (double.parse(donationAmount) * 100).toInt();

                    controller.openCheckout(parsedAmount, 'Fundraiser',
                        donationSchemeId, donationTitle);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.orange),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Donate',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
