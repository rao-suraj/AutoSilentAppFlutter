import 'package:real_volume/real_volume.dart';

class AlarmManagerFunctions {

  /// function to make the phone silent(Put it to Vibration mode)
  @pragma('vm:entry-point')
  static void setSilentMode() async {
    bool? permission = await RealVolume.isPermissionGranted();

    if (!permission!) {
      await RealVolume.openDoNotDisturbSettings();
    }
    try {
      await RealVolume.setRingerMode(RingerMode.VIBRATE);
    } catch (e) {
      print(e);
    }
    print("SetMode ${DateTime.now().hour} ${DateTime.now().minute}");
  }

  /// Function to remove the phone from silent mode
  @pragma('vm:entry-point')
  static void removeSilentMode() async {
    try {
      await RealVolume.setRingerMode(RingerMode.NORMAL);
    } catch (e) {
      print(e);
    }
    print("RemoveMode ${DateTime.now().hour} ${DateTime.now().minute}");
  }
}
