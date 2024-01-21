import 'dart:math';

import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/domain/repositories/calendar_repository.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:auto_silent_app/presentation/utils/date_time_util.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalendarCubit extends Cubit<CalendarStates> {
  final CalendarRepository _calendarRepository;
  CalendarCubit(this._calendarRepository) : super(const CalendarLoading());

  void getCalendarStream() {
    emit(CalendarLoaded(_calendarRepository.getAllCalendarStream()));
  }

  Future<void> insertCalendar(
      {required String title,
      required TimeOfDay startTime,
      required TimeOfDay endTime,
      required DateTime date}) async {
    await _calendarRepository.insertCalendar(
        calendar: Calendar(
            id: Random().nextInt(1500) + 1000,  // random number from 1000 to 1500
            title: title,
            startTime: DateTime.now().applied(startTime),
            endTime: DateTime.now().applied(endTime),
            dateTime: date));
  }

  Future<void> updateCalendar({required Calendar calendar}) async {
    await _calendarRepository.updateCalendar(calendar: calendar);
  }

  Future<void> switchCalendar({required Calendar calendar}) async {
    final List<Calendar> activeCalendars =
        await _calendarRepository.getAllActiveCalendar();

    if (activeCalendars.length > 3) {
      emit(const CalendarError("Can't have more than 3 active calendars"));
    } else {
      final currentState = calendar.isActive;
      if (currentState) {
        _calendarRepository.removeExactAlarm(calendar: calendar);
        updateCalendar(calendar: calendar.copyWith(isActive: !currentState));
      } else {
        _calendarRepository.setExactAlarm(calendar: calendar);
        updateCalendar(calendar: calendar.copyWith(isActive: !currentState));
      }
    }
  }
}
