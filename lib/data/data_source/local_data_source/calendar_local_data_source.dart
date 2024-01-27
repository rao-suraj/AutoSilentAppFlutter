import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:injectable/injectable.dart';

abstract class CalandarLocalDataSource {
  Future<void> insertCalendar({required Calendar calendar});

  Future<void> updateCalendar({required Calendar calendar});

  Future<void> deleteCalendar({required int id});

  Stream<List<Calendar>> getAllCalendarStream();

  Future<List<Calendar>> getAllActiveCalendars();
}

@LazySingleton(as: CalandarLocalDataSource)
class CalendarLocalDataSourceImpl extends CalandarLocalDataSource {
  final AppDatabase _database;
  CalendarLocalDataSourceImpl(this._database);
  @override
  Future<void> deleteCalendar({required int id}) async {
    await _database.calendarDao.deleteCalendar(id);
  }

  @override
  Stream<List<Calendar>> getAllCalendarStream() {
    return _database.calendarDao.getAllCalendarStream();
  }

  @override
  Future<void> insertCalendar({required Calendar calendar}) async {
    await _database.calendarDao.insertCalendar(calendar);
  }

  @override
  Future<void> updateCalendar({required Calendar calendar}) async {
    await _database.calendarDao.updateCalendar(calendar);
  }

  @override
  Future<List<Calendar>> getAllActiveCalendars() async {
    return await _database.calendarDao.getAllActiveCalendars(true);
  }
}
