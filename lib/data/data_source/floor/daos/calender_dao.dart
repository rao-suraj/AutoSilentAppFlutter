import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:floor/floor.dart';

@dao
abstract class CalendarDao {
  @insert
  Future<void> insertCalendar(Calendar calandar);

  @delete
  Future<void> deleteCalendar(Calendar calandar);

  @update
  Future<void> updateCalendar(Calendar calandar);

  @Query('SELECT * FROM Calendar')
  Stream<List<Calendar>> getAllCalandarStream();
}
