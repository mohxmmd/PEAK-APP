import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/back_button.dart';

class AboutsScreen extends StatelessWidget {
  const AboutsScreen({super.key});

  // Function to open the website
  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse('https://www.teampeak.in/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'about_peak'.tr, // Translation key
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: const Color.fromARGB(255, 70, 70, 70),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Color(0xFF606363),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'welcome_to_peak'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(
                                color: const Color.fromARGB(255, 70, 70, 70),
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                      ),
                    ),
                    Text(
                      'description'.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            color: const Color.fromARGB(179, 75, 75, 75),
                            height: 1.6,
                          ),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      'get_in_touch'.tr,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color.fromARGB(255, 70, 70, 70),
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'inquiries_feedback'.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            color: const Color.fromARGB(179, 75, 75, 75),
                            height: 1.6,
                          ),
                    ),
                    const SizedBox(height: 16.0),
                    // Clickable link to the website
                    GestureDetector(
                      onTap: _launchWebsite,
                      child: Text(
                        'Visit our website: https://www.teampeak.in/',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                              color: const Color(
                                  0xFF90C764), // Make it look like a link
                            ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),
            const Divider(
              thickness: 1.0,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'footer_text'.tr,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color.fromARGB(255, 95, 95, 95)
                            .withOpacity(0.7),
                        fontSize: 14,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
