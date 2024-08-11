import 'package:auto_silent_app/data/utils/alarm_manager_utils.dart';
import 'package:auto_silent_app/data/utils/app_alarm_manager.dart';
import 'package:injectable/injectable.dart';

abstract class SessionServices {
  Future<void> setSession(
      {required int id,
      required DateTime startDate,
      required DateTime endDate});

  Future<void> removeSession({required int id});
}

@LazySingleton(as: SessionServices)
class SessionServiceImpl extends SessionServices {
  final AppAlarmManger _alarmManger;

  SessionServiceImpl(this._alarmManger);

  @override
  Future<void> setSession(
      {required int id,
      required DateTime startDate,
      required DateTime endDate}) async {
    await _alarmManger.setExactAlarm(
        id: AlarmManagerUtils.getSetAlarmId(id: id), dateTime: startDate);

    await _alarmManger.removeExactAlarm(
        id: AlarmManagerUtils.getRemoveAlarmId(id: id), dateTime: endDate);
  }

  @override
  Future<void> removeSession({required int id}) async {
    await _alarmManger.cancleExactAlarm(
        id: AlarmManagerUtils.getSetAlarmId(id: id));
    await _alarmManger.cancleExactAlarm(
        id: AlarmManagerUtils.getRemoveAlarmId(id: id));


  }
}
