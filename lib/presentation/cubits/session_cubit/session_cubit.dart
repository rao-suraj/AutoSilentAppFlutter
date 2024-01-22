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

  Future<void> setSession() async {
    // Right now Workmanager is only cofigured for android.
    // if (Platform.isAndroid) {
    //   await Workmanager().registerPeriodicTask(
    //       WorkManagerConstants.workManagerTaskName,WorkManagerConstants.workManagerTaskName,
    //       existingWorkPolicy: ExistingWorkPolicy.replace,
    //       backoffPolicy: BackoffPolicy.linear,
    //       backoffPolicyDelay: const Duration(minutes: 10),
    //       constraints: Constraints(
    //           networkType: NetworkType.not_required,
    //           requiresBatteryNotLow: false,
    //           requiresCharging: false,
    //           requiresDeviceIdle: false,
    //           requiresStorageNotLow: false));
    // } else {
    //   // have to add the fuctionality for IOS
    // }
  }

  Future<void> switchIsActive({required Session session}) async {
    final bool currect = session.isActive;
    await _sessionRepository.updateSession(
        session: session.copyWith(isActive: !currect));
  }
}
