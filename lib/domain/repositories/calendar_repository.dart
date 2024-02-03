import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:either_dart/either.dart';

abstract class CalendarRepository {
  Future<Either<AppError, void>> insertCalendar({required Calendar calendar});

  Future<Either<AppError, void>> updateCalendar({required Calendar calendar});

  Future<Either<AppError, void>> deleteCalendar({required int id});

  Stream<List<Calendar>> getAllCalendarStream();

  Future<Either<AppError, List<Calendar>>> getAllActiveCalendar();

  Future<Either<AppError, void>> setExactAlarm({required Calendar calendar});

  Future<Either<AppError, void>> removeExactAlarm({required Calendar calendar});

  Future<void> removeExpiredCalendar({required DateTime time});
}
