import 'package:equatable/equatable.dart';

class PermissionStates extends Equatable {
  final bool? isDNDGranted;
  final bool? isSetExactAlarmGranted;

  const PermissionStates({this.isDNDGranted, this.isSetExactAlarmGranted});

  @override
  List<Object?> get props => [isDNDGranted, isSetExactAlarmGranted];
}

class PermissionLoaded extends PermissionStates {
  const PermissionLoaded({super.isDNDGranted, super.isSetExactAlarmGranted});
}

class PermissionLoading extends PermissionStates {
  const PermissionLoading();
}

