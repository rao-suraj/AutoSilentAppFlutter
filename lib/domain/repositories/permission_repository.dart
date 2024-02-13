abstract class PermissionRepository {
  Future<bool?> isDNDGranted();

  Future<bool?> isSetExactAlarmGranted();

  Future<bool?> askDNDPermission();

  Future<bool?> askSetExactPermission();
}
