import 'package:auto_silent_app/data/models/calendar.dart';
import 'package:equatable/equatable.dart';

class CalendarStates extends Equatable {
  const CalendarStates();

  @override
  List<Object?> get props => [];
}

class CalendarLoading extends CalendarStates {
  const CalendarLoading();
}

class CalendarLoaded extends CalendarStates {
  final Stream<List<Calendar>> calendarStream;

  const CalendarLoaded(this.calendarStream);

  @override
  // TODO: implement props
  List<Object?> get props => [calendarStream];
}

class CalendarError extends CalendarStates {
  final String errorMessage;
  const CalendarError(this.errorMessage);
}
