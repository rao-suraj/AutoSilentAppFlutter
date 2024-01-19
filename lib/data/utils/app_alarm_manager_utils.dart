import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:auto_silent_app/data/utils/real_volume_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:real_volume/real_volume.dart';

class AlarmManagerUtils {
  AlarmManagerUtils._();

  static int getSetAlarmId({required int id}) {
    return (id * 3 + 7) % 10000;
  }

  static int getRemoveAlarmId({required int id}) {
    return (id * 5 + 10) % 10000;
  }
}

abstract class AppAlarmManger {
  Future<void> setExactAlarm({required int id, required DateTime dateTime});

  Future<void> removeExactAlarm({required int id});
}

@LazySingleton(as: AppAlarmManger)
class AppAlarmManagerImp extends AppAlarmManger {
  final RealVolumeManager _rvManager;

  AppAlarmManagerImp(this._rvManager);

  @override
  Future<void> setExactAlarm(
      {required int id, required DateTime dateTime}) async {
    await AndroidAlarmManager.oneShotAt(dateTime, id, setSilentMode);
  }

  @override
  Future<void> removeExactAlarm({required int id}) async {
    await AndroidAlarmManager.cancel(id);
  }

  // have to change it 
  @pragma('vm:entry-point')
  void setSilentMode() async {
    await _rvManager.setRingerMode(ringerMode: RingerMode.VIBRATE);
  }

  // have to change it 
  @pragma('vm:entry-point')
  void removeSilentMode() async {
    await _rvManager.setRingerMode(ringerMode: RingerMode.NORMAL);
  }
}
