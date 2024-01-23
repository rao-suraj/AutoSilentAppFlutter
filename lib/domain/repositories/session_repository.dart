import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/domain/utils/enums.dart';

abstract class SessionRepository {
  Future<void> insertSession({required Session session});

  Future<void> updateSession({required Session session});

  Future<void> deleteSession({required Session session});

  Stream<List<Session>> getAllSessionStream();

  Stream<List<Session>> getAllSessionByDay({required DayOfTheWeek day});

  Future<List<Session>> getAllActiveSession();
}
