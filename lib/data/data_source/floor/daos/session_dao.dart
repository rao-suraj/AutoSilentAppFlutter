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
  Stream<List<Session>> getSundaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE monday IS :isTrue')
  Stream<List<Session>> getMondaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE tuesday IS :isTrue')
  Stream<List<Session>> getTuesdaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE wednesday IS :isTrue')
  Stream<List<Session>> getWednesdaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE thursday IS :isTrue')
  Stream<List<Session>> getThursdaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE friday IS :isTrue')
  Stream<List<Session>> getFridaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE saturday IS :isTrue')
  Stream<List<Session>> getSaturdaySessionStream(bool isTrue);

  @Query('SELECT * FROM Session WHERE sunday IS :isTrue')
  Future<List<Session>> getSundaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE monday IS :isTrue')
  Future<List<Session>> getMondaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE tuesday IS :isTrue')
  Future<List<Session>> getTuesdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE wednesday IS :isTrue')
  Future<List<Session>> getWednesdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE thursday IS :isTrue')
  Future<List<Session>> getThursdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE friday IS :isTrue')
  Future<List<Session>> getFridaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE saturday IS :isTrue')
  Future<List<Session>> getSaturdaySession(bool isTrue);

  @Query('SELECT * FROM Session WHERE isActive IS :isTrue')
  Future<List<Session>> getAllActiveSession(bool isTrue);

  Stream<List<Session>> getSessionByDayStram(DayOfTheWeek day) {
    switch (day) {
      case DayOfTheWeek.sunday:
        return getSundaySessionStream(true);
      case DayOfTheWeek.monday:
        return getMondaySessionStream(true);
      case DayOfTheWeek.tuesday:
        return getTuesdaySessionStream(true);
      case DayOfTheWeek.wednesday:
        return getWednesdaySessionStream(true);
      case DayOfTheWeek.thursdays:
        return getThursdaySessionStream(true);
      case DayOfTheWeek.friday:
        return getFridaySessionStream(true);
      case DayOfTheWeek.thursdays:
        return getSaturdaySessionStream(true);
      default:
        throw Exception('invalid day');
    }
  }

    Future<List<Session>> getSessionByDay(DayOfTheWeek day) {
    switch (day) {
      case DayOfTheWeek.sunday:
        return getSundaySession(true);
      case DayOfTheWeek.monday:
        return getMondaySession(true);
      case DayOfTheWeek.tuesday:
        return getTuesdaySession(true);
      case DayOfTheWeek.wednesday:
        return getWednesdaySession(true);
      case DayOfTheWeek.thursdays:
        return getThursdaySession(true);
      case DayOfTheWeek.friday:
        return getFridaySession(true);
      case DayOfTheWeek.saturday:
        return getSaturdaySession(true);
      default:
        throw Exception('invalid day');
    }
  }
}
