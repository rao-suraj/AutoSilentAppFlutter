import 'package:auto_silent_app/data/data_source/local_data_source/session_local_data_source.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:auto_silent_app/data/utils/call_with_error.dart';
import 'package:auto_silent_app/domain/repositories/session_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl extends SessionRepository {
  final SessionLocalDataSource _sessionLocalDataSource;

  SessionRepositoryImpl(this._sessionLocalDataSource);
  @override
  Future<Either<AppError,void>> deleteSession({required Session session}) async {
    return CallWithError.call(() => _sessionLocalDataSource.deleteSession(session: session));
  }

  // @override
  // Stream<List<Session>> getAllSessionByDay({required DayOfTheWeek day}) {
  //   return _sessionLocalDataSource.getSessionByDay(day: day);
  // }

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
  
  @override
  Future<List<Session>> getAllActiveSession() async {
    return await _sessionLocalDataSource.getAllActiveSessions();
  }
}
