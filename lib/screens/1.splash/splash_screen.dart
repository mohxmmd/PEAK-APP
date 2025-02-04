import 'package:peak_app/utils/screen_imports.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    double spinnerSize = MediaQuery.of(context).size.width * 0.15;

    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/splash-logo.png',
                width: 150,
                height: 150,
              ),
            ),
            Positioned(
              bottom:
                  70.0,
              left: 0,
              right: 0,
              child: SpinKitCircle(
                color: const Color(0xFF90C764),
                size: spinnerSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
