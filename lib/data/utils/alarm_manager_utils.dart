class AlarmManagerUtils {
  AlarmManagerUtils._();

  static int getSetAlarmId({required int id}) {
    return (id * 3 + 7) % 10000;
  }

  static int getRemoveAlarmId({required int id}) {
    return (id * 5 + 10) % 10000;
  }
}
