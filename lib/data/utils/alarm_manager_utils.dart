import 'package:real_volume/real_volume.dart';

class AlarmManagerUtils {
  AlarmManagerUtils._();

  static int getSetAlarmId({required int id}) {
    return (id * 3 + 7) % 10000;
  }

  static int getRemoveAlarmId({required int id}) {
    return (id * 5 + 10) % 10000;
  }

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
