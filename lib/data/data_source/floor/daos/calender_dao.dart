import 'package:auto_silent_app/data/models/calender.dart';
import 'package:floor/floor.dart';

@dao
abstract class CalenderDao {
  @insert
  Future<void> insertCalender(Calender calander);

  @delete
  Future<void> deleteCalender(Calender calander);

  @update
  Future<void> updateCalender(Calender calander);

  @Query('SELECT * FROM Calander')
  Stream<List<Calender>> getAllCalanderStream();
}
