import 'dart:convert';

import 'package:cinneman/data/models/ticket.dart';
import 'package:cinneman/data/models/user.dart';
import 'package:cinneman/services/device_service.dart';
import 'package:cryptography/cryptography.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthApiService {
  static String apiUrl = dotenv.env['API_URL']!;
  static String secretKey = dotenv.env['API_SECRET']!;

  final Dio _dio = Dio();
  final DeviceService _deviceService;

  AuthApiService({DeviceService? deviceService})
      : _deviceService = deviceService ?? DeviceService();

  Future<String?> getGuestAccessToken() async {
    final sessionToken = await _getSessionToken();
    if (sessionToken != null) {
      return await _getTokenFromSessionToken(sessionToken);
    }
    return null;
  }

  Future<String?> getAuthorizedAccessToken(
      String phoneNumber, String otp) async {
    try {
      final response = await _dio.post(
        "$apiUrl/api/auth/login",
        data: {"phoneNumber": phoneNumber, "otp": otp},
      );
      final jsonResponse = response.data;
      if (jsonResponse["success"]) {
        return jsonResponse["data"]["accessToken"];
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<bool> sendOtpRequest(String phoneNumber) async {
    try {
      final response = await _dio.post(
        "$apiUrl/api/auth/otp",
        data: {"phoneNumber": phoneNumber},
      );
      final jsonResponse = response.data;
      return jsonResponse["success"] && jsonResponse["data"];
    } catch (e) {
      return false;
    }
  }

  Future<String?> _getSessionToken() async {
    try {
      final response = await _dio.post("$apiUrl/api/auth/session");
      final jsonResponse = response.data;

      if (jsonResponse["success"]) {
        return jsonResponse["data"]["sessionToken"];
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String?> _getTokenFromSessionToken(String sessionToken) async {
    try {
      final signature = await _calculateSignature(sessionToken);
      final tokenResponse = await _dio.post(
        "$apiUrl/api/auth/token",
        options: Options(contentType: Headers.jsonContentType),
        data: json.encode({
          "sessionToken": sessionToken,
          "signature": signature,
          "deviceId": await _deviceService.getDeviceId(),
        }),
      );

      final tokenJsonResponse = tokenResponse.data;
      if (tokenJsonResponse["success"]) {
        return tokenJsonResponse["data"]["sessionToken"];
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<User?> getCurrentUser(String accessToken) async {
    try {
      final response = await _dio.get(
        "$apiUrl/api/user",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      final jsonResponse = response.data;
      if (jsonResponse["success"]) {
        return User.fromJson(jsonResponse["data"]);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Ticket>?> getTickets(String accessToken) async {
    try {
      final response = await _dio.get(
        "$apiUrl/api/user/tickets",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      final jsonResponse = response.data;
      if (jsonResponse["success"]) {
        return (jsonResponse["data"] as List)
            .map((item) => Ticket.fromJson(item))
            .toList();
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<String> _calculateSignature(String sessionToken) async {
    final hash = await Sha256().hash(
      utf8.encode(sessionToken + secretKey),
    );
    return hash.bytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}
