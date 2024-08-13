import 'package:auto_silent_app/data/models/session.dart';
import 'package:equatable/equatable.dart';

class SessionStates extends Equatable {
  const SessionStates();

  @override
  List<Object?> get props => [];
}

class SessionLoading extends SessionStates {
  const SessionLoading();
}

class SessionLoaded extends SessionStates {
  final Stream<List<Session>> sessionStream;
  const SessionLoaded(this.sessionStream);

  @override
  List<Object?> get props => [sessionStream];
}

class SessionError extends SessionStates {
  final String errorMessage;
  const SessionError(this.errorMessage);
}
