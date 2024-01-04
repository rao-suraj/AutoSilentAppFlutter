import 'package:auto_silent_app/data/data_source/local_data_source/calendar_local_data_source.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/domain/repositories/calendar_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CalendarRepository)
class CalendarRepositoryImpl extends CalendarRepository {
  final CalandarLocalDataSource _calendarLocalDataSource;

  CalendarRepositoryImpl(this._calendarLocalDataSource);
  @override
  Future<void> deleteCalendar({required Calendar calendar}) async {
    await _calendarLocalDataSource.deleteCalendar(calendar: calendar);
  }

  @override
  Future<void> insertCalendar({required Calendar calendar}) async {
    await _calendarLocalDataSource.insertCalendar(calendar: calendar);
  }

  @override
  Future<void> updateCalendar({required Calendar calendar}) async {
    await _calendarLocalDataSource.updateCalendar(calendar: calendar);
  }
  @override
  Stream<List<Calendar>> getAllCalendarStream() {
    return _calendarLocalDataSource.getAllCalendarStream();
  }
}
