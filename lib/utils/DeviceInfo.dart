import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceInfo {
  final deviceInfo = DeviceInfoPlugin();

  Future<String> getPhoneInfo() async {
    final info = await deviceInfo.androidInfo;
    if (Platform.isAndroid) {
      return '${info.manufacturer}-${info.model}';
    } else if (Platform.isIOS) {
      return '${info.manufacturer}-${info.model}';
    } else {
      throw UnimplementedError();
    }
  }
}
