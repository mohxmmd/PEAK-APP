import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:peak_app/screens/1.splash/splash_screen.dart';
import 'package:peak_app/screens/2.login/login_screen.dart';
import 'package:peak_app/screens/3.otp/otp_screen.dart';
import 'package:peak_app/screens/4.registration/step1/registration_screen_1.dart';
import 'package:peak_app/screens/4.registration/step2/registration_screen_2.dart';
import 'package:peak_app/screens/4.registration/step3/registration_screen_3.dart';
import 'package:peak_app/screens/5.dashboard/dashboard_screen.dart';
import 'package:peak_app/screens/6.profile/profile_screen.dart';
import 'package:peak_app/screens/7.update_profile/additional_information/additional_info_screen.dart';
import 'package:peak_app/screens/7.update_profile/personal_information/personal_info_screen.dart';
import 'package:peak_app/screens/7.update_profile/profesional_information/professional_info_screen.dart';
import 'package:peak_app/screens/About/abouts_screen.dart';
import 'package:peak_app/screens/transaction/transaction_screen.dart';
import 'package:peak_app/screens/notification/notification_screen.dart';
import 'package:peak_app/screens/settings/settings_screen.dart';
import 'package:peak_app/screens/success/payment_success.dart';
import 'package:peak_app/screens/success/registration_success.dart';
import 'package:peak_app/screens/success/donation_success.dart';

import '/routes/routes.dart';

class RoutePageList {
  static var list = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.logInScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => OtpScreen(),
    ),
    GetPage(
      name: Routes.registrationScreen1,
      page: () => Registration1Screen(),
    ),
    GetPage(
      name: Routes.registrationScreen2,
      page: () => Registration2Screen(),
    ),
    GetPage(
      name: Routes.registrationScreen3,
      page: () => Registration3Screen(),
    ),
    GetPage(
      name: Routes.successScreen,
      page: () => SuccessScreen(),
    ),
    GetPage(
      name: Routes.dashboardScreen,
      page: () => const DashboardScreen(),
    ),
    GetPage(
      name: Routes.profileScreen,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: Routes.personalInfoScreen,
      page: () => PersonalInfoScreen(),
    ),
    GetPage(
      name: Routes.professionalInfoScreen,
      page: () => ProfessionalInfoScreen(),
    ),
    GetPage(
      name: Routes.additionalInfoScreen,
      page: () => AdditionalInfoScreen(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: Routes.settingsScreen,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: Routes.aboutScreen,
      page: () => const AboutsScreen(),
    ),
    GetPage(
      name: Routes.helpCenterScreen,
      page: () => const HelpCenterScreen(),
    ),
    GetPage(
      name: Routes.thanksScreen,
      page: () => ThanksScreen(),
    ),
    GetPage(
      name: Routes.paymentSuccessScreen,
      page: () => PaymentSuccessScreen(),
    ),
  ];
}
