import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/domain/repositories/calendar_repository.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalendarCubit extends Cubit<CalendarStates> {
  final CalendarRepository _calendarRepository;
  CalendarCubit(this._calendarRepository) : super(const CalendarLoading());

  void getCalendarStream() {
    emit(CalendarLaoded(_calendarRepository.getAllCalendarStream()));
  }

  Future<void> insertCalendar({required Calendar calendar}) async {
    await _calendarRepository.insertCalendar(calendar: calendar);
  }

  Future<void> updateCalendar({required Calendar calendar}) async {
    await _calendarRepository.updateCalendar(calendar: calendar);
  }

  Future<void> switchCalendar({required Calendar calendar}) async {
    final List<Calendar> activeCalendars =
        await _calendarRepository.getAllActiveCalendar();

    if (activeCalendars.length > 3) {
      emit(CalendarError("Can't have more than 3 active calendars"));
    } else {
      final currentState = calendar.isActive;
      if (currentState) {
        // remove the calendar TO DO:
        updateCalendar(calendar: calendar.copyWith(isActive: !currentState));
      } else {
        // add the Calendar TO DO:
        updateCalendar(calendar: calendar.copyWith(isActive: !currentState));
      }
      getCalendarStream();
    }
  }
}
