import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:injectable/injectable.dart';

abstract class CalandarLocalDataSource {
  Future<void> insertCalendar({required Calendar calendar});

  Future<void> updateCalendar({required Calendar calendar});

  Future<void> deleteCalendar({required Calendar calendar});

  Stream<List<Calendar>> getAllCalendarStream();
}

@LazySingleton(as: CalandarLocalDataSource)
class CalendarLocalDataSourceImpl extends CalandarLocalDataSource {
  final AppDatabase _database;
  CalendarLocalDataSourceImpl(this._database);
  @override
  Future<void> deleteCalendar({required Calendar calendar}) async {
    await _database.calandarDao.deleteCalendar(calendar);
  }

  @override
  Stream<List<Calendar>> getAllCalendarStream() {
    return _database.calandarDao.getAllCalandarStream();
  }

  @override
  Future<void> insertCalendar({required Calendar calendar}) async {
    await _database.calandarDao.insertCalendar(calendar);
  }

  @override
  Future<void> updateCalendar({required Calendar calendar}) async {
    await _database.calandarDao.updateCalendar(calendar);
  }
}