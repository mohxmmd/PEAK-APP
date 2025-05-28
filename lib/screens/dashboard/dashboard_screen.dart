import 'package:peak_app/utils/screen_imports.dart';
import 'package:peak_app/widgets/dashboard_widgets/donation_card.dart';
import 'package:peak_app/widgets/dashboard_widgets/icon_button.dart';
import 'package:peak_app/widgets/dashboard_widgets/id_card.dart';
import 'package:peak_app/widgets/dashboard_widgets/membership_status_card.dart';
import 'package:peak_app/widgets/dashboard_widgets/notification_button.dart';
import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upgrader/upgrader.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Centralized TextStyle method
  Map<String, TextStyle> _getTextStyles(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return {
      "headingMedium": theme.headlineMedium!,
      "bodyMedium": theme.bodyMedium!,
      "idName": theme.titleLarge!,
      "idTextBold": theme.titleMedium!,
      "idText": theme.titleSmall!,
    };
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashBoardController());

    final textStyles = _getTextStyles(context);

    return ResponsiveLayout(
        mobileScaffold: UpgradeAlert(
      upgrader: Upgrader(
        debugDisplayAlways: true,
        durationUntilAlertAgain: const Duration(seconds: 0),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFEFC8),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _welcomeHeader(controller, textStyles["bodyMedium"]!,
                    textStyles["headingMedium"]!),
                const SizedBox(height: 23),
                Obx(() => ProfileCard(
                      userName: controller.userName.value,
                      userJob: controller.userJob.value,
                      userImage:
                          'http://www.teampeak.in/storage/${controller.userImage.value}',
                      expirationDate: controller.userFormattedExpDate.value,
                      idName: textStyles["idName"]!,
                      idTextBold: textStyles["idTextBold"]!,
                      idText: textStyles["idText"]!,
                    )),
                const SizedBox(height: 30),
                Obx(() => _adSection(controller)),
                Obx(() => MembershipStatusCard(
                      iconImage: 'assets/images/membership.png',
                      title: 'membership_status'.tr,
                      status: controller.membershipStatus.value,
                      iconColor: Colors.blue,
                      fetchSubscriptionDetails:
                          controller.getLatestSubscriptionScheme,
                    )),
                const SizedBox(height: 10),
                Obx(() => _fundRaisers(controller)),
                const SizedBox(height: 20),
                _icons(controller),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // Welcome Header Widget
  Widget _welcomeHeader(DashBoardController controller, TextStyle bodyStyle,
      TextStyle headingStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('welcome_back'.tr, style: bodyStyle),
            Obx(() => Text(
                  'hello_user'.trParams({'user': controller.userName.value}),
                  style: headingStyle,
                )),
          ],
        ),
        CustomNotificationButton(onPressed: controller.goToNotifications),
      ],
    );
  }

  Widget _adSection(DashBoardController controller) {
    // Check if ads are loading
    if (controller.isLoadingAds.value) {
      // Display skeletons while ads are loading
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            3,
            (index) => Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0),
              highlightColor: const Color(0xFFB3E5FC),
              period: const Duration(seconds: 2),
              child: Container(
                width: 246,
                height: 140,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Check if ads are available
    if (controller.ads.isEmpty) {
      // If no ads and not loading, return an empty container or nothing
      return const SizedBox.shrink();
    }

    // Display actual ads when they are loaded
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: controller.ads.entries.toList().reversed.map((entry) {
              return Container(
                width: 246,
                height: 140,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://www.teampeak.in/storage/${entry.value}'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 30), // Add space after the ad section
      ],
    );
  }

  // Icon Buttons Row
  Widget _icons(DashBoardController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomIconButton(
          image: const AssetImage('assets/images/profile.png'),
          label: 'profile'.tr,
          onTap: controller.goToProfile,
        ),
        CustomIconButton(
          image: const AssetImage('assets/images/icons/transaction.png'),
          label: 'transactions'.tr,
          onTap: controller.goToHelpCenter,
        ),
        CustomIconButton(
          image: const AssetImage('assets/images/icons/about.png'),
          label: 'about'.tr,
          onTap: controller.goToAbout,
        ),
        CustomIconButton(
          image: const AssetImage('assets/images/icons/settings.png'),
          label: 'settings'.tr,
          onTap: controller.goToSettings,
        ),
      ],
    );
  }

  // Fund Raisers Section
  Widget _fundRaisers(DashBoardController controller) {
    if (controller.fundRaisers.isEmpty) {
      return const Column(
        children: [
          // ProfileStatusCard(
          //   iconImage: 'assets/images/profile.png',
          //   title: 'profile_completion'.tr,
          //   status: "100%",
          //   iconColor: Colors.green,
          // ),
          // const SizedBox(height: 15),
        ],
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.fundRaisers.length,
      itemBuilder: (context, index) {
        final fundRaiser = controller.fundRaisers.reversed.toList()[index];
        return Column(
          children: [
            DonationCard(
              iconImage: 'assets/images/donate.png',
              title: fundRaiser['title'] ?? 'N/A',
              schemeId: fundRaiser['scheme_id'],
              description: fundRaiser['description'] ?? 'N/A',
              iconColor: const Color.fromARGB(255, 255, 255, 255),
              amount: (fundRaiser['amount'] ?? '0.00').toString(),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
