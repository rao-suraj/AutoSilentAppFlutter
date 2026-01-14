import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auto_silent_app_flutter/data/repositories/session_repository_impl.dart';
import 'package:auto_silent_app_flutter/data/data_source/local_data_source/session_local_data_source.dart';
import 'package:auto_silent_app_flutter/data/models/session.dart';

class MockSessionLocalDataSource extends Mock implements SessionLocalDataSource {}

void main() {
  late MockSessionLocalDataSource local;
  late SessionRepositoryImpl repo;

  setUp(() {
    local = MockSessionLocalDataSource();
    repo = SessionRepositoryImpl(local);
  });

  test('getSessions returns list from local source', () async {
    final sessions = [Session(id: 1, name: 'Office', start: 9, end: 17)];

    when(() => local.getSessions()).thenAnswer((_) async => sessions);

    final result = await repo.getSessions();

    expect(result, sessions);
  });
}
