import 'package:auto_silent_app/data/models/profile.dart';
import 'package:equatable/equatable.dart';

class ProfileStates extends Equatable {
  const ProfileStates();

  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileStates {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileStates {
  final Stream<List<Profile>> profileStream;

  const ProfileLoaded(this.profileStream);

  @override
  List<Object?> get props => [profileStream];
}

class ProfileSuccess extends ProfileStates {
  final String message;
  const ProfileSuccess(this.message);
}

class ProfileError extends ProfileStates {
  final String errorMessage;
  const ProfileError(this.errorMessage);
}
