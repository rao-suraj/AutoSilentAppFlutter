import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auto_silent_app_flutter/domain/repositories/permission_repository.dart';
import 'package:auto_silent_app_flutter/presentation/utils/get_permissions.dart';

class MockPermissionRepository extends Mock implements PermissionRepository {}

void main() {
  late MockPermissionRepository repo;

  setUp(() {
    repo = MockPermissionRepository();
  });

  test('returns true if already granted', () async {
    when(() => repo.isPermissionGranted()).thenAnswer((_) async => true);

    final result = await checkAndRequestPermission(repo);

    expect(result, true);
    verifyNever(() => repo.requestPermission());
  });

  test('requests permission when not granted', () async {
    when(() => repo.isPermissionGranted()).thenAnswer((_) async => false);
    when(() => repo.requestPermission()).thenAnswer((_) async => true);

    final result = await checkAndRequestPermission(repo);

    expect(result, true);
    verify(() => repo.requestPermission()).called(1);
  });

  test('returns false if user denies permission', () async {
    when(() => repo.isPermissionGranted()).thenAnswer((_) async => false);
    when(() => repo.requestPermission()).thenAnswer((_) async => false);

    final result = await checkAndRequestPermission(repo);

    expect(result, false);
  });
}
