import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peak_app/payment_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class MembershipStatusCard extends StatelessWidget {
  final String title;
  final String status;
  final String iconImage;
  final Color iconColor;
  final Future<Map<String, dynamic>> Function() fetchSubscriptionDetails;

  const MembershipStatusCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.status,
    required this.iconColor,
    required this.fetchSubscriptionDetails,
  });

  Future<Map<String, dynamic>> getSubscriptionDetails() async {
    try {
      final Map<String, dynamic> subscriptionData =
          await fetchSubscriptionDetails();

      if (subscriptionData['amount'] != null &&
          subscriptionData['scheme_id'] != null &&
          subscriptionData['expiration_date'] != null &&
          subscriptionData['title'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt(
            'subscription_fee', subscriptionData['amount'].toInt());
        await prefs.setInt('scheme_id', subscriptionData['scheme_id']);
        await prefs.setString(
            'expiration_date', subscriptionData['expiration_date']);
        await prefs.setString('title', subscriptionData['title']);

        return {
          'subscriptionFee': subscriptionData['amount'].toInt(),
          'schemeId': subscriptionData['scheme_id'],
          'expirationDate': subscriptionData['expiration_date'],
          'title': subscriptionData['title'],
        };
      } else {
        throw Exception('Incomplete subscription data received from API.');
      }
    } catch (e) {
      debugPrint('Error fetching subscription details: $e');

      return {
        'subscriptionFee': 0,
        'schemeId': 0,
        'expirationDate': null,
        'title': null,
        'error': e.toString(),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getSubscriptionDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            child: Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0),
              highlightColor: const Color(0xFFFFFFFF),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 20.0,
                              width: 150.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 14.0,
                              width: 200.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 14.0,
                              width: 100.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 40.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 101, 100, 100),
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
          final subscriptionFee = snapshot.data!['subscriptionFee']!;
          final schemeId = snapshot.data!['schemeId']!;

          final amount = subscriptionFee * 100;
          const description = 'Subscription Fee';

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(153, 218, 220, 206),
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(13, 18, 25, 39),
                  offset: Offset(0, 6),
                  blurRadius: 44,
                  spreadRadius: 0,
                ),
              ],
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
                Expanded(
                  child: Column(
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
                      const SizedBox(height: 4),
                      if (status != 'active' &&
                          status != 'inactive' &&
                          status != 'pending')
                        Text(
                          'Your Membership Expires in $status days',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontFamily: 'Urbanist',
                          ),
                        )
                      else
                        Row(
                          children: [
                            Text(
                              status[0].toUpperCase() + status.substring(1),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                            if (status.toLowerCase() == 'active')
                              const SizedBox(width: 8),
                            if (status.toLowerCase() == 'inactive')
                              const SizedBox(width: 8),
                            if (status.toLowerCase() == 'active')
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              )
                            else if (status.toLowerCase() == 'inactive')
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
                if (status.toLowerCase() == 'pending')
                  TextButton(
                    onPressed: () {
                      final PaymentController controller =
                          Get.put(PaymentController());
                      controller.createOrderAndPay(
                          amount, description, schemeId, 'Peak Subscription');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Subscribe'),
                  )
                else if (status.toLowerCase() == 'inactive')
                  TextButton(
                    onPressed: () {
                      final PaymentController controller =
                          Get.put(PaymentController());
                      controller.createOrderAndPay(
                          amount, description, schemeId, 'Peak Subscription');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Renew'),
                  )
                else if (status.toLowerCase() == 'active')
                  const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  )
                else
                  TextButton(
                    onPressed: () {
                      final PaymentController controller =
                          Get.put(PaymentController());
                      controller.createOrderAndPay(
                          amount, description, schemeId, 'Peak Subscription');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Renew'),
                  ),
              ],
            ),
          );
        }
        return const SizedBox.shrink(); // Return an empty widget if no data
      },
    );
  }
}
