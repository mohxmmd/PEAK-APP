import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/screens/success/success_controller.dart';

class PaymentSuccessScreen extends StatelessWidget {
  PaymentSuccessScreen({super.key});
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
            _buildBackToHomeButton(context),
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
        children: [
          Image.asset(
            'assets/images/success.png',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
          const Text(
            'Membership Updated!',
            style: TextStyle(
              color: Color.fromARGB(210, 31, 31, 31),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your membership has been successfully updated.',
            style: TextStyle(
              color: Color.fromARGB(215, 27, 27, 27),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
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
            'Go To Home',
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
