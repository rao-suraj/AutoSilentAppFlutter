import 'package:auto_silent_app/data/data_source/local_data_source/session_local_data_source.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/domain/repositories/session_repository.dart';
import 'package:auto_silent_app/domain/utils/enums.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl extends SessionRepository {
  final SessionLocalDataSource _sessionLocalDataSource;

  SessionRepositoryImpl(this._sessionLocalDataSource);
  @override
  Future<void> deleteSession({required Session session}) async {
    await _sessionLocalDataSource.deleteSession(session: session);
  }

  @override
  Stream<List<Session>> getAllSessionByDay({required DayOfTheWeek day}) {
    return _sessionLocalDataSource.getSessionByDay(day: day);
  }

  @override
  Stream<List<Session>> getAllSessionStream() {
    return _sessionLocalDataSource.getAllSessions();
  }

  @override
  Future<void> insertSession({required Session session}) async {
    await _sessionLocalDataSource.insertSession(session: session);
  }

  @override
  Future<void> updateSession({required Session session}) async {
    await _sessionLocalDataSource.updateSession(session: session);
  }
}
