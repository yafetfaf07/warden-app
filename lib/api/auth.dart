import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:warden_app/models/exit_response.dart';
import 'package:warden_app/models/incident_report.dart';
import 'package:warden_app/models/vehicle_session.dart';
import 'package:warden_app/models/warden.dart';

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
        return (data, false);
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

  Future<(Map<String, dynamic>?, bool)> verifyBooking(String bookingRef) async {
    try {
      final response = await http.get(
        Uri.parse(
          "$apiUrl/parking-avenue/reservation/verify?bookingRef=$bookingRef",
        ),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return (data, true);
      } else {
        return (null, false);
      }
    } catch (e) {
      print("Error $e");
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
        body: jsonEncode({"otp": otp, "phoneNo": ethiopianNumber}),
      );

      // 1. Decode the response body
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 201) {
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

  Future<(Warden?, bool)> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$apiUrl/warden/me"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      print("Profile response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final Warden warden = Warden.fromJson(data);
        return (warden, true);
      } else {
        print("Server returned an error: ${response.body}");
        return (null, false);
      }
    } catch (e) {
      print("Error happened when getting profile: $e");
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

  Future<(VehicleSession?, bool)> checkin(
  String licenseNo,
  String parkingAvenueId,
) async {
  try {
    final response = await http.post(
      Uri.parse("$apiUrl/check-in"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await getAccessToken()}", // Add this if protected
      },
      body: jsonEncode({
        "licensePlate": licenseNo,
        "parkingAvenueId": parkingAvenueId,
      }),
    );

    print("Check-in Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final VehicleSession session = VehicleSession.fromJson(data);

      return (session, true);
    } else {
      print("Check-in failed: ${response.statusCode} - ${response.body}");
      return (null, false);
    }
  } catch (e, stackTrace) {
    print("Check-in Error: $e");
    print("StackTrace: $stackTrace");
    return (null, false);
  }
}

Future<(IncidentReport?, bool)> reportIncident(
  String category,
  String reason,
  String parkingAvenueId,
) async {
  try {
    final response = await http.post(
      Uri.parse("http://localhost:3000/incident-report"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await getAccessToken()}",
      },
      body: jsonEncode({
        "category": category,
        "reason": reason,
        "parkingAvenueId": parkingAvenueId,
      }),
    );

    print("Incident Report Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    // The server returns 201 for a successful creation
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final IncidentReport report = IncidentReport.fromJson(data);

      return (report, true);
    } else {
      print("Incident reporting failed: ${response.statusCode} - ${response.body}");
      return (null, false);
    }
  } catch (e, stackTrace) {
    print("Incident Report Error: $e");
    print("StackTrace: $stackTrace");
    return (null, false);
  }
}
Future<(ExitResponse?, bool)> processExit(String licensePlate) async {
  try {
    // Constructing the URL with query parameters
    final String url = "http://localhost:3000/check-in/exit?licensePlate=$licensePlate";

    final response = await http.delete(
      Uri.parse(url),
    );

    print("Exit Request Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

 
    if (response.statusCode == 200 || response.statusCode == 402) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final ExitResponse exitInfo = ExitResponse.fromJson(data);

      return (exitInfo, true);
    } else {
      print("Exit failed: ${response.statusCode}");
      return (null, false);
    }
  } catch (e, stackTrace) {
    print("Exit Error: $e");
    print("StackTrace: $stackTrace");
    return (null, false);
  }
}

}
