import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:auto_silent_app/domain/repositories/calendar_repository.dart';
import 'package:auto_silent_app/presentation/cubits/calendar_cubit/calendar_states.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalendarsCubit extends Cubit<CalendarStates> {
  final CalendarRepository _calendarRepository;
  CalendarsCubit(this._calendarRepository) : super(const CalendarLoading());

  void getCalendarStream() {
    emit(CalendarLaoded(_calendarRepository.getAllCalendarStream())) ;
  }

  Future<void> insertCalendar({required Calendar calendar}) async {
    await _calendarRepository.insertCalendar(calendar: calendar);
  }

  Future<void> updateCalendar({required Calendar calendar}) async {
    await _calendarRepository.updateCalendar(calendar: calendar);
  }
}
