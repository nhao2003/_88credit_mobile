import 'package:android_id/android_id.dart';

class DeviceInfo {
  static Future<String?> getDeviceID() async {
    const androidIdPlugin = AndroidId();

    final String? androidId = await androidIdPlugin.getId();
    return androidId;
  }
}
