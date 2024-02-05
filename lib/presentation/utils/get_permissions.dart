import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_volume/real_volume.dart';

class GetPermissions {
  GetPermissions._();

  static Future<void> getPermission() async {
    bool? isPermissionGranted = await RealVolume.isPermissionGranted();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (!isPermissionGranted!) {
      // Opens Do Not Disturb Access settings to grant the access
      await RealVolume.openDoNotDisturbSettings();
    }
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        PermissionStatus granted = await Permission.scheduleExactAlarm.status;
        if (granted.isDenied) {
          await Permission.scheduleExactAlarm.request();
        }
      }
    }
  }
}
