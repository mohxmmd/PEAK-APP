import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class UserService {
  final apiUrl = dotenv.env['API_URL'];

  Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('member_id');
    var token = prefs.getString('token');

    try {
      final url = Uri.parse('$apiUrl/members/$memberId');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(response.body);
        return userData;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<void> saveUserDataToLocal() async {
    final prefs = await SharedPreferences.getInstance();

    var userData = await getUserData();

    if (userData.containsKey('member_id')) {
      prefs.setInt('member_id', userData['member_id'] ?? 0);
    }
    prefs.setBool('isLoggedIn', true);
    userData.forEach((key, value) {
      if (key != 'member_id') {
        if (value is int) {
          prefs.setInt(key, value);
        } else if (value is double) {
          prefs.setDouble(key, value);
        } else if (value is bool) {
          prefs.setBool(key, value);
        } else if (value is String) {
          prefs.setString(key, value);
        } else if (value == null) {
          prefs.setString(key, '');
        } else {
          prefs.setString(key, value.toString());
        }
      }
    });
  }

  Future<void> updateUserData(
      Map<String, dynamic> registrationData, int memberId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('member_id');
    var token = prefs.getString('token');
    try {
      final String registerUrl = '$apiUrl/members/$memberId?_method=PATCH';

      var request = http.MultipartRequest('POST', Uri.parse(registerUrl));

      request.headers['Authorization'] = 'Bearer $token';

      registrationData.forEach((key, value) {
        request.fields[key] = value.toString();
      });

      if (registrationData['profile_picture'] != null &&
          registrationData['profile_picture'] != '') {
        String profileImagePath = registrationData['profile_picture'];

        if (File(profileImagePath).existsSync()) {
          request.files.add(await http.MultipartFile.fromPath(
            'profile_picture',
            profileImagePath,
            filename: basename(profileImagePath),
          ));
        } else {}
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        saveUserDataToLocal();
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<bool> deleteAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? memberId = prefs.getInt('member_id');
    var token = prefs.getString('token');

    if (memberId == null || token == null) {
      return false; // If memberId or token is missing, return false
    }

    try {
      final url = Uri.parse('$apiUrl/members/$memberId');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // If the account is successfully deleted, return true
        return true;
      } else {
        // If the response status code is not 200 or 204, return false
        return false;
      }
    } catch (e) {
      // If an exception occurs, return false
      return false;
    }
  }
}
