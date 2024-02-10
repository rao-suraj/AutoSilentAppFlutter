import 'package:auto_silent_app/data/services/permission_services.dart';
import 'package:auto_silent_app/domain/repositories/permission_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PermissionRepository)
class PermissionRepositoryImpl extends PermissionRepository {
  final PermissionServices _permissionServices;
  PermissionRepositoryImpl(this._permissionServices);
  @override
  Future<bool?> askDNDPermission() async {
    return await _permissionServices.askDNDPermission();
  }

  @override
  Future<bool?> askSetExactPermission() async {
    return await _permissionServices.askSetExactPermission();
  }

  @override
  Future<bool?> isDNDGranted() async{
    return await _permissionServices.isDNDGranted();
  }

  @override
  Future<bool?> isSetExactAlarmGranted() async{
    return await _permissionServices.isSetExactAlarmGranted();
  }
}
