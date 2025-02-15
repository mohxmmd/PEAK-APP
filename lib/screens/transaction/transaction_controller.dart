import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  final OtherSettings otherSettings = OtherSettings();
  final UserService userService = UserService();

  var userName = ''.obs;
  var userImage = ''.obs;
  var userJob = ''.obs;
  var userExpirationDate = ''.obs;
  var userFormattedExpDate = ''.obs;
  var membershipStatus = ''.obs;
  var transactions = <Map<String, dynamic>>[].obs;

  var userId = 0.obs;
  var ads = <String, String>{}.obs;

  String subscriptionTitle = 'Payment for Subscription';
  String subscriptionDescription = 'You have paid for the subscription.';
  String fundRaiserTitle = 'Payment for Fundraiser';
  String fundRaiserDescription = 'You have donated for the Fund Raiser';

  final apiUrl = dotenv.env['API_URL'];

  @override
  void onInit() {
    super.onInit();
    loadUserData();
    fetchTransactions();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('name') ?? 'User Name';
    userImage.value = prefs.getString('profile_picture') ?? '';
    userJob.value = prefs.getString('job_title') ?? 'Job';
    userId.value = prefs.getInt('member_id') ?? 0;

    if (userExpirationDate.value == 'Null') {
      membershipStatus.value = 'pending';
    } else {
      try {
        DateTime expirationDate =
            DateFormat('yyyy-MM-dd').parse(userExpirationDate.value);
        DateTime today = DateTime.now();

        if (expirationDate.isBefore(today)) {
          membershipStatus.value = 'inactive';
        } else {
          int daysLeft = expirationDate.difference(today).inDays;
          if (daysLeft <= 10) {
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

  void fetchTransactions() async {
    try {
      Map<String, dynamic> response = await otherSettings.fetchTransactions();
      print(
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      print(response);
      print(
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

      if (response['success'] == true && response['data'] != null) {
        List<dynamic> data = response['data'];
        List<Map<String, dynamic>> transactionsList = data
            .map((transaction) => transaction as Map<String, dynamic>)
            .toList();

        int memberId = userId.value;
        List<Map<String, dynamic>> filteredTransactions = transactionsList
            .where((transaction) => transaction['member_id'] == memberId)
            .toList();

        transactions.assignAll(filteredTransactions);
      } else {}
    } catch (e) {}
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

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
}
