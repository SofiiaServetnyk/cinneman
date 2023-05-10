import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class DeviceService {
  static const String _deviceIdKey = 'cinneman_device_id';

  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    String? deviceId = prefs.getString(_deviceIdKey);

    if (deviceId == null) {
      deviceId = _generateRandomString();
      await prefs.setString(_deviceIdKey, deviceId);
    }

    return deviceId;
  }

  String _generateRandomString({int length = 16}) {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      List.generate(length,
          (_) => characters.codeUnitAt(random.nextInt(characters.length))),
    );
  }
}
