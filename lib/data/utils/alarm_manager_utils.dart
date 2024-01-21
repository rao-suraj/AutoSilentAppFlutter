import 'package:real_volume/real_volume.dart';

class AlarmManagerUtils {
  AlarmManagerUtils._();

  static int getSetAlarmId({required int id}) {
    return (id * 3 + 7) % 10000;
  }

  static int getRemoveAlarmId({required int id}) {
    return (id * 5 + 10) % 10000;
  }

   @pragma('vm:entry-point')
  static Future<void> setSilent() async {
    print("Settt");
    await RealVolume.setRingerMode(RingerMode.SILENT);
  }

  @pragma('vm:entry-point')
  static Future<void> removeSilent() async {
    print("Remove");
    await RealVolume.setRingerMode(RingerMode.NORMAL);
  }
}