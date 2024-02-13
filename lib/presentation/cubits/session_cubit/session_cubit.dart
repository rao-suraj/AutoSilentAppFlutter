import 'dart:io';
import 'dart:math';
import 'package:auto_silent_app/data/models/session.dart';
import 'package:auto_silent_app/data/utils/work_manager_constants.dart';
import 'package:auto_silent_app/domain/repositories/session_repository.dart';
import 'package:auto_silent_app/presentation/cubits/session_cubit/session_states.dart';
import 'package:auto_silent_app/presentation/utils/date_time_util.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:jiffy/jiffy.dart';
import 'package:workmanager/workmanager.dart';

@injectable
class SessionCubit extends Cubit<SessionStates> {
  final SessionRepository _sessionRepository;
  SessionCubit(this._sessionRepository) : super(const SessionLoading());

  void getSessionsStream() {
    emit(SessionLoaded(_sessionRepository.getAllSessionStream()));
  }

  Future<void> insertSession(
      {required String title,
      required TimeOfDay stTime,
      required TimeOfDay edTime,
      required List<bool> daysOfWeek}) async {
    final startTime = DateTime.now().applied(stTime);
    final endTime = DateTime.now().applied(edTime);
    if (startTime.isBefore(endTime)) {
      _sessionRepository.insertSession(
        session: Session(
            id: Random().nextInt(1000) + 500, // Random number from 500 to 1000
            title: title,
            startTime: startTime,
            endTime: endTime,
            sunday: daysOfWeek[0],
            monday: daysOfWeek[1],
            tuesday: daysOfWeek[2],
            wednesday: daysOfWeek[3],
            thursday: daysOfWeek[4],
            friday: daysOfWeek[5],
            saturday: daysOfWeek[6]),
      );
    } else {
      emit(const SessionError("Start time can't be greater then end time"));
      getSessionsStream();
    }
  }

  void updateSession({required Session session}) {
    _sessionRepository.updateSession(session: session);
  }

  Future<void> setSession() async {
    // Right now Workmanager is only cofigured for android.
    Workmanager().cancelAll();
    DateTime targetTime =
        DateTime.now().copyWith(hour: 3, minute: 0, second: 0);
    if (DateTime.now().isAfter(targetTime)) {
      // add a day to the target time
      targetTime = Jiffy.parseFromDateTime(targetTime).add(days: 1).dateTime;
    }
    // print(targetTime.difference(DateTime.now()));
    if (Platform.isAndroid) {
      await Workmanager().registerPeriodicTask(
          WorkManagerConstants.workManagerTaskName,
          WorkManagerConstants.workManagerTaskName,
          frequency: const Duration(hours: 24),
          existingWorkPolicy: ExistingWorkPolicy.replace,
          backoffPolicy: BackoffPolicy.linear,
          initialDelay: targetTime.difference(DateTime.now()),
          backoffPolicyDelay: const Duration(minutes: 10),
          constraints: Constraints(
              networkType: NetworkType.not_required,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresDeviceIdle: false,
              requiresStorageNotLow: false));
    } else {
      // have to add the fuctionality for IOS
    }
  }

  Future<void> switchIsActive({required Session session}) async {
    final bool currect = session.isActive;

    // if current state is not active and more than three sessions are active then return else switch the isActive
    if (!currect) {
      final activeList = await getAllActiveSession();
      if (activeList.length >= 3) {
        emit(const SessionError("Can't have more than 3 active sessions"));
        getSessionsStream();
        return;
      }
    }

    await _sessionRepository.updateSession(
        session: session.copyWith(isActive: !currect));
  }

  Future<List<Session>> getAllActiveSession() async {
    return await _sessionRepository.getAllActiveSession();
  }
}
