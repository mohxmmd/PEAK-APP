import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class OtherSettings {
  final String? apiUrl = dotenv.env['API_URL'];

  // Common method to get headers with authorization
  Future<Map<String, String>> _getHeaders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token'
    };
  }

  // Fetch countries
  Future<List<String>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/country'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((country) => country['name'] as String).toList();
      }
      throw Exception('Failed to load countries: ${response.body}');
    } catch (e) {
      debugPrint('Error fetching countries: $e');
      rethrow;
    }
  }

  // Fetch advertisements
  Future<Map<String, String>> fetchAds() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/advertisement'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final Map<String, String> ads = {
          for (var ad in data) ad['name'] as String: ad['image'] as String
        };

        // Cache ads locally
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('ads', json.encode(ads));

        return ads;
      }
      throw Exception('Failed to load advertisements: ${response.body}');
    } catch (e) {
      debugPrint('Error fetching advertisements: $e');
      rethrow;
    }
  }

  // Generic GET request handler
  Future<dynamic> _fetchData(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/$endpoint'),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load $endpoint: ${response.body}');
    } catch (e) {
      debugPrint('Error fetching $endpoint: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchTransactions() async =>
      await _fetchData('transactions');

  Future<Map<String, dynamic>> fetchSubscriptionFee() async {
    final data = await _fetchData('subscription-fee');
    return {'subscription_fee': data['subscription_fee']};
  }

  Future<String> fetchRazorpayKey() async {
    final data = await _fetchData('razorpay-key');
    return data['payment_key'] as String;
  }

  Future<Map<String, dynamic>> fetchFundRaisers() async =>
      await _fetchData('fundraisers');

  Future<Map<String, dynamic>> fetchLatestSubscriptionScheme() async {
    try {
      final data = await _fetchData('subscriptionscheme');

      if (data['data'] != null) {
        final scheme = data['data'];
        return {
          "message": data['message'],
          "expiration_date": scheme['expiration_date'],
          "amount": scheme['amount'],
          "scheme_id": scheme['scheme_id'],
          "title": scheme['title'],
        };
      }
      throw Exception('No active subscription schemes found.');
    } catch (e) {
      debugPrint('Error fetching subscription scheme: $e');
      return {
        "message": "An error occurred while fetching subscription schemes.",
        "data": null,
        "error": e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> fetchNotifications() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? memberId = prefs.getInt('member_id');
      var token = prefs.getString('token');

      if (memberId == null) {
        throw Exception('No member ID found in shared preferences');
      }

      // Make the HTTP POST request directly here
      final response = await http.post(
        Uri.parse('$apiUrl/notifications/list'), // POST request URL
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body:
            json.encode({'member_id': memberId}), // Pass member_id in the body
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> notificationList = data['notifications'];
       
        // Filter notifications
        final filteredNotifications = notificationList.where((notification) {
          if (notification['type'] == 'general') {
            return true;
          } else if (notification['type'] == 'personal') {
            return notification['recipient'] == memberId;
          }
          return false;
        }).toList();

        await markAsSeen(filteredNotifications);

        return {'notifications': filteredNotifications};
      } else {
        throw Exception('Failed to load notifications: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
      rethrow;
    }
  }

  Future<void> markAsSeen(notifications) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? memberId = prefs.getInt('member_id');

      final notificationIds = notifications
          .map((notification) => notification['notification_id'])
          .toList();

      await http.post(
        Uri.parse('$apiUrl/notifications/mark-all-seen'),
        headers: await _getHeaders(),
        body: json.encode({
          'member_id': memberId,
          'notification_ids': notificationIds,
        }),
      );
    } catch (e) {
      debugPrint('Error marking notifications as seen: $e');
    }
  }
}
