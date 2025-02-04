import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/screens/success/success_controller.dart';

class ThanksScreen extends StatelessWidget {
  ThanksScreen({super.key});
  final controller = Get.put(SuccessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F2E0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            _buildSuccessContent(),
            const Spacer(),
            _buildBackToDashboardButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/donation_success.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            'Thank You for Your Donation!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(220, 30, 29, 29),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your generous contribution will help us achieve our goals. '
            'We deeply appreciate your support.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(226, 55, 55, 55),
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackToDashboardButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.onTapContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF90C764),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Go to Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
