import 'package:auto_silent_app/data/data_source/local_data_source/session_local_data_source.dart';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/data/services/session_services.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:auto_silent_app/data/utils/call_with_error.dart';
import 'package:auto_silent_app/domain/repositories/session_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl extends SessionRepository {
  final SessionLocalDataSource _sessionLocalDataSource;
  final SessionServices _sessionServices;

  SessionRepositoryImpl(this._sessionLocalDataSource, this._sessionServices);
  @override
  Future<Either<AppError, void>> deleteSession(
      {required Session session}) async {
    return CallWithError.call(
        () => _sessionLocalDataSource.deleteSession(session: session));
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

  @override
  Future<Either<AppError, void>> removeSession(
      {required Session session}) async {
    return await CallWithError.call(() => _sessionServices.setSession(
        id: session.id,
        startDate: session.startTime,
        endDate: session.endTime));
  }

  @override
  Future<Either<AppError, void>> setSession({required Session session}) async {
    return await CallWithError.call(() => _sessionServices.removeSession(id: session.id));
  }
}
