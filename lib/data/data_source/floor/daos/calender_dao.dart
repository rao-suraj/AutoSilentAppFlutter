import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:floor/floor.dart';

@dao
abstract class CalendarDao {
  @insert
  Future<void> insertCalendar(Calendar calendar);

  @Query('DELETE from Calendar WHERE id = :id')
  Future<void> deleteCalendar(int id);

  @update
  Future<void> updateCalendar(Calendar calendar);

  @Query('SELECT * FROM Calendar')
  Stream<List<Calendar>> getAllCalendarStream();

  @Query('SELECT * FROM Calendar WHERE isActive = :isActive')
  Future<List<Calendar>> getAllActiveCalendars(bool isActive);
}
