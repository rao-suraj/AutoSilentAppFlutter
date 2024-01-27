import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:auto_silent_app/data/utils/alarm_manager_utils.dart';
import 'package:injectable/injectable.dart';

abstract class AppAlarmManger {
  Future<void> setExactAlarm({required int id, required DateTime dateTime});

  Future<void> removeExactAlarm({required int id, required DateTime dateTime});

  Future<void> cancleExactAlarm({required int id});
}

@LazySingleton(as: AppAlarmManger)
class AppAlarmManagerImp extends AppAlarmManger {
  AppAlarmManagerImp();

  // Since the functions provided to AlarmManager must be static I used AlarmManagerUtils to specify it and not RealVolumeManager
  @override
  Future<void> setExactAlarm(
      {required int id, required DateTime dateTime}) async {
    await AndroidAlarmManager.oneShotAt(
        dateTime, id, AlarmManagerUtils.setSilentMode,
        exact: true, rescheduleOnReboot: true);
  }

  @override
  Future<void> removeExactAlarm(
      {required int id, required DateTime dateTime}) async {
    await AndroidAlarmManager.oneShotAt(
        dateTime, id, AlarmManagerUtils.removeSilentMode,
        exact: true, rescheduleOnReboot: true);
  }

  @override
  Future<void> cancleExactAlarm({required int id}) async {
    await AndroidAlarmManager.cancel(id);
  }
}
