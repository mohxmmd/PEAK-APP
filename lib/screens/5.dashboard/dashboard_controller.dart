import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardController extends GetxController {
  var userName = ''.obs;
  var userImage = ''.obs;
  var userJob = ''.obs;
  var userExpirationDate = ''.obs;
  var userFormattedExpDate = ''.obs;
  var membershipStatus = ''.obs;
  int subscriptionFee = 0;
  var fundRaisers = <Map<String, dynamic>>[].obs;
  var schemeId = 0.obs;
  var userId = 0.obs;
  var ads = <String, String>{}.obs;
  var isLoadingAds = true.obs;

  final OtherSettings otherSettings = OtherSettings();
  final apiUrl = dotenv.env['API_URL'];

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    loadAds();
    _fetchFundRaisers();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('name') ?? 'User Name';
    userImage.value = prefs.getString('profile_picture') ?? '';
    userJob.value = prefs.getString('job_title') ?? 'Job';
    userId.value = prefs.getInt('member_id') ?? 0;
    userExpirationDate.value = prefs.getString('expiration_date') ?? 'Null';
    userFormattedExpDate.value =
        _formatExpirationDate(userExpirationDate.value);
    if (userExpirationDate.value == 'Null') {
      membershipStatus.value = 'pending';
    } else {
      try {
        // Parse the expiration date
        DateTime expirationDate =
            DateFormat('yyyy-MM-dd').parse(userExpirationDate.value);
        DateTime today = DateTime.now();

        if (expirationDate.isBefore(today)) {
          membershipStatus.value = 'inactive';
        } else {
          int daysLeft = expirationDate.difference(today).inDays;
          if (daysLeft <= 30) {
            membershipStatus.value = daysLeft.toString();
          } else {
            membershipStatus.value = 'active';
          }
        }
      } catch (e) {
        membershipStatus.value = 'pending';
      }
    }
  }

  Future<void> loadAds() async {
    isLoadingAds.value = false;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedAds = prefs.getString('ads');
      if (storedAds != null) {
        ads.value = Map<String, String>.from(json.decode(storedAds));
      } else {}
    } finally {
      isLoadingAds.value = false;
    }
  }

  void _fetchFundRaisers() async {
    try {
      final responses = await Future.wait([
        otherSettings.fetchFundRaisers(),
        otherSettings.fetchTransactions(),
      ]);

      final response = responses[0];
      final transactionResponse = responses[1];

      if (response['data'] != null && transactionResponse['data'] != null) {
        final currentDate = DateTime.now();

        final allFundRaisers =
            (response['data'] as List<dynamic>).cast<Map<String, dynamic>>();
        final allTransactions = (transactionResponse['data'] as List<dynamic>)
            .cast<Map<String, dynamic>>();

        fundRaisers.value = allFundRaisers.where((fundraiser) {
          final isActive = fundraiser['status'] == 'active';

          final endDateStr = fundraiser['end_date'];
          final endDate =
              endDateStr != null ? DateTime.tryParse(endDateStr) : null;
          final isNotExpired = endDate == null || currentDate.isBefore(endDate);

          final showOnce = fundraiser['show_once'] == 1;
          final schemeId = fundraiser['scheme_id'];
          final isPaid = allTransactions.any((transaction) {
            return transaction['scheme_id'] == schemeId &&
                transaction['status'] == '2' &&
                transaction['member_id'] == userId.value;
          });

          return isActive && isNotExpired && (!showOnce || !isPaid);
        }).toList();
      } else {
        throw Exception('Invalid data received from the server');
      }
    } catch (e) {
      debugPrint('Error fetching fundraisers: $e');
    }
  }

  void goToNotifications() {
    Get.toNamed(Routes.notificationScreen);
  }

  void goToProfile() {
    Get.toNamed(Routes.profileScreen);
  }

  void goToSettings() {
    Get.toNamed(Routes.settingsScreen);
  }

  void goToAbout() {
    Get.toNamed(Routes.aboutScreen);
  }

  void goToHelpCenter() {
    Get.toNamed(Routes.helpCenterScreen);
  }

  void refreshData() {
    loadUserData();
  }

  String _formatExpirationDate(String expirationDate) {
    if (expirationDate.isEmpty || expirationDate == '0') {
      return 'N/A';
    }

    try {
      final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      final DateFormat outputFormat = DateFormat('MM/yy');
      final DateTime dateTime = inputFormat.parse(expirationDate);
      return outputFormat.format(dateTime);
    } catch (e) {
      return 'N/A';
    }
  }

  Future<Map<String, dynamic>> getLatestSubscriptionScheme() async {
    try {
      Map<String, dynamic> response =
          await otherSettings.fetchLatestSubscriptionScheme();
      return response;
    } catch (e) {
      debugPrint('Error: $e');
      return {
        'error': e.toString(),
      };
    }
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
}
