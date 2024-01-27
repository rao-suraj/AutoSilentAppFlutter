import 'package:auto_silent_app/data/data_source/local_data_source/calendar_local_data_source.dart';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/data/services/calendar_services.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:auto_silent_app/data/utils/call_with_error.dart';
import 'package:auto_silent_app/domain/repositories/calendar_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CalendarRepository)
class CalendarRepositoryImpl extends CalendarRepository {
  final CalandarLocalDataSource _calendarLocalDataSource;
  final CalendarServices _calendarServices;

  CalendarRepositoryImpl(this._calendarLocalDataSource, this._calendarServices);
  @override
  Future<void> deleteCalendar({required int id}) async {
    await _calendarLocalDataSource.deleteCalendar(id: id);
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

  @override
  Future<List<Calendar>> getAllActiveCalendar() async {
    return await _calendarLocalDataSource.getAllActiveCalendars();
  }

  @override
  Future<Either<AppError,void>> setExactAlarm({required Calendar calendar}) async {
    // add the date to both startTime and endTime
    // calendar.startTime.copyWith(
    //     year: calendar.dateTime.year,
    //     month: calendar.dateTime.month,
    //     day: calendar.dateTime.day);

    // calendar.endTime.copyWith(
    //     year: calendar.dateTime.year,
    //     month: calendar.endTime.month,
    //     day: calendar.endTime.day);
    return await CallWithError.call(() => _calendarServices.setAlarm(
        id: calendar.id,
        startDate: calendar.startTime,
        endDate: calendar.endTime));
    
  }

  @override
  Future<Either<AppError,void>> removeExactAlarm({required Calendar calendar}) async {
    return await CallWithError.call(() => _calendarServices.removeAlarm(id: calendar.id));
  }
}
