import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:real_volume/real_volume.dart';

abstract class PermissionServices {
  Future<bool?> isDNDGranted();

  Future<bool?> isSetExactAlarmGranted();

  Future<bool?> askDNDPermission();

  Future<bool?> askSetExactPermission();
}

@LazySingleton(as: PermissionServices)
class PermissionServicesImpl extends PermissionServices {
  @override
  Future<bool?> askDNDPermission() {
    return RealVolume.openDoNotDisturbSettings();
  }

  @override
  Future<bool?> askSetExactPermission() async {
    await Permission.scheduleExactAlarm
        .onGrantedCallback(() => true)
        .onDeniedCallback(() => false)
        .onPermanentlyDeniedCallback(() => false)
        .request();
    return null;
  }

  @override
  Future<bool?> isDNDGranted() async {
    return await RealVolume.isPermissionGranted();
  }

  @override
  Future<bool?> isSetExactAlarmGranted() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 33) {
      final PermissionStatus status =
          await Permission.scheduleExactAlarm.status;
      if (status.isGranted) {
        return true;
      }
      if (status.isDenied || status.isPermanentlyDenied) {
        return false;
      } else {
        return null;
      }
    } else {
      return true;
    }
  }
}
