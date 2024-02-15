import 'package:auto_silent_app/data/data_source/floor/app_database.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:injectable/injectable.dart';

abstract class SessionLocalDataSource {
  Future<void> insertSession({required Session session});

  Future<void> updateSession({required Session session});

  Future<void> deleteSession({required Session session});

  Stream<List<Session>> getAllSessions();

  // Stream<List<Session>> getSessionByDay({required DayOfTheWeek day});

  Future<List<Session>> getAllActiveSessions();
}

@LazySingleton(as: SessionLocalDataSource)
class SessionLocalDataSourceImpl extends SessionLocalDataSource {
  final AppDatabase _database;

  SessionLocalDataSourceImpl(this._database);
  @override
  Future<void> deleteSession({required Session session}) async {
    try {
      await _database.sessionDao.deleteSession(session);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<Session>> getAllSessions() {
    try {
      return _database.sessionDao.getAllSessionStream();
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Stream<List<Session>> getSessionByDay({required DayOfTheWeek day}) {
  //   // return _database.sessionDao.getSessionByDayStram(day);
  // }

  @override
  Future<void> insertSession({required Session session}) async {
    try {
      await _database.sessionDao.insertSession(session);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSession({required Session session}) async {
    try {
      await _database.sessionDao.updateSession(session);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Session>> getAllActiveSessions() async {
    try {
      return await _database.sessionDao.getAllActiveSession(true);
    } catch (e) {
      rethrow;
    }
  }
}
