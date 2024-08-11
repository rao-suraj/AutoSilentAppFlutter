import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:either_dart/either.dart';

abstract class SessionRepository {
  Future<void> insertSession({required Session session});

  Future<void> updateSession({required Session session});

  Future<Either<AppError, void>> deleteSession({required Session session});

  Stream<List<Session>> getAllSessionStream();

  // Stream<List<Session>> getAllSessionByDay({required DayOfTheWeek day});

  Future<List<Session>> getAllActiveSession();

  Future<Either<AppError, void>> setSession({required Session session});

  Future<Either<AppError,void>> removeSession({required Session session});
}
