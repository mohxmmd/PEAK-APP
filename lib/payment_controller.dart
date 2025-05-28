import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:peak_app/routes/routes.dart';
import 'package:peak_app/screens/dashboard/dashboard_controller.dart';
import 'package:peak_app/screens/transaction/transaction_controller.dart';
import 'package:peak_app/services/other_settings.dart';
import 'package:peak_app/services/user_service.dart';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  final String? apiUrl = dotenv.env['API_URL'];
  final DashBoardController dashboardController = Get.find();
  final UserService userService = UserService();

  final OtherSettings otherSettings = OtherSettings();

  var userName = ''.obs;
  var mobileNumber = ''.obs;
  var emailId = ''.obs;

  int subscriptionAmount = 0;
  int currentTransactionId = 0;
  String paymentDescription = '';
  int paymentSchemeId = 0;
  String razorpayKey = '';

  static const currency = 'INR';

  @override
  void onInit() {
    super.onInit();
    _initializeRazorpay();
    _loadUserData();
    if (apiUrl == null) {
      logError("API_URL is not set in the .env file");
    }
    tz.initializeTimeZones();
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void _initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString('name') ?? 'User Name';
    razorpayKey = prefs.getString('razorpay_key') ?? '';
    mobileNumber.value = prefs.getString('mobile_number') ?? '';
    emailId.value = prefs.getString('email_id') ?? '';
  }

  String _generateReferenceId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomString = List.generate(6, (_) {
      const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      return chars[Random().nextInt(chars.length)];
    }).join();
    return 'REF-$timestamp-$randomString';
  }

  Future<void> createOrderAndPay(
      int amount, String description, int schemeId, String title) async {
    final url = '$apiUrl/create-order';
    final prefs = await SharedPreferences.getInstance();
    final referenceId = _generateReferenceId();

    _storeTransaction(amount, description, schemeId, referenceId);

    var token = prefs.getString('token');
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'amount': amount}),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      openCheckout(
          amount, description, schemeId, title, data['order_id'], referenceId);
    }
  }

  void openCheckout(int amount, String description, int schemeId, String title,
      String orderId, String referenceId) async {
    subscriptionAmount = amount;
    paymentDescription = description;
    paymentSchemeId = schemeId;

    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('member_id') ?? 0;
    final memberName = prefs.getString('name') ?? 'Anonymous';

    final options = {
      'key': razorpayKey,
      'amount': subscriptionAmount,
      'name': 'PEAK',
      'description': title,
      'order_id': orderId,
      'prefill': {
        'contact': mobileNumber.value,
        'email': emailId.value,
      },
      'notes': {
        'name': memberName,
        'member_id': memberId,
        'reference_id': referenceId,
      },
      'method': {
        'card': false,
        'netbanking': false,
        'upi': true,
        'wallet': false,
      },
      'external': {
        'wallets': ['paytm']
      },
      'payment_capture': '1',
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      logError("Error opening Razorpay: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    logInfo("Payment Successful");
    dashboardController.refreshData();
    await _updateTransaction(response, true);

    if (paymentDescription == 'Subscription Fee') {
      await _updateExpiryDate();
      _navigateToScreen(Routes.paymentSuccessScreen);
    } else if (paymentDescription == 'Fundraiser') {
      _navigateToScreen(Routes.thanksScreen);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    logError("Payment Failed");
    debugPrint(response.error.toString());
    await _updateTransaction(response, false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    logInfo("External Wallet Selected: ${response.walletName}");
  }

  Future<void> _updateTransaction(dynamic response, bool isSuccess) async {
    final url = '$apiUrl/transactions/$currentTransactionId?_method=PATCH';
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('member_id') ?? 0;
    final memberName = prefs.getString('name') ?? 'Anonymous';
    var token = prefs.getString('token');

    final data = {
      'member_id': memberId,
      'scheme_id': int.tryParse(paymentSchemeId.toString()),
      'member_name': memberName,
      'razorpay_payment_id': isSuccess ? response.paymentId : null,
      'razorpay_signature': isSuccess ? response.signature : null,
      'amount': subscriptionAmount / 100,
      'currency': currency,
      'status': isSuccess ? '2' : '0',
      'description': isSuccess
          ? paymentDescription
          : 'Error Code:${response.code}, Error Message:${response.message}',
    };

    try {
      final apiResponse = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(data),
      );

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        logInfo("Transaction stored successfully.");
        if (isSuccess) dashboardController.loadUserData();
        final transactionController = Get.put(TransactionController());
        transactionController.fetchTransactions();
      } else {
        logError(
            "Failed to store transaction: ${apiResponse.statusCode}\n${apiResponse.body}");
      }
    } catch (e) {
      logError("Error storing transaction: $e");
    }
  }

  Future<void> _storeTransaction(
      int amount, String description, int schemeId, String referenceId) async {
    final url = '$apiUrl/transactions';
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('member_id') ?? 0;
    final memberName = prefs.getString('name') ?? 'Anonymous';

    var token = prefs.getString('token');

    final data = {
      'member_id': memberId,
      'scheme_id': schemeId,
      'member_name': memberName,
      'razorpay_payment_id': null,
      'razorpay_signature': null,
      'reference_id': referenceId,
      'amount': subscriptionAmount / 100,
      'currency': currency,
      'status': '1',
      'description': 'pending',
    };

    try {
      final apiResponse = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(data),
      );

      if (apiResponse.statusCode == 200 || apiResponse.statusCode == 201) {
        final responseData =
            jsonDecode(apiResponse.body); // Decode JSON response

        if (responseData['success'] == true) {
          currentTransactionId =
              responseData['data']['transaction_id']; // Extract transaction_id

          logInfo("Transaction stored successfully. ID: $currentTransactionId");
        }

        logInfo("Transaction stored successfully.");
      } else {
        logError(
            "Failed to store transaction: ${apiResponse.statusCode}\n${apiResponse.body}");
      }
    } catch (e) {
      logError("Error storing transaction: $e");
    }
  }

  Future<void> _updateExpiryDate() async {
    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('member_id');
    final token = prefs.getString('token');
    final url = '$apiUrl/members/$memberId?_method=PATCH';

    if (memberId == null || token == null) {
      logError("Member ID or token not found.");
      return;
    }

    Map<String, dynamic> response =
        await otherSettings.fetchLatestSubscriptionScheme();

    final newExpirationDate = response['expiration_date'];

    try {
      DateTime expirationDate;
      if (newExpirationDate is String) {
        expirationDate = DateTime.parse(newExpirationDate);
      } else if (newExpirationDate is DateTime) {
        expirationDate = newExpirationDate;
      } else {
        logError("Invalid expiration date format");
        return;
      }

      final apiResponse = await http.patch(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          'expiration_date': expirationDate.toIso8601String()
        }, // Convert DateTime to ISO 8601 String
      );

      if (apiResponse.statusCode == 200) {
        prefs.setString('expiration_date',
            expirationDate.toIso8601String()); // Save ISO 8601 string
        dashboardController.refreshData();
        logInfo("Expiration date updated successfully.");
        UserService().saveUserDataToLocal();
      } else {
        logError("Failed to update expiration date: ${apiResponse.statusCode}");
      }
    } catch (e) {
      logError("Error updating expiration date: $e");
    }
  }

  void _navigateToScreen(String route) {
    Get.offNamed(route);
  }

  void logInfo(String message) {
    debugPrint("✅ $message");
  }

  void logError(String message) {
    debugPrint("❌ $message");
  }
}
