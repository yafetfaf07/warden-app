import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String apiUrl = "http://localhost:3000";
  final _storage = const FlutterSecureStorage();

  Future<(Map<String, dynamic>?, bool)> login(String phoneNo) async {
    String ethiopianNumber = "+251$phoneNo";
    print("phoneNo: $ethiopianNumber");
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/warden/sendlogin"),

        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({"phoneNo": ethiopianNumber}),
      );
      print(response.body);
      print(response.statusCode);
      if (response.body.trim().isEmpty) {
        return (null, response.statusCode == 201 || response.statusCode == 200);
      }
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return (data, true);
      } else {
        return (null, false);
      }
    } catch (e) {
      print("Error during login: $e");
      return (null, false);
    }
  }

  Future<(Map<String, dynamic>?, bool)> verify(
    String otp,
    String phoneNo,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/warden/verifylogin"),

        headers: {"Content-Type": 'application/json'},
        body: jsonEncode({
          "otp": otp,
          "phoneNo": phoneNo,
          "location": "somewhere",
        }),
      );
      print(response.body);
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return (data, true);
      } else {
        return (null, false);
      }
    } catch (e) {
      print("Error during registration: $e");
      return (null, false);
    }
  }

  Future<(Map<String, dynamic>?, bool)> verifyLogin(
    String otp,
    String phoneNo,
    String location,
  ) async {
    print("phoneNo from verifylogin: $phoneNo");
        String ethiopianNumber = "+251$phoneNo";

    try {
      final response = await http.post(
        Uri.parse("$apiUrl/warden/verifylogin"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "otp": otp,
          "phoneNo": ethiopianNumber,
          "location": location,
        }),
      );

      // 1. Decode the response body
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // 2. Store the token if it exists in the response
        await _storeTokens(data["accessToken"]);

        return (data, true);
      } else {
        print(
          "Login failed: ${response.body} status code: ${response.statusCode}",
        );
        return (null, false);
      }
    } catch (e) {
      print("Error during verification: $e");
      return (null, false);
    }
  }

  Future<void> _storeTokens(String? token) async {
    print("token: $token");
    if (token != null) await _storage.write(key: 'token', value: token);
  }

  Future<String?> getAccessToken() async => await _storage.read(key: 'token');

  Future<void> logout() async {
    await _storage.delete(key: 'token');
  }
}
