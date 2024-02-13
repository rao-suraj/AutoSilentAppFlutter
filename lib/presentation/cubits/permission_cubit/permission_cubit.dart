import 'package:auto_silent_app/domain/repositories/permission_repository.dart';
import 'package:auto_silent_app/presentation/cubits/permission_cubit/permission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PermissionCubit extends Cubit<PermissionStates> {
  final PermissionRepository _permissionRepo;
  PermissionCubit(this._permissionRepo) : super(const PermissionLoading());

  Future<void> getPermissions() async {
    bool? dndPermission = await _permissionRepo.isDNDGranted();

    bool? alarmPermission = await _permissionRepo.isSetExactAlarmGranted();

    emit(PermissionLoaded(
        isDNDGranted: dndPermission, isSetExactAlarmGranted: alarmPermission));
  }

  Future<void> askDNDPermission() async {
    final bool? isGranted = await _permissionRepo.askDNDPermission();
    emit(PermissionLoaded(
        isDNDGranted: isGranted,
        isSetExactAlarmGranted: state.isSetExactAlarmGranted));
  }

  Future<void> askAlarmPermission() async {
    final bool? isGranted = await _permissionRepo.askSetExactPermission();
    emit(PermissionLoaded(
        isDNDGranted: state.isDNDGranted,
        isSetExactAlarmGranted: isGranted ?? false));
  }
}
