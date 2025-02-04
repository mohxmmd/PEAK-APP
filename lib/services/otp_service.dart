import 'dart:convert';
import 'package:peak_app/utils/screen_imports.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OtpService {
  final String? apiUrl = dotenv.env['API_URL'];

  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  Future<bool> verifyAndSendOTP({required String whatsAppNumber}) async {
    if (apiUrl == null) {
      throw Exception('API_URL is not configured.');
    }

    final requestBody = {"whatsappNumber": whatsAppNumber};

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/verifynumber'),
        body: jsonEncode(requestBody),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        if (data['exists'] == true) {
          final memberId = data['member_id'];

          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('member_id', memberId);

          return true;
        } else {
          return false;
        }
      } else {
        _logError('Failed to verify number', response);
        return false;
      }
    } catch (e) {
      _logError('Error in verifyAndSendOTP: $e');
      throw Exception('Check your internet connection and try again.');
    }
  }

  Future<bool> verifyOtp({required String otp}) async {
    if (apiUrl == null) {
      throw Exception('API_URL is not configured.');
    }

    final prefs = await SharedPreferences.getInstance();
    final memberId = prefs.getInt('member_id');

    if (memberId == null) {
      throw Exception('Member ID not found in local storage.');
    }

    final requestBody = {
      "otp": otp,
      "member_id": memberId,
    };

    try {
      final response = await http.post(
        Uri.parse('$apiUrl/verifyotp'),
        body: jsonEncode(requestBody),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final isVerified = data['verified'] ?? false;

        if (isVerified) {
          final token = data['token'];
          if (token != null) {
            await prefs.setString('token', token);
          }
        }

        return isVerified;
      } else {
        _logError('Failed to verify OTP', response);
        throw Exception('Failed to verify OTP. Please try again.');
      }
    } catch (e) {
      _logError('Error in verifyOtp: $e');
      throw Exception(
          'An error occurred while verifying the OTP. Please try again.');
    }
  }

  void _logError(String message, [http.Response? response]) {
    if (response != null) {
      debugPrint(
          '$message | Status Code: ${response.statusCode} | Body: ${response.body}');
    } else {
      debugPrint(message);
    }
  }
}
