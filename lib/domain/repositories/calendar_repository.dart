import 'package:auto_silent_app/data/models/calendar.dart';

abstract class CalendarRepository {
  Future<void> insertCalendar({required Calendar calendar});

  Future<void> updateCalendar({required Calendar calendar});

  Future<void> deleteCalendar({required int id});

  Stream<List<Calendar>> getAllCalendarStream();

  Future<List<Calendar>> getAllActiveCalendar();

  Future<void> setExactAlarm({required Calendar calendar});

  Future<void> removeExactAlarm({required Calendar calendar});
}
