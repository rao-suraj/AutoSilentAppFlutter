import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:injectable/injectable.dart';

abstract class CalandarLocalDataSource {
  Future<void> insertCalendar({required Calendar calendar});

  Future<void> updateCalendar({required Calendar calendar});

  Future<void> deleteCalendar({required int id});

  Stream<List<Calendar>> getAllCalendarStream();

  Future<List<Calendar>> getAllActiveCalendars();

  Future<void> removeExpiredCalendar({required int endTime});
}

@LazySingleton(as: CalandarLocalDataSource)
class CalendarLocalDataSourceImpl extends CalandarLocalDataSource {
  final AppDatabase _database;
  CalendarLocalDataSourceImpl(this._database);
  @override
  Future<void> deleteCalendar({required int id}) async {
    try {
      await _database.calendarDao.deleteCalendar(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Calendar>> getAllCalendarStream() {
    try {
      return _database.calendarDao.getAllCalendarStream();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertCalendar({required Calendar calendar}) async {
    try {
      await _database.calendarDao.insertCalendar(calendar);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateCalendar({required Calendar calendar}) async {
    try {
      await _database.calendarDao.updateCalendar(calendar);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Calendar>> getAllActiveCalendars() async {
    try {
      return await _database.calendarDao.getAllActiveCalendars(true);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeExpiredCalendar({required int endTime}) async {
   await _database.calendarDao.removeExpiredCalendars(endTime);
  }
}
