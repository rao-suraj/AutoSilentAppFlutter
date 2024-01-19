import 'package:auto_silent_app/data/utils/app_alarm_manager_utils.dart';
import 'package:injectable/injectable.dart';

abstract class CalendarServices {
  Future<void> setAlarm(
      {required int id,
      required DateTime startDate,
      required DateTime endDate});

  Future<void> removeAlarm({required int id});
}

@LazySingleton(as: CalendarServices)
class CaneldarServiceImpl extends CalendarServices {
  final AppAlarmManger _alarmManger;

  CaneldarServiceImpl(this._alarmManger);
  Future<void> setAlarm(
      {required int id,
      required DateTime startDate,
      required DateTime endDate}) async {
    await _alarmManger.setExactAlarm(
        id: AlarmManagerUtils.getSetAlarmId(id: id), dateTime: startDate);

    await _alarmManger.setExactAlarm(
        id: AlarmManagerUtils.getRemoveAlarmId(id: id), dateTime: endDate);
  }

  @override
  Future<void> removeAlarm({required int id}) async {
    await _alarmManger.removeExactAlarm(
        id: AlarmManagerUtils.getSetAlarmId(id: id));
    await _alarmManger.removeExactAlarm(
        id: AlarmManagerUtils.getRemoveAlarmId(id: id));
  }
}
