import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/domain/repositories/session_repository.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SessionCubit extends Cubit<SessionStates> {
  final SessionRepository _sessionRepository;
  SessionCubit(this._sessionRepository) : super(const SessionLoading());

  void getSessionsStream() {
    emit(SessionLoaded(_sessionRepository.getAllSessionStream()));
  }

  void insertSession({required Session session}) {
    _sessionRepository.insertSession(session: session);
  }

  void updateSession({required Session session}) {
    _sessionRepository.updateSession(session: session);
  }
}
