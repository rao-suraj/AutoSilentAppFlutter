import 'dart:math';
import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/data/utils/app_error.dart';
import 'package:auto_silent_app/domain/repositories/calendar_repository.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
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
    DateTime startDateTime = DateTime.now();
    DateTime endDateTime = DateTime.now();
    startDateTime = startDateTime.copyWith(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: startTime.hour,
        minute: startTime.minute,
        second: 0);

    endDateTime = endDateTime.copyWith(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: endTime.hour,
        minute: endTime.minute,
        second: 0);

    // print(date);
    // print(startDateTime);
    // print(endDateTime);

    // print((startDateTime.isAfter(DateTime.now())));
    // print(startDateTime.isBefore(endDateTime));

    if (startDateTime.isAfter(DateTime.now()) &&
        startDateTime.isBefore(endDateTime)) {
      await _calendarRepository.insertCalendar(
          calendar: Calendar(
              id: Random().nextInt(1500) + 1000,
              // random number from 1000 to 1500
              title: title,
              startTime: startDateTime,
              endTime: endDateTime,
              dateTime: date));
      emit(const CalendarSuccess("Inserted Successfully"));
    } else {
      emit(const CalendarError("Entered date or time in not correct "));
    }
    getCalendarStream();
  }

  Future<void> updateCalendar({required Calendar calendar}) async {
    await _calendarRepository.updateCalendar(calendar: calendar);
  }

  Future<void> switchCalendar({required Calendar calendar}) async {
    if (calendar.startTime.isBefore(DateTime.now())) {
      await _calendarRepository.deleteCalendar(id: calendar.id);
      emit(const CalendarError("Time has already passed"));
      getCalendarStream();
      return;
    }
    late List<Calendar> activeCalendars;
    final response = await _calendarRepository.getAllActiveCalendar();
    response.fold((left) {
      emit(CalendarError(left.message!));
      getCalendarStream();
      return;
    }, (right) => activeCalendars = right);

    if (calendar.isActive) {
      await removeCalendar(calendar: calendar);
    } else {
      if (activeCalendars.length >= 3) {
        emit(const CalendarError("Can't have more than 3 active calendars"));
        getCalendarStream();
        return;
      } else {
        await setCalendar(calendar: calendar);
      }
    }
  }

  Future<void> removeCalendar({required Calendar calendar}) async {
    final Either<AppError, void> response =
        await _calendarRepository.removeExactAlarm(calendar: calendar);
    response.fold((left) {
      emit(CalendarError(left.message!));
      getCalendarStream();
      return;
    }, (right) {
      updateCalendar(calendar: calendar.copyWith(isActive: !calendar.isActive));
      // emit(const CalendarSuccess("Calendar removed successfully"));
    });
  }

  Future<void> setCalendar({required Calendar calendar}) async {
    final Either<AppError, void> response =
        await _calendarRepository.setExactAlarm(calendar: calendar);
    response.fold((left) {
      emit(CalendarError(left.message!));
      getCalendarStream();
    }, (right) {
      updateCalendar(calendar: calendar.copyWith(isActive: !calendar.isActive));
      // emit(const CalendarSuccess("Calendar added successfully"));
    });
  }

  Future<void> removeExpiredCalendar() async {
    await _calendarRepository.removeExpiredCalendar(time: DateTime.now());
  }

  Future<void> deleteCalendar({required Calendar calendar}) async {
    final response = await _calendarRepository.deleteCalendar(id: calendar.id);

    response.fold((left) {
      emit(CalendarError(left.message!));
      getCalendarStream();
    }, (right) => null);
  }
}
