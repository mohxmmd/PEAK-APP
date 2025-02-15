import 'package:peak_app/screens/transaction/transaction_controller.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';
import 'package:intl/intl.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Text(
                    'transactions'.tr,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Color(0xFF606363),
            ),
            Expanded(
              child: Obx(() {
                // Observe transactions
                if (controller.transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.money_off,
                          size: 80,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'transactions_empty'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 18),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          controller.transactions.reversed.toList()[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        color: const Color(0xFF90C764),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (() {
                                  // Conditional title logic
                                  if (transaction['description'] ==
                                      'Subscription Fee') {
                                    return controller.subscriptionTitle;
                                  } else if (transaction['description'] ==
                                      'Fundraiser') {
                                    return controller.fundRaiserTitle;
                                  } else if (transaction['description'] !=
                                          null &&
                                      transaction['description']
                                          .startsWith('Error')) {
                                    return 'Payment Failed';
                                  }

                                  return transaction['descriptoin'] ??
                                      'No Title';
                                })(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                (() {
                                  if (transaction['description'] ==
                                      'Subscription Fee') {
                                    return controller.subscriptionDescription;
                                  } else if (transaction['description'] ==
                                      'Fundraiser') {
                                    return controller.fundRaiserDescription;
                                  } else if (transaction['description'] !=
                                          null &&
                                      transaction['description']
                                          .startsWith('Error')) {
                                    return 'Your payment could not be processed. Please try again or contact support for assistance.';
                                  }
                                  return 'No Description';
                                })(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontSize: 14.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                (() {
                                  if (transaction['amount'] != null) {
                                    double amount = double.tryParse(
                                            transaction['amount'].toString()) ??
                                        0.0;
                                    amount;
                                    return '₹${amount.toStringAsFixed(2)}';
                                  }
                                  return 'No Amount';
                                })(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                    ),
                              ),
                              const SizedBox(height: 8.0),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  (() {
                                    if (transaction['created_at'] != null) {
                                      try {
                                        final DateTime dateTime =
                                            DateTime.parse(
                                                transaction['created_at']);
                                        final String formattedDate =
                                            DateFormat('MMM d yyyy')
                                                .format(dateTime);
                                        final String formattedTime =
                                            DateFormat('hh:mm a')
                                                .format(dateTime.toLocal());

                                        return '$formattedDate\n$formattedTime';
                                      } catch (e) {
                                        return 'Invalid Date';
                                      }
                                    }
                                    return 'No Time';
                                  })(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: const Color.fromARGB(
                                                255, 33, 33, 33)
                                            .withOpacity(0.6),
                                        fontSize: 12.0,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
