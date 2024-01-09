import 'package:real_volume/real_volume.dart';

class AppFunctions {
  @pragma('vm:entry-point')
  static void printHello() async {
    // final DateTime now = DateTime.now();
    // final int isolateId = Isolate.current.hashCode;
    // print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
    bool? permission = await RealVolume.isPermissionGranted();

    if (!permission!) {
      await RealVolume.openDoNotDisturbSettings();
    }
    await RealVolume.setRingerMode(RingerMode.SILENT);
  }
}
