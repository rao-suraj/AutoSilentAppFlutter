import 'package:real_volume/real_volume.dart';
import '../data_source/floor/app_database.dart';

class AlarmManagerUtils {
  AlarmManagerUtils._();

  static const MAX_ID_BITS =
      32; 

  static int getSetAlarmId({required int id}) {
    return (id << (MAX_ID_BITS ~/ 2)) & ((1 << MAX_ID_BITS) - 1);
  }

  static int getRemoveAlarmId({required int id}) {
    return ~getSetAlarmId(id: id);
  }

  static int getOriginalIdFromSetAlarmId({required int setId}) {
    return (setId >> (MAX_ID_BITS ~/ 2)) & ((1 << MAX_ID_BITS) - 1);
  }

  static int getOriginalIdFromRemoveAlarmId({required int removeId}) {
    return getOriginalIdFromSetAlarmId(setId: ~removeId);
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
  static void removeSilentMode(int removeId) async {
    try {
      final AppDatabase database =
          await $FloorAppDatabase.databaseBuilder('auto_silent_app.db').build();
      await RealVolume.setRingerMode(RingerMode.NORMAL);
      await database.calendarDao.deleteCalendar(
          AlarmManagerUtils.getOriginalIdFromRemoveAlarmId(removeId: removeId));
    } catch (e) {
      print(e);
    }
    print("RemoveMode ${DateTime.now().hour} ${DateTime.now().minute}");
  }
}
