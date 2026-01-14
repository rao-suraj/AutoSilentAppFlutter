import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auto_silent_app/presentation/utils/get_permissions.dart';

class MockPermissionService extends Mock implements PermissionService {}

void main() {
  late MockPermissionService service;

  setUp(() {
    service = MockPermissionService();
  });

  test('returns true when permission already granted', () async {
    when(() => service.isGranted()).thenAnswer((_) async => true);

    final result = await ensurePermission(service);

    expect(result, true);
    verifyNever(() => service.request());
  });

  test('requests permission when not granted', () async {
    when(() => service.isGranted()).thenAnswer((_) async => false);
    when(() => service.request()).thenAnswer((_) async => true);

    final result = await ensurePermission(service);

    expect(result, true);
    verify(() => service.request()).called(1);
  });
}
