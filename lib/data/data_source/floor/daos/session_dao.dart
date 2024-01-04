import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/domain/utils/enums.dart';
import 'package:floor/floor.dart';

@dao
abstract class SessionDao {
  @insert
  Future<void> insertSession(Session session);

  @delete
  Future<void> deleteSession(Session session);

  @update
  Future<void> updateSession(Session session);

  @Query('SELECT * FROM Session')
  Stream<List<Session>> getAllSessionStream();

  @Query('SELECT * FROM Session WHERE sunday IS :isTrue')
  Stream<List<Session>> getSundaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE monday IS :isTrue')
  Stream<List<Session>> getMondaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE tuesday IS :isTrue')
  Stream<List<Session>> getTuesdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE wednesday IS :isTrue')
  Stream<List<Session>> getWednesdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE thursday IS :isTrue')
  Stream<List<Session>> getThursdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE friday IS :isTrue')
  Stream<List<Session>> getFridaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE saturday IS :isTrue')
  Stream<List<Session>> getSaturdaySession(bool isTrue);

  Stream<List<Session>> getSessionByDay(DayOfTheWeek day) {
    switch (day) {
      case DayOfTheWeek.sunday:
        return getSundaySession(true);
      case DayOfTheWeek.monday:
        return getMondaySession(true);
      case DayOfTheWeek.tuesday:
        return getTuesdaySession(true);
      case DayOfTheWeek.wednesday:
        return getWednesdaySession(true);
      case DayOfTheWeek.thusdays:
        return getThursdaySession(true);
      case DayOfTheWeek.friday:
        return getFridaySession(true);
      case DayOfTheWeek.saterday:
        return getSaturdaySession(true);
      default:
        throw Exception('invalid day');
    }
  }
}
